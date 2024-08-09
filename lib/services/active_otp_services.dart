import 'package:waterapp/model/active-otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/otp-res.dart';

class ActiveOTPServices {
  Future<OTPRes?> activeOtp(ActiveOTP data, _deviceInfo) async {
    // final List<Map> otpRes = [];
    try {
      final url = Uri.https('sawaco-api.talking.vn', '/v1/register/active-otp');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data.toJson()),
      );
      if (response.statusCode == 200) {
        final responseMap = jsonDecode(response.body);
        final otpRes = _fromJson(responseMap);
        print('Dữ liệu phản hồi 1: ${otpRes.password}');
        return otpRes;
      } else {
        print('Yêu cầu thất bại với mã: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }
}

  OTPRes _fromJson(Map<String, dynamic> json) {
    return OTPRes(
      password: json['password'] ?? "",
      success: json['success'] ?? "",
      error: json['error'] ?? "",
    );
  }
