import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:waterapp/model/send-otp.dart';
import '../../model/otp-res-token.dart';
import '../../services/active_otp_services.dart';
import '../../services/send_otp_services.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  final ActiveOTPServices _authService = ActiveOTPServices();
  final SendOTPServices _sendPhone = SendOTPServices();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  AuthToken? get authToken {
    return _authToken;
  }

  void _setAuthToken(AuthToken token) {
    _authToken = token;
    notifyListeners();
  }

  Future<void> addPhone(sendOTP data) async {
    await _sendPhone.addPhone(data);
    notifyListeners();
  }

  Future<void> getToken(data, password, _deviceInfo) async {
    _setAuthToken(await _authService.getToken(data, password, _deviceInfo));
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final savedToken = await _authService.loadSavedAuthToken();
    print("Token duoc luu lai la");
    print(jsonEncode(savedToken));
    if (savedToken == null) {
      return false;
    }
    _setAuthToken(savedToken);
    return true;
  }

  Future<void> logout() async {
    _authToken = null;
    notifyListeners();
    _authService.clearSavedAuthToken();
  }

  //   void _autoLogout() {
  //   if (authToken!.isValid == false) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry =
  //       _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
