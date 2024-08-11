import 'package:flutter/foundation.dart';
import 'package:waterapp/model/otp-res.dart';
import '../../services/active_otp_services.dart';

class PinCodeFieldsManager with ChangeNotifier{
  final ActiveOTPServices _activeOTPServices = ActiveOTPServices();
  Map<String, dynamic> _otpRes = {};
  Map<String, dynamic> _tokenUser = {};

  Future<void> getOtpRes(otp) async{
    _otpRes = await _activeOTPServices.activeOtp(otp);
    notifyListeners();
  }
  bool get successOTP{
    return _otpRes['success'];
  }
  String get password{
    return _otpRes['password'].toString();
  }

    Future<void> getToken(phone, password, _deviceInfo) async{
    _tokenUser = await _activeOTPServices.getToken(phone, password, _deviceInfo);
    print("TOKEN: ");
    print(_tokenUser);
    notifyListeners();
  }
    String get access_token{
    return _tokenUser['access_token'].toString();
  }
}