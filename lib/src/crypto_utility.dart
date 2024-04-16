import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

class CryptoUtility {
  String pub_key = "";
  String pri_key = "";

  CryptoUtility();

  Future getPublicKey(String pubKey) async {
    pub_key = pubKey;
    final parser = RSAKeyParser();
    return parser.parse(pubKey);
  }

  Future getPrivateKey(String priKey) async {
    pri_key = priKey;
    final parser = RSAKeyParser();
    return parser.parse(priKey);
  }

  Future writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}