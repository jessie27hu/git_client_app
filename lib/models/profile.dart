import 'cache_config.dart';
import 'user.dart';

class Profile {
  User? user;
  String? token;
  int? theme;
  CacheConfig? cache;
  String? lastLogin;
  String? locale;

  Profile({
    this.user,
    this.token,
    this.theme,
    this.cache,
    this.lastLogin,
    this.locale,
  });

  factory Profile.fromJson(Map<String, Object?> json) => Profile(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user']! as Map<String, Object?>),
        token: json['token'] as String?,
        theme: json['theme'] as int?,
        cache: json['cache'] == null
            ? null
            : CacheConfig.fromJson(json['cache']! as Map<String, Object?>),
        lastLogin: json['lastLogin'] as String?,
        locale: json['locale'] as String?,
      );

  Map<String, Object?> toJson() => {
        'user': user?.toJson(),
        'token': token,
        'theme': theme,
        'cache': cache?.toJson(),
        'lastLogin': lastLogin,
        'locale': locale,
      };
}
