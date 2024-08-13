import 'package:flutter/foundation.dart';

import '../../services/update_account_services.dart';

class UpdateUserManager with ChangeNotifier{
  Map<String, dynamic> _update = {};
  UpdateUser up = UpdateUser();
  Future<void> updateUser(_data) async {
    _update = await up.upDateUser(_data);
    notifyListeners();
  }
}