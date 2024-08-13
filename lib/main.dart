import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/create_account/auth_manager.dart';
import 'screens/create_account/update_user.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/otp_screen/pin_code_fields_manager.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PinCodeFieldsManager()),
        ChangeNotifierProvider(create: (context) => UpdateUserManager()),
        ChangeNotifierProvider(create: (context) => AuthManager()),

      ],
      child: Consumer<AuthManager>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'WaterApp',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorSchemeSeed: const Color(0xff5a73d8),
                textTheme: GoogleFonts.plusJakartaSansTextTheme(
                  Theme.of(context).textTheme,
                ),
                useMaterial3: true,
              ),
              home: value.isAuth == true
                  ? const MyHomePage()
                  : FutureBuilder(
                      future: value.tryAutoLogin(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : WelcomeScreen() ;
                      },
                    ),
            );
          },
        )
    );
  }
}
