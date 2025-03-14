import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

class CryptoUtility {
  String? publicKey;
  String? privateKey;

  CryptoUtility();

  Future getPublicKey(String pubKey) async {
    publicKey = pubKey;
    final parser = RSAKeyParser();
    return parser.parse(pubKey);
  }

  Future getPrivateKey(String priKey) async {
    privateKey = priKey;
    final parser = RSAKeyParser();
    return parser.parse(priKey);
  }

  Future writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
