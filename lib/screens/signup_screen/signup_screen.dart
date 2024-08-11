import 'package:flutter/material.dart';
import 'package:waterapp/screens/policy_screen/policy_screen.dart';
import 'package:waterapp/screens/signin_screen/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Map<String, String> _data = {'phone': '', 'method': 'signup'};
  // late String _data = '0354653950';
  final _formSignupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
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
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Đăng ký",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nhập số điện thoại để đăng ký sử dụng dịch vụ",
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
                      prefixIcon: const Icon(Icons.local_phone)),
                  onChanged: (value) {
                    _data['phone'] = value;
                    // _data = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                width: 400,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // print(_data);
                    if (_formSignupKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PolicyScreen(
                                  data: _data,
                                )),
                      );
                    }
                    _formSignupKey.currentState!.save();
                  },
                  child: const Text(
                    'ĐĂNG KÝ',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromARGB(255, 81, 45, 223),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bạn đã có tài khoản? ',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Di toi man dang nhap");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (e) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Đăng nhập tại đây',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ])));
  }
}
