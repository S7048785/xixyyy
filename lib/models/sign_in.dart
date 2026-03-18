class SignInResponse {
  String continuousSignIn; // 连续签到天数
  List<SignInMonth> signInMonth; // 签到月份

  SignInResponse({
    required this.continuousSignIn,
    required this.signInMonth,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    continuousSignIn: json['continuous_sign_in'],
    signInMonth: (json['sign_in_month'] as List).map((e) => SignInMonth.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'continuous_sign_in': continuousSignIn,
    'sign_in_month': signInMonth.map((e) => e.toJson()),
  };
}


class SignInMonth {
  String signType; // 签到类型 0
  String signTime; // 签到时间 1773716870
  String signTimeText; // 签到时间文本 2026-03-17
  String statusCode; // 状态码 0

  SignInMonth({ required this.signType, required this.signTime, required this.signTimeText, required this.statusCode});

  factory SignInMonth.fromJson(Map<String, dynamic> json) => SignInMonth(
    signType: json['sign_type'],
    signTime: json['sign_time'],
    signTimeText: json['sign_time_text'],
    statusCode: json['status_code'],
  );

  Map<String, dynamic> toJson() => {
    'sign_type': signType,
    'sign_time': signTime,
    'sign_time_text': signTimeText,
    'status_code': statusCode,
  };
}