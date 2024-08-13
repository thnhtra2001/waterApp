import 'package:flutter/material.dart';

import 'new_screen.dart';
import 'new_screen1.dart';
import 'new_screen2.dart';
import 'new_screen3.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final screens = [
    NewScreen(),
    NewScreen1(),
    PersonalScreen(),
    NewScreen3(),
  ];
  late int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) =>
              setState(() => (this.index = index)),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: "Giỏ hàng"),
            NavigationDestination(
                icon: Icon(Icons.shopping_bag), label: "Đơn hàng"),
            NavigationDestination(
                icon: Icon(Icons.account_circle_outlined), label: "Cá nhân"),
          ],
        ),
      ),
    );
  }
}
