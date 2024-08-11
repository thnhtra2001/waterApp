import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterapp/model/active-otp.dart';
import 'package:waterapp/screens/create_account/create_account.dart';
import 'package:waterapp/screens/home_screen/home_screen.dart';
import '../../services/active_otp_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../shared/dialog_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pin_code_fields_manager.dart';

class PinCodeScreen extends StatefulWidget {
  final Map<String, String> data;
  PinCodeScreen({required this.data});
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  Map<String, String> _deviceToken = {"device-token": ''};
  late ActiveOTP _otp;

  List<String> values = [];
  Map<String, String> _deviceInfo = {
    "device_name": '',
    "device_os": '',
    "os_version": ''
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDeviceInfo();
      _loadDeviceToken();
    });
  }

  Future<void> _loadDeviceToken() async {
    SharedPreferences _spref = await SharedPreferences.getInstance();
    String? saveToken = _spref.getString("device_token");
    if (saveToken == null) {
      _generateToken();
    } else {
      setState(() {
        _deviceToken = {"device-token": saveToken};
      });
    }
  }

  Future<void> _generateToken() async {
    var uuidV4 = Uuid();
    String token = uuidV4.v4();

    SharedPreferences _spref = await SharedPreferences.getInstance();
    await _spref.setString("device_token", token);
    setState(() {
      _deviceToken = {"device-token": token};
    });
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName;
    String osVersion;
    String platform;

    // Lấy thông tin thiết bị một cách an toàn
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model; // Tên thiết bị
      osVersion = androidInfo.version.release; // Phiên bản Android
      platform = "Android";
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name; // Tên thiết bị
      osVersion = iosInfo.utsname.release; // Phiên bản iOS
      platform = "iOS";
    } else {
      deviceName = 'Unknown';
      osVersion = 'Unknown';
      platform = 'Unknown';
    }

    setState(() {
      // _deviceInfo =
      // 'Device: $deviceName\nPlatform: $platform\nOS Version: $osVersion';
      _deviceInfo = {
        "device_name": deviceName,
        "device_os": platform,
        "os_version": osVersion
      };
    });
  }

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  Future<void> _submit() async {
    try {
      await context.read<PinCodeFieldsManager>().getOtpRes(_otp);
      var code = context.read<PinCodeFieldsManager>();
      await context
          .read<PinCodeFieldsManager>()
          .getToken(widget.data['phone'], code.password, _deviceInfo);
      var token = context.read<PinCodeFieldsManager>();
      print("token cua nguoi dung la: ");
      print(token.access_token);
      await ActiveOTPServices().updateDeviceToken(token.access_token, _deviceToken);

    } catch (error) {
      showErrorDialog(context, error.toString());
    }
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _controllers.length) {
      values.add(value);
      FocusScope.of(context).nextFocus(); // Chuyển đến trường tiếp theo
    } else if (value.isEmpty && index > 0) {
      values.removeLast();
      FocusScope.of(context).previousFocus(); // Quay lại trường trước đó
    }
  }

  late String value2 = values.join(''); // Kết hợp các giá trị thành một chuỗi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text("Nhập mã PIN")),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/icon.jpg',
                          width: 110.0,
                          height: 110.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Xác thực mã OTP",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Chúng tôi vừa gửi tới điện thoại của bạn một mã xác thực OTP gồm 6 chữ số. Vui lòng kiếm tra tin nhắn điện thoại và nhập vào ô bên dưới.",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Nhap ma otp
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 40,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _controllers[index],
                              autofocus: index == 0,
                              obscureText: false, // Ẩn ký tự
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => _onChanged(value, index),
                            ),
                          );
                        })),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Mã có hiệu lực trong 60 giây',
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Di toi giao dien nguoi dung");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (e) => const SignUpScreen(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Gửi lại',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Xác thực thông qua',
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Di toi giao dien nguoi dung");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (e) => const SignUpScreen(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Cuộc gọi lại',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        _otp = ActiveOTP(
                            phone: widget.data['phone']!, code: value2);
                        await _submit();
                        // print(_deviceToken);
                        if (widget.data['method']! == 'signin') {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          //   (Route<dynamic> route) =>
                          //       false, // Xóa tất cả các trang cũ
                          // );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CreateAccount(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'XÁC THỰC OTP',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 81, 45, 223),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
