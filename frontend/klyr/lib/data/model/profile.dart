class ProfileModel {
  final int? userId;
  final String? name;
  final String? email;
  final String? phoneNo;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    this.phoneNo,
  });

  // from API response
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phone_no'],
    );
  }

  // to send to API
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone_no': phoneNo,
    };
  }

  // to store in SharedPreferences
  Map<String, dynamic> toMap() => toJson();

  // to read from SharedPreferences
  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel.fromJson(map);

  // for initial get
  factory ProfileModel.empty() {
    return ProfileModel(
      userId: null,
      name: null,
      email: null,
      phoneNo: null,
    );
  }

  ProfileModel copyWith({
    int? userId,
    String? name,
    String? email,
    String? phoneNo,
  }) {
    return ProfileModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }
}