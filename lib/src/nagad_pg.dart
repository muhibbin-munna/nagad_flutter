import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nagad_payment_gateway/src/api_resposne.dart';
import 'package:nagad_payment_gateway/src/credentials.dart';
import 'package:nagad_payment_gateway/src/crypto_utility.dart';
import 'package:intl/intl.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:nagad_payment_gateway/src/status_model.dart';
import 'package:nagad_payment_gateway/src/webview_pg.dart';

class Nagad {
  late http.Client client;
  Credentials credentials;
  Map<String, dynamic> additionalMerchantInfo = {};
  Nagad({required this.credentials});

  void setAdditionalMerchantInfo(Map<String, dynamic> additionalMerchantInfo) {
    this.additionalMerchantInfo = additionalMerchantInfo;
  }

  Future<StatusAPIResponse> pay(BuildContext context, {required int amount}) async {

    client = http.Client();

    String baseUrl = credentials.isSandbox
        ? "https://sandbox-ssl.mynagad.com"
        : "https://api.mynagad.com";

    final String kpgDefaultSeed = ("nagad-dfs-service-ltd${DateTime.now().millisecondsSinceEpoch}");
    try {
      CryptoUtility cryptoUtility = new CryptoUtility();
      final publicKey = await cryptoUtility.getPublicKey(
          '-----BEGIN PUBLIC KEY-----\n${credentials.pgPublicKey}\n-----END PUBLIC KEY-----');
      final privateKey = await cryptoUtility.getPrivateKey(
          "-----BEGIN PRIVATE KEY-----\n${credentials.merchantPrivateKey}\n-----END PRIVATE KEY-----");

      DateTime now = DateTime.now();
      int orderId = now.millisecondsSinceEpoch;
      String datetime = DateFormat('yyyyMMddHHmmss').format(now);
      Uint8List seedBytes = utf8.encode(kpgDefaultSeed);
      String random = generateRandomString(20, seedBytes);

      Map<String, dynamic> rawData = {
        'merchantId': credentials.merchantID,
        'orderId': orderId,
        'datetime': datetime,
        'challenge': random
      };

      String rawDataToBeEncrypted = jsonEncode(rawData);
      final encrypter =
          Encrypter(RSA(publicKey: publicKey, encoding: RSAEncoding.PKCS1));
      var sensitiveData = encrypter.encrypt(rawDataToBeEncrypted).base64;

      final signer =
          Signer(RSASigner(RSASignDigest.SHA256, privateKey: privateKey));
      var signature = signer.sign(rawDataToBeEncrypted).base64;

      http.Response response;
      try {
        response = await client.post(
          Uri.parse(
              '$baseUrl/api/dfs/check-out/initialize/${credentials.merchantID}/$orderId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-KM-IP-V4': '192.168.0.1',
            'X-KM-Client-Type': 'PC_WEB',
            'X-KM-Api-Version': 'v-0.2.0',
            "Access-Control-Allow-Origin": "*",
          },
          body: jsonEncode({
            'dateTime': datetime,
            'sensitiveData': sensitiveData,
            'signature': signature,
          }),
        );
      } catch (e) {
        throw 'Exception in Check Out Initialize API API $e';
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        sensitiveData = responseBody['sensitiveData'];
        signature = responseBody['signature'];

        final decrypter =
            Encrypter(RSA(privateKey: privateKey, encoding: RSAEncoding.PKCS1));
        final verifier =
            Signer(RSASigner(RSASignDigest.SHA256, publicKey: publicKey));

        var decryptedData = decrypter.decrypt64(sensitiveData);
        var verify = verifier.verify64(decryptedData, signature);

        if(verify){
          Map<String, dynamic> decryptedDataBody = json.decode(decryptedData);
          String challenge = decryptedDataBody['challenge'];
          String paymentReferenceId = decryptedDataBody['paymentReferenceId'];

          rawData.clear();
          rawData = {
            'merchantId': credentials.merchantID,
            'orderId': orderId.toString(),
            'currencyCode': '050',
            'amount': amount,
            'challenge': challenge
          };
          String rawDataToBeEncrypted = jsonEncode(rawData);
          sensitiveData = encrypter.encrypt(rawDataToBeEncrypted).base64;
          signature = signer.sign(rawDataToBeEncrypted).base64;

          try {
            response = await client.post(
              Uri.parse(
                  '$baseUrl/api/dfs/check-out/complete/$paymentReferenceId'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'X-KM-IP-V4': '192.168.0.1',
                'X-KM-Client-Type': 'PC_WEB',
                'X-KM-Api-Version': 'v-0.2.0',
              },
              body: jsonEncode({
                'sensitiveData': sensitiveData,
                'signature': signature,
                'merchantCallbackURL': 'https://www.callBackUrlFlutter.com/',
                'additionalMerchantInfo': additionalMerchantInfo,
              }),
            );
          } catch (e) {
            throw 'Exception in Check Out Complete API API $e';
          }

          if (response.statusCode == 200) {
            ApiResponse apiResponse = ApiResponse.fromJson(response.body);

            var paymentStatus = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewContainer(
                      callBackUrl: apiResponse.callBackUrl,
                      isSandbox: credentials.isSandbox)),
            );
            Map<String, dynamic> jsonMap = json.decode(paymentStatus);

            return(StatusAPIResponse.fromJson(jsonMap));

          } else {
            throw
            'Check Out Complete API failed with status: ${response.statusCode}, message: ${response.body}';
          }
        }
        else{
          throw 'Signature Verification Failed';
        }


      } else {
        throw
            'Check Out Initialize API failed with status: ${response.statusCode}, message: ${response.body}';
      }
    } catch (e) {
      throw 'Failed $e';
    }
  }

  String generateRandomString(int size, Uint8List seed) {
    Random random = Random();
    random = Random(seed.fold<int>(0, (p, c) => (p + c) & 0xFFFFFFFF));
    Uint8List secure = Uint8List(size);
    for (int i = 0; i < size; i++) {
      secure[i] = random.nextInt(256);
    }
    String hexString = HEX.encode(secure);
    return hexString;
  }
}
