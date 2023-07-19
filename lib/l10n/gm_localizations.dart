import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GmLocalization {
  //是否为中文
  bool isZh = false;
  GmLocalization(this.isZh);
  //为了使用方便，我们定义一个静态方法
  static GmLocalization of(BuildContext context) {
    return Localizations.of(context, GmLocalization);
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? 'Github客户端' : 'Github Client';
  }

  String get home {
    return isZh ? '主页' : 'home';
  }

  String get login {
    return isZh ? '登录' : 'login';
  }

  String get noMoreData {
    return isZh ? '没有更多数据了' : 'no more data';
  }

  String get userName {
    return isZh ? '用户名' : 'UserName';
  }

  String get userNameRequired {
    return isZh ? '用户名不能为空' : 'userName is required';
  }

  String get password {
    return isZh ? '密码' : 'password';
  }

  String get passwordRequired {
    return isZh ? '密码不能为空' : 'password is required';
  }

  String get userNameOrPasswordWrong {
    return isZh ? '用户名或密码错误' : 'userName or password is wrong';
  }
}

//Locale代理类
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalization> {
  //是否支持某个Locale
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  //Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalization> load(Locale locale) {
    return SynchronousFuture<GmLocalization>(
        GmLocalization(locale.languageCode == 'zh'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<GmLocalization> old) {
    return false;
  }
}
