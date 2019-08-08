import 'package:flutter/widgets.dart';
import 'package:sub_module1/generate/ok_route_map.dart' as m0;
import 'package:ok_route_example/generate/ok_route_map.dart' as m1;

class OKRouteMap {
  Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(m0.$OKRouteMap.routes);
    routes.addAll(m1.$OKRouteMap.routes);
    return routes;
  }
}
