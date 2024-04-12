import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

class CryptoUtility {
  String pub_key = "";
  String pri_key = "";

  CryptoUtility(){}

  Future getPublicKey(String pub_key) async {
    this.pub_key = pub_key;
    final parser = RSAKeyParser();
    return parser.parse(pub_key);
  }

  Future getPrivateKey(String pri_key) async {
    this.pri_key = pri_key;
    final parser = RSAKeyParser();
    return parser.parse(pri_key);
  }

  Future writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}