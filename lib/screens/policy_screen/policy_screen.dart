
import 'package:flutter/material.dart';
import 'package:waterapp/model/send-otp.dart';
import 'package:waterapp/screens/otp_screen/pin_code_fields_screen.dart';

import '../../services/send_otp_services.dart';

class PolicyScreen extends StatefulWidget {

final Map<String, String> data;
PolicyScreen({required this.data});
  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  late sendOTP _otp;
  bool _isChecked = true; // Biến để lưu trạng thái của checkbox

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    // _formKey.currentState!.save();

    // _isSubmitting.value = true;

    // try {
      await SendOTPServices().addPhone(_otp);
    // } catch (error) {
    //   showErrorDialog(context,
    //       (error is HttpException) ? error.toString() : 'Có lỗi xảy ra');
    // }

    // _isSubmitting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chính sách và điều khoản người dùng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
                height: 600,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Chính sách bảo mật - Điều khoản sử dụng phần mềm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quý khách vui lòng đọc bản chính sách bảo mật - Điều khoản sử dụng dưới đây để hiểu hơn những cam kết mà chúng tôi thực hiện, nhằm tôn trọng và bảo vệ quyền lợi của người truy cập.",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "1. Mục đích và phạm vi thu thập:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Để truy cập và sử dụng một số dịch vụ phần mềm CSKH, bạn có thể sẽ được yêu cầu đăng ký với chúng tôi thông tin cá nhân (Số điện thoại, Mật khẩu, Họ tên, Ngày sinh, Giới tính, Địa chỉ Email). Mọi thông tin khai báo phải đảm bảo tính chính xác và hợp pháp. Phần mềm CSKH không chịu mọi trách nhiệm liên quan đến pháp luật của thông tin khai bảo. Chúng tôi cũng có thể thu thập thông tin về số lần viếng thăm, bao gồm số trang bạn xem, số links (liên kết) bạn click và những thông tin khác liên quan đến việc kết nối đến hệ thống CSKH. Chúng tôi cũng thu thập các thông tin mà trình duyệt Web (Browser) bạn sử dụng môi khi truy cập vào trang biwase.com.vn, bao gồm: địa chỉ IP, loại Browser, ngôn ngữ sử dụng, thời gian và những địa chỉ mà Browser truy xuất đến. Phân mềm CSKH thu thập và sử dụng thông tin cá nhân han ym mur dich obehanevac hoãn lisän tuân thủ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ]),
                  )
                ])),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!; // Cập nhật trạng thái checkbox
                    });
                  },
                ),
                const Text(
                  'Tôi hoàn toàn đồng ý với',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const Text(
                  ' Chính sách người dùng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  _otp = sendOTP(phone: widget.data['phone']!, is_confirm: _isChecked);
                  _submit();
                  print("=====================================================");
                  print(widget.data['phone']!);
                  print(_isChecked);
                  print("===================================================");
                  print("Nhap OTP");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PinCodeScreen(data: widget.data)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 81, 45, 223),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Đồng ý',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
