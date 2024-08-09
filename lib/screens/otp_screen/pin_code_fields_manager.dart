import 'package:flutter/foundation.dart';
import 'package:waterapp/model/otp-res.dart';

import '../../services/active_otp_services.dart';

class PinCodeFieldsManager with ChangeNotifier{
  final ActiveOTPServices _activeOTPServices = ActiveOTPServices();
  late final OTPRes _otpRes;


  //   Future<void> active() async {
  //   _otpRes = (await _activeOTPServices.activeOtp())!;
  //   notifyListeners();
  // }
}