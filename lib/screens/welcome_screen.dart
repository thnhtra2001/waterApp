import 'dart:async';
import 'package:flutter/material.dart';
import 'package:waterapp/screens/signin_screen.dart';
import 'package:waterapp/screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/icon.jpg',
                  width: 110.0,
                  height: 110.0,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              // SizedBox(height: 20.0),
              const Text(
                "Chào mừng bạn",
                style: TextStyle(color: Color.fromARGB(255, 15, 99, 169), fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.0),
              const Text(
                "Đăng nhập hoặc đăng ký tài khoản",
                style: TextStyle(color: Color.fromARGB(255, 15, 99, 169), fontSize: 15),
              ),
              SizedBox(height: 30.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Di toi man hinh dang nhap");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(
                        'Đăng nhập',
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
                  const SizedBox(height: 30),
                  Container(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Di toi man hinh dang ki");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 113, 80, 245),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.blue, width: 2),
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
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
