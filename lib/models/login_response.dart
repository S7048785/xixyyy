class LoginResponse {
  String token;
  String userId;
  String phone;
  String userNumber;
  String userName;
  String schoolId;

  LoginResponse({
    required this.token,
    required this.userId,
    required this.phone,
    required this.userNumber,
    required this.userName,
    required this.schoolId,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json['token'],
    userId: json['userId'],
    phone: json['phone'],
    userNumber: json['userNumber'],
    userName: json['userName'],
    schoolId: json['schoolId'],
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'userId': userId,
    'phone': phone,
    'userNumber': userNumber,
    'userName': userName,
    'schoolId': schoolId,
  };
}
