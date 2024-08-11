import 'package:flutter/foundation.dart';

class OTPResToken with ChangeNotifier {
  final int id_user;
  final String username;
  final String access_token;
  final String full_name;
  final String email;

  OTPResToken({
    required this.id_user,
    required this.username,
    required this.access_token,
    required this.full_name,
    required this.email,
  });

  OTPResToken copyWith({
    String? password,
    bool? success,
    String? error,
  }) {
    return OTPResToken(
      id_user: id_user ?? this.id_user,
      username: username ?? this.username,
      access_token: access_token ?? this.access_token,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
    );
  }

  factory OTPResToken.fromJson(Map<String, dynamic> json) {
    return OTPResToken(
      id_user: json['id_user'] ?? '', // Thêm giá trị mặc định nếu không có
      username: json['username'] ?? '',
      access_token: json['access_token'] ?? '',
      full_name: json['full_name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
