import 'dart:convert';

class OKRoute {
  final path;

  const OKRoute(this.path);

  static const splitString = "----||----";

  static String createPushString(
    String routeName, {
    Map<String, dynamic> params,
  }) {
    if (params == null) {
      return "$routeName$splitString";
    }
    final str = json.encode(params);
    final paramsString = base64.encode(utf8.encode(str));
    return "$routeName$splitString$paramsString";
  }
}

class OKRouteParams {
  static Map<dynamic, Map<String, dynamic>> paramsMap = {};

  static void putParams(dynamic key, Map<String, dynamic> value) {
    paramsMap[key] = value;
  }

  /// Get params and remove it.
  static Map<String, dynamic> getParams(dynamic key, {bool remove = true}) {
    if (remove) {
      return removeParams(key);
    } else {
      return paramsMap[key];
    }
  }

  /// Get params and remove it.
  static Map<String, dynamic> removeParams(dynamic key) {
    return paramsMap.remove(key);
  }
}
