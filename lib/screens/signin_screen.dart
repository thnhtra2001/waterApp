import 'package:flutter/material.dart';
import 'package:waterapp/screens/signup_screen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
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
                      const Text("Đăng nhập",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Nhập số điện thoại để đăng nhập sử dụng dịch vụ",
                      style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 400,
                        child: TextFormField(
                          validator: (value) {
                            String pattern = r'^(?:[+0]9)?[0-9]{10}$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value!)) {
                              return 'Số điện thoại không hợp lệ!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Nhập số điện thoại',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.local_phone)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        width: 400,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            print("DANG NHAP");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SignInScreen()),
                            // );
                          },
                          child: Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color.fromARGB(255, 81, 45, 223),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Nếu bạn chưa có tài khoản vui lòng bấm vào ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Di toi man dang ky");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Đăng ký tại đây',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
