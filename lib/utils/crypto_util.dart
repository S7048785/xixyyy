import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class CryptoUtils {
  static const String _publicKeyString = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDlYsiV3DsG+t8OFMLyhdmG2P2J
4GJwmwb1rKKcDZmTxEphPiYTeFIg4IFEiqDCATAPHs8UHypphZTK6LlzANyTzl9L
jQS6BYVQk81LhQ29dxyrXgwkRw9RdWaMPtcXRD4h6ovx6FQjwQlBM5vaHaJOHhEo
rHOSyd/deTvcS+hRSQIDAQAB
-----END PUBLIC KEY-----
''';

  /// 使用 RSA 公钥加密字符串，并返回 Base64 编码的结果
  static String rsaEncrypt(String data) {
    final parser = RSAKeyParser();
    final RSAPublicKey publicKey = parser.parse(_publicKeyString) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  /// 使用 RSA 公钥加密经纬度（习讯云签到需要）
  /// latitude 和 longitude 需要分别加密后返回
  static (String, String) encryptLocation(String latitude, String longitude) {
    return (rsaEncrypt(latitude), rsaEncrypt(longitude));
  }

  /// 简单的 Base64 编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  /// 简单的 Base64 解码
  static String decodeBase64(String data) {
    return utf8.decode(base64Decode(data));
  }
}
