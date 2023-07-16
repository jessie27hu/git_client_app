class CacheConfig {
  bool enable;
  int? maxAge;
  int? maxCount;

  CacheConfig({this.enable = true, this.maxAge, this.maxCount});

  factory CacheConfig.fromJson(Map<String, Object?> json) => CacheConfig(
        enable: json['enable'] as bool,
        maxAge: json['maxAge'] as int?,
        maxCount: json['maxCount'] as int?,
      );

  Map<String, Object?> toJson() => {
        'enable': enable,
        'maxAge': maxAge,
        'maxCount': maxCount,
      };
}
