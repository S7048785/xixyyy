import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xixyyy_sign/models/login_response.dart';

class UserStore extends GetxController {
  static const String _keyUserInfo = 'user_info';
  static const String _keyToken = 'token';
  static const String _keyLatitude = 'latitude';
  static const String _keyLongitude = 'longitude';
  static const String _keyAddress = 'address';
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keySchoolId = 'schoolId';

  final _isLogin = false.obs;
  final _userInfo = Rxn<LoginResponse>();
  final _latitude = "".obs;
  final _longitude = "".obs;
  final _address = "".obs;
  final _username = "".obs;
  final _password = "".obs;
  final _schoolId = "".obs;


  bool get isLogin => _isLogin.value;
  LoginResponse? get userInfo => _userInfo.value;
  String get address => _address.value;
  String get latitude => _latitude.value;
  String get username => _username.value;
  String get password => _password.value;
  String get longitude => _longitude.value;
  String get schoolId => _schoolId.value;

  /// 初始化，从本地读取用户信息
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoJson = prefs.getString(_keyUserInfo);
    _schoolId.value = prefs.getString(_keySchoolId) ?? "";
    _address.value = prefs.getString(_keyAddress) ?? "";
    _latitude.value = prefs.getString(_keyLatitude) ?? "";
    _longitude.value = prefs.getString(_keyLongitude) ?? "";
    _username.value = prefs.getString(_keyUsername) ?? "";
    _password.value = prefs.getString(_keyPassword) ?? "";
    if (userInfoJson != null) {
      _userInfo.value = LoginResponse.fromJson(jsonDecode(userInfoJson));
      _isLogin.value = true;
    }

  }

  /// 保存经纬度
  /// [latitude] 纬度
  /// [longitude] 经度
  Future<void> saveAddress(String address, String latitude, String longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAddress, address);
    await prefs.setString(_keyLatitude, latitude);
    await prefs.setString(_keyLongitude, longitude);
    _address.value = address;
    _latitude.value = latitude;
    _longitude.value = longitude;
  }

  /// 保存用户登录信息
  Future<void> saveUser(LoginResponse user, String username, String password, String schoolId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserInfo, jsonEncode(user.toJson()));
    await prefs.setString(_keyToken, user.token);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
    await prefs.setString(_keySchoolId, schoolId);
    _userInfo.value = user;
    _isLogin.value = true;
  }



  /// 清除用户信息（退出登录）
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserInfo);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyPassword);
    _userInfo.value = null;
    await prefs.remove(_keyLatitude);
    await prefs.remove(_keyLongitude);
    await prefs.remove(_keyAddress);
    await prefs.remove(_keySchoolId);
    _isLogin.value = false;
  }

  /// 获取 token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }
}
