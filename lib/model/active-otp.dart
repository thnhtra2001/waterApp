import 'package:flutter/foundation.dart';

class ActiveOTP with ChangeNotifier {
  late final String phone;
  late final String code;

  ActiveOTP({
    required this.phone,
    required this.code,
  });

  ActiveOTP copyWith({
    String? phone,
    String? code,
  }) {
    return ActiveOTP(
        phone: phone ?? this.phone, code: code ?? this.code);
  }

    Map toJson() {
    return {
      'phone': phone,
      'code': code,
    };
  }
}
