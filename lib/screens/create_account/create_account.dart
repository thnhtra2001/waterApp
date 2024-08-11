import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterapp/screens/policy_screen/policy_screen.dart';
import 'package:waterapp/screens/signin_screen/signin_screen.dart';

import '../otp_screen/pin_code_fields_manager.dart';
import 'update_user.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final Map<String, String> _data = {'full_name': '', 'email': ''};
  final _formSignupKey = GlobalKey<FormState>();

  Future<void> submit(access_token, _data) async{
    await context.read<UpdateUserManager>().updateUser(access_token, _data);
  }


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
                  "Vui lòng nhập thông tin để đăng ký tài khoản",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 3) {
                        return 'Tên không hợp lệ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Nhập họ và tên',
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
                        prefixIcon: const Icon(Icons.account_circle_outlined)),
                    onChanged: (value) {
                      _data['full_name'] = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: 400,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty && value.endsWith('@')) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Địa chỉ email (nếu có)',
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
                        prefixIcon: const Icon(Icons.email_outlined)),
                    onChanged: (value) {
                      _data['email'] = value;
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
                    onPressed: () async {
                      var access_token = context.read<PinCodeFieldsManager>().access_token;
                      await submit(access_token, _data);
                    },
                    child: const Text(
                      'ĐĂNG KÝ',
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
        ),
      ),
    ])));
  }
}
