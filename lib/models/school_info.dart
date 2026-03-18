class SchoolInfo {
  String schoolId;
  String schoolName;

  SchoolInfo({
    required this.schoolId,
    required this.schoolName,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) => SchoolInfo(
    schoolId: json['schoolId'],
    schoolName: json['schoolName'],
  );

  Map<String, dynamic> toJson() => {
    'schoolId': schoolId,
    'schoolName': schoolName,
  };
}

class Provinces {
  String name;
  String id;
  List<SchoolInfo> schoolInfo;

  Provinces({
    required this.name,
    required this.id,
    required this.schoolInfo,
  });

  factory Provinces.fromJson(Map<String, dynamic> json) => Provinces(
    name: json['name'],
    id: json['id'],
    schoolInfo: (json['SchoolInfo'] as List).map((e) => SchoolInfo.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'SchoolInfo': schoolInfo.map((e) => e.toJson()),
  };
}

