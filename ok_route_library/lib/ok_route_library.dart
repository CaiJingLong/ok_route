import 'dart:convert';
import 'package:flutter/material.dart';

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

class OKRouteParams extends InheritedWidget {
  final Map<String, dynamic> params;

  OKRouteParams({
    Key key,
    this.params,
    Widget child,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Map<String, dynamic> of(BuildContext context) {
    final OKRouteParams scope =
        context.inheritFromWidgetOfExactType(OKRouteParams);
    return scope.params;
  }
}
