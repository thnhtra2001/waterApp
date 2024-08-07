import 'package:flutter/material.dart';
import 'package:waterapp/model/active-otp.dart';
import 'package:waterapp/services/active_otp_services.dart';

import '../../services/send_otp_services.dart';

class PinCodeScreen extends StatefulWidget {
  final Map<String, String> data;
  PinCodeScreen({required this.data});
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  late ActiveOTP _otp;

  List<String> values = [];

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    // _formKey.currentState!.save();

    // _isSubmitting.value = true;

    // try {
    await ActiveOTPServices().activeOtp(_otp);
    // } catch (error) {
    //   showErrorDialog(context,
    //       (error is HttpException) ? error.toString() : 'Có lỗi xảy ra');
    // }

    // _isSubmitting.value = false;
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _controllers.length) {
      values.add(value);
      print("Mang hien tai la: $values");
      FocusScope.of(context).nextFocus(); // Chuyển đến trường tiếp theo
    } else if (value.isEmpty && index > 0) {
      values.removeLast();
      print("Mang hien tai la: $values");

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
                      onPressed: () {
                        _otp = ActiveOTP(
                            phone: widget.data['phone']!, code: value2);
                        _submit();
                        print("DANG NHAP voi ${widget.data['phone']!}");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignInScreen()),
                        // );
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
