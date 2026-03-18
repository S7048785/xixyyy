import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:xixyyy_sign/pages/login/login_page.dart';

import '../models/login_response.dart';
import '../models/school_info.dart';
import '../models/sign_in.dart';

class ApiService {
  static final Dio _dio = Dio();

  // 1. 登录 (直接请求习讯云)
  static Future<LoginResponse> login(
    String account,
    String password,
    String schoolId,
  ) async {
      final response = await _dio.post(
        'https://api.xixunyun.com/login/api',
        data: {
          'account': account,
          'password': password,
          'school_id': schoolId,
          'app_version': '5.1.3',
          'registration_id': '',
          'uuid': 'fd9dc13a49cc850c',
          'request_source': '3',
          'platform': '2',
          'mac': '7C:F3:1B:BB:F1:C4',
          'system': '10',
          'model': 'LM-G820',
          'app_id': 'cn.vanber.xixunyun.saas',
          'key': '',
        },
        queryParameters: {
          'from': 'app',
          'version': '5.1.3',
          'platform': 'android',
          'entrance_year': '0',
          'graduate_year': '0',
          'school_id': schoolId,
        },
        options: Options(
          headers: {
            'Host': 'api.xixunyun.com',
            'Connection': 'keep-alive',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      var jsonDecode2 = response.data;
      if (jsonDecode2['data'] == null) {
        throw Exception(jsonDecode2['message']);
      }
      final json = LoginResponse.fromJson({
        'token': jsonDecode2['data']['token'],
        'userId': jsonDecode2['data']['user_id'].toString(),
        'phone': jsonDecode2['data']['bind_phone'],
        'userName': jsonDecode2['data']['user_name'],
        'userNumber': jsonDecode2['data']['user_number'],
        'schoolId': jsonDecode2['data']['school_id'].toString(),
      });
      return json;
  }

  // 2. 搜索学校 (直接请求习讯云)
  static Future<List<SchoolInfo>> searchSchool(String name) async {
    // 替换为真实的习讯云搜索接口
    final response = await _dio.get(
      'https://api.xixunyun.com/login/schoolmap'
    );

    // 解析 response.data
    return (response.data['data'] as List)
        .map((e) => SchoolInfo.fromJson({
      'schoolId': e['school_id'],
      'schoolName': e['school_name'],
    }))
        .toList();
  }

  // 3. 签到 (直接请求习讯云)
  static Future<String> sign(
    String account,
    String token,
    String address,
    String lat,
    String lng,
  ) async {
    // TODO: 这里需要实现经纬度的 RSA 加密逻辑 (参考 Go 代码 service/impl/sign_service.go)
    final response = await _dio.post(
      'https://api.xixunyun.com/signin_rsa',
      data: {
        'account': account,
        'token': token,
        'address': address,
        'latitude': lat.toString(), // 注意：需要加密
        'longitude': lng.toString(), // 注意：需要加密
        // 其他习讯云要求的参数...
      },options: Options(
      headers: {
        'Host': 'api.xixunyun.com',
        'Connection': 'keep-alive',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    )
    );
    if (response.data['code'] == 20000) {
      return response.data['message'];
    }
    throw Exception(response.data['message']);
  }

  // 4. 查询签到信息
  static Future<SignInResponse> getSignInInfo({
    required String account,
    required String token,
    required String schoolId,
  }) async {
      final response = await _dio.get(
        'https://api.xixunyun.com/signin40/homepage',
        queryParameters: {
          'account': account,
          'token': token,
          'month_date': DateTime.now().toString().substring(0, 7), // 当前月份，格式为 YYYY-MM
          'school_id': schoolId,
        },
      );
      var jsonDecode2 = response.data;
      if (jsonDecode2['code'] == 40510) {
        Get.offAll(() => LoginPage());
      }
      if (jsonDecode2['data'] == null) {
        throw Exception(jsonDecode2['message']);
      }
      final json = SignInResponse.fromJson({
        'continuous_sign_in': jsonDecode2['data']['continuous_sign_in'],
        'message': jsonDecode2['message'],
        'sign_in_month': jsonDecode2['data']['sign_in_month'],
      });
      return json;
  }
}
