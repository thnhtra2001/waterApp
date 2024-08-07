import 'package:flutter/foundation.dart';

class sendOTP with ChangeNotifier {
  late final String phone;
  late final bool is_confirm;

  sendOTP({
    required this.phone,
    required this.is_confirm,
  });

  sendOTP copyWith({
    String? phone,
    bool? is_confirm,
  }) {
    return sendOTP(
        phone: phone ?? this.phone, is_confirm: is_confirm ?? this.is_confirm);
  }

    Map toJson() {
    return {
      'phone': phone,
      'is_confirm': is_confirm,
    };
  }
}
