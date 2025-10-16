class UserModel {
  final int? id;
  final String username;
  final String? fnameEn;
  final String? fnameMn;
  final String? lnameEn;
  final String? lnameMn;
  final String email;
  final String phoneNumber;
  final String? password;

  UserModel({
    this.id,
    required this.username,
    this.fnameEn,
    this.fnameMn,
    this.lnameEn,
    this.lnameMn,
    required this.email,
    required this.phoneNumber,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['user_name'],
      fnameEn: json['fname_en'],
      fnameMn: json['fname_mn'],
      lnameEn: json['lname_en'],
      lnameMn: json['lname_mn'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': username,
      'fname_en': fnameEn,
      'fname_mn': fnameMn,
      'lname_en': lnameEn,
      'lname_mn': lnameMn,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}