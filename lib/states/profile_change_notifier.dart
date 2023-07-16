import 'package:flutter/foundation.dart';
import 'package:git_client_app/common/global.dart';
import 'package:git_client_app/models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}
