import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:git_client_app/common/global.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  //为确保迭代器顺序和对象插入时间顺序一致，我们使用LinkHashMap
  LinkedHashMap<String, CacheObject> cache =
      LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!Global.profile.cache!.enable) {
      return handler.next(options);
    }
    //refresh标记是否是下拉刷新
    bool refresh = options.extra['refresh'] == true;
    //如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra['list'] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        //如果不是列表，则只删除uri相同的缓存
        cache.remove(options.uri.toString());
      }
      return handler.next(options);
    }

    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var obj = cache[key];
      if (obj != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - obj.timeStamp) / 1000 <
            Global.profile.cache!.maxAge!) {
          return handler.resolve(obj.response);
        } else {
          //如果已经过期，删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //如果启用缓存，则将结果保存到缓存
    if (Global.profile.cache!.enable) {
      _saveCache(response);
    }
  }

  void _saveCache(Response response) {
    RequestOptions options = response.requestOptions;
    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      //如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == Global.profile.cache!.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }
}
