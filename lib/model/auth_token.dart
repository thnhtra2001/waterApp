import 'package:flutter/foundation.dart';

class AuthToken1{
  final int id_user;
  final String username;
  final String access_token;
  final String full_name;
  final String email;

  AuthToken1({
    required this.id_user,
    required this.username,
    required this.access_token,
    required this.full_name,
    required this.email,
  });
  bool get isValid {
    return access_token != null;
  }
  String get token{
    return access_token;
  }
  String get userId {
    return userId;
  }

  AuthToken1 copyWith({
    String? password,
    bool? success,
    String? error,
  }) {
    return AuthToken1(
      id_user: id_user ?? this.id_user,
      username: username ?? this.username,
      access_token: access_token ?? this.access_token,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': id_user,
      'username': username,
      'access_token': access_token,
      'full_name': full_name,
      'email': email,
    };
  }
  factory AuthToken1.fromJson(Map<String, dynamic> json) {
    return AuthToken1(
      id_user: json['id_user'],
      username: json['username'],
      access_token: json['access_token'],
      full_name: json['full_name'],
      email: json['email'],
    );
  }
}
