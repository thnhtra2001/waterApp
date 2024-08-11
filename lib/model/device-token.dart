import 'package:flutter/foundation.dart';

class deviceToken with ChangeNotifier {
  late final String token;

  deviceToken({
    required this.token,
  });

  deviceToken copyWith({
    String? token,
  }) {
    return deviceToken(
        token: token ?? this.token);
  }

    Map toJson() {
    return {
      'token': token,
    };
  }
}
