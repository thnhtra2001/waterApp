import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterapp/model/active-otp.dart';
import 'package:http/http.dart' as http;
import 'package:waterapp/model/device-token.dart';
import 'package:waterapp/model/otp-res-token.dart';
import 'dart:convert';
import '../model/otp-res.dart';

class ActiveOTPServices {
  static const _authTokenKey = 'authToken';
  Future<Map<String, dynamic>> activeOtp(ActiveOTP data) async {
    Map<String, dynamic> otpRes = {};
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
        final responseData = jsonDecode(response.body);
        otpRes = responseData;
        // getToken(
        //     data.phone, otpRes['password'], _deviceInfo, _deviceToken);
      } else {
        print('Yêu cầu thất bại với mã: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
    return otpRes;
  }

  Future<AuthToken> getToken(phone, pass, _deviceInfo) async {
    late AuthToken response2;
    final url = Uri.parse(
        'https://sawaco-api.talking.vn/v1/auth?device_name=${_deviceInfo['device_name']}&device_os=${_deviceInfo['device_os']}&os_version=${_deviceInfo['os_version']}'); // Thay đổi URL thành API của bạn

    // Tạo Basic Authentication token
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$phone:$pass'));

    final response = await http.get(
      url,
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      final response1 = jsonDecode(response.body);
      print("response 1");
      print(response1);
      response2 = fromJson(response1);
      print("Access Token Now: ");
      print(response2.access_token);
      _saveAuthToken(response2);
      // updateDeviceToken(responseData2.access_token, _deviceToken);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
    return response2;
  }
   AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      id_user: json['id_user'],
      username: json['username'],
      access_token: json['access_token'],
      full_name: json['full_name'],
      email: json['email'],
    );
  }
  Future<void> _saveAuthToken(AuthToken authToken) async {
    print("authotoken ne");
    print(authToken.access_token);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }

    final savedToken = prefs.getString(_authTokenKey);

    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (authToken.access_token.isEmpty) {
      return null;
    }
    return authToken;
  }

  Future<void> updateDeviceToken(access_token, _deviceToken) async {
    final url = Uri.parse(
        'https://sawaco-api.talking.vn/v1/user/device-token'); // Địa chỉ API // Thay thế bằng Bearer Token của bạn
    print("=>Data accesstoken:");
    print(access_token);
    print("=>Data deviceToken:");
    print(_deviceToken);
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $access_token',
          'Content-Type':
              'application/json', // Hoặc 'application/x-www-form-urlencoded' tùy thuộc vào API
        },
        body: jsonEncode(_deviceToken));

    if (response.statusCode == 200) {
      // Yêu cầu thành công
      print('Response data: ${response.body}');
    } else {
      // Xử lý lỗi
      print('Request failed with status: ${response.statusCode}.');
    }
  }

    Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }
}
