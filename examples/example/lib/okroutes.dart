import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ok_route/ok_route.dart';
import 'package:sub_module1/generate/ok_route_map.dart' as m0;
import 'package:ok_route_example/generate/ok_route_map.dart' as m1;

class OKRouteMap {
  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(m0.$OKRouteMap.routes);
    routes.addAll(m1.$OKRouteMap.routes);
    return routes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routes = OKRouteMap.getRoutes();
    final handleResults = settings.name.split("----||----");
    if (handleResults.length >= 2) {
      String name = handleResults[0];
      String paramsString = handleResults[1];

      final str = utf8.decode(base64.decode(paramsString));

      final paramJson = json.decode(str);
      final widgetBuilder = routes[name];
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final w = widgetBuilder(context);
          OKRouteParams.putParams(w, paramJson);
          return w;
        },
      );
    } else if (handleResults.length == 1) {
      return MaterialPageRoute(
        builder: (BuildContext context) => routes[handleResults[0]](context),
      );
    } else {
      return null;
    }
  }
}
