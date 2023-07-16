import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:git_client_app/models/cache_config.dart';
import 'package:git_client_app/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_object.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  //网络缓存对象
  static NetCache netCache = NetCache();
  //可选的主题列表
  static List<MaterialColor> get themes => _themes;
  //是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，在app启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    String? localProfile = _prefs.getString("profile");
    if (localProfile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(localProfile));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      //默认主题索引为0，代表蓝色
      profile = Profile()..theme = 0;
    }

    //如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
  }

  //profile信息持久化
  static saveProfile() =>
      _prefs.setString('profile', jsonEncode(profile.toJson()));
}
