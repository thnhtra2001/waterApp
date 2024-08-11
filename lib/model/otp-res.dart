import 'package:flutter/foundation.dart';

class OTPRes with ChangeNotifier {
  final String password;
  final bool success;
  final String error;

  OTPRes({
    required this.password,
    required this.success,
    required this.error,
  });

  bool get successOTP {
    return success;
  }

  OTPRes copyWith({
    String? password,
    bool? success,
    String? error,
  }) {
    return OTPRes(
      password: password ?? this.password,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  factory OTPRes.fromJson(Map<String, dynamic> json) {
    return OTPRes(
      password: json['password'] ?? '', // Thêm giá trị mặc định nếu không có
      success: json['success'] ?? false,
      error: json['error'] ?? '',
    );
  }
}
