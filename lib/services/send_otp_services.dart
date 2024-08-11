import 'package:waterapp/model/send-otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendOTPServices {
  Future<void> addPhone(sendOTP data) async {
    try {
      final url = Uri.https('sawaco-api.talking.vn', '/v1/register/otp');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Đặt loại nội dung
        },
        body: json.encode(data.toJson()), // Mã hóa dữ liệu của bạn thành JSON
      );
      if (response.statusCode == 200) {
        // Yêu cầu thành công
        print('Dữ liệu phản hồi: ${response.body}');
      } else {
        // Xử lý lỗi
        print('Yêu cầu thất bại với mã: ${response.statusCode}');
      }

      // return data.copyWith(phone: json.decode(response.body));
    } catch (error) {
      print(error);
      return null;
    }
  }
}
