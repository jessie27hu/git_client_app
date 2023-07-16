import 'package:git_client_app/states/profile_change_notifier.dart';

import '../models/user.dart';

class UserModel extends ProfileChangeNotifier {
  User? get user => super.profile.user;

  //App是否登录（如果有用户信息，则证明登录过）
  bool get isLogin => user != null;

  //用户信息变化，更新用户信息并通知依赖它的子孙widget更新
  set user(User? user) {
    if (user?.login != profile.user?.login) {
      profile.lastLogin = profile.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }
}
