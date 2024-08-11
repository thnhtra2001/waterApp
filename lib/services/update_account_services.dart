import 'package:waterapp/model/send-otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUser {
  Future<Map<String, dynamic>> upDateUser(data, access_token) async {
    Map<String, dynamic> data = {};
    try {
      final url = Uri.parse('https://sawaco-api.talking.vn/v1//user/update');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json', // Đặt loại nội dung
        },
        body: jsonEncode(data), // Mã hóa dữ liệu của bạn thành JSON
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("===================================>");
        print(data);
        // Yêu cầu thành công
        print('Dữ liệu phản hồi: ${response.body}');
      } else {
        // Xử lý lỗi
        print('Yêu cầu thất bại với mã: ${response.statusCode}');
      }

      // return data.copyWith(phone: json.decode(response.body));
    } catch (error) {
      print(error);
    }
      return data;
  }
}
