class UserMaid {
  String id;
  String intro = '';
  int literacyType = 1; // LITERACY_TYPE
  String exp = '';
  int salary = 1; // SALARY_TYPE
  List<String> jobTypes = []; // JOB_TYPE
  List<int> supportAreas = []; // SUPPORT_AREA
  String name;
  String email;
  int gender;
  DateTime birthday;
  String phoneNumber;
  String address;
  String avatar;
  DateTime createdAt;
  double rating;

  UserMaid({
    this.intro,
    this.literacyType,
    this.exp,
    this.salary,
    this.jobTypes,
    this.supportAreas,
    this.id,
    this.name,
    this.email,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.address,
    this.avatar,
    this.createdAt,
    this.rating = 0,
  });

  factory UserMaid.fromJson(Map<String, dynamic> json) {
    return UserMaid(
      intro: json['intro'],
      id: json['_id'],
      literacyType: json['literacyType'],
      exp: json['exp'],
      salary: json['salary'],
      jobTypes: json['jobTypes'].cast<String>(),
      supportAreas: json['supportAreas'].cast<int>(),
      name: json['user']['name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      birthday: DateTime.parse(json['user']['birthday']).toLocal(),
      phoneNumber: json['user']['phoneNumber'],
      address: json['user']['address'],
      createdAt: DateTime.parse(json['createdAt']),
      avatar: json['user']['avatar'],
      rating: json['rating'] != null ? json['rating'] : 0,
    );
  }

  static UserMaid getMaid(Map<String, dynamic> json) {
    return UserMaid(
      intro: json['intro'],
      id: json['_id'],
      literacyType: json['literacyType'],
      exp: json['exp'],
      salary: json['salary'],
      jobTypes: json['jobTypes'].cast<String>(),
      supportAreas: json['supportAreas'].cast<int>(),
      name: json['user']['name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      birthday: json['user']['birthday'] == null
          ? null
          : DateTime.parse(json['user']['birthday']).toLocal(),
      phoneNumber: json['user']['phoneNumber'],
      address: json['user']['address'],
      createdAt: DateTime.parse(json['createdAt']),
      avatar: json['user']['avatar'],
      rating: json['rating'] != null ? json['rating'] : 0,
    );
  }
}
