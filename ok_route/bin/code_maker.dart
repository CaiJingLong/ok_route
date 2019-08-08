import 'dart:io';

import 'generator.dart';

const _packageRoutePath = "/generate/ok_route_map.dart";
const _packageClassName = "\$OKRouteMap";
const _packageFieldName = "routes";
const _applicationRoutePath = "/lib/okroutes.dart";

class CodeMaker {
  List<String> routes = [];

  void makeCode(
      String projectRootPath, Map<Generator, List<ScanResult>> results) {
    for (final generator in results.keys) {
      _createPackageRouteFile(generator, results[generator]);
    }

    final mainTemplate = MainProjectTemplate();
    mainTemplate.makeCode(projectRootPath, results);
  }

  void _createPackageRouteFile(Generator generator, List<ScanResult> results) {
    if (!generator.isFlutterProject()) {
      return;
    }

    final pkgName = generator.getPackageName();
    final pkgDir = generator.projectRootPath;

    final template = PackageTemplate(pkgDir, pkgName, results);

    template.makeCode();
  }
}

class PackageTemplate {
  final String pkgDir;
  final String pkgName;
  final List<ScanResult> results;

  PackageTemplate(this.pkgDir, this.pkgName, this.results);

  String get importString {
    // import 'package:ok_route/ok_route.dart'  as ok show OKRoute ;
    final sb = StringBuffer();
    sb.writeln("import 'package:flutter/widgets.dart';");
    for (var i = 0; i < results.length; i++) {
      final result = results[i];
      sb.write(
          "import 'package:$pkgName/${getLibFilePath(pkgDir, result.file)}' as s$i show");

      final clazzName = StringBuffer();

      for (var route in result.routes) {
        clazzName.write(" ${route.className}");
      }
      sb.write(clazzName.toString());
      sb.writeln(";");
    }
    return sb.toString();
  }

  String get classString {
    final sb = StringBuffer();
    sb.writeln("class $_packageClassName {");
    sb.writeln("  static Map<String, WidgetBuilder> $_packageFieldName = {");

    // 路由
    for (var i = 0; i < results.length; i++) {
      final result = results[i];
      final fileAs = "s$i";
      for (var route in result.routes) {
        sb.writeln(
            "    '${route.routeName}': (ctx) => $fileAs.${route.className}(),");
      }
    }

    sb.writeln("  };");
    sb.writeln("}");
    return sb.toString();
  }

  void makeCode() {
    final routeNameFile = File("$pkgDir/lib/$_packageRoutePath");
    routeNameFile.createSync(recursive: true);

    final sb = StringBuffer();

    sb.write(importString);
    sb.writeln();

    sb.write(classString);

    routeNameFile.writeAsStringSync(sb.toString(), flush: true);
  }
}

String getLibFilePath(String pkgDir, File file) {
  final libPath = File(pkgDir).absolute.path;
  var filePath = file.absolute.path;
  filePath = filePath.replaceAll(libPath, "");
  filePath = filePath.replaceFirst("lib", "");
  while (filePath.startsWith("/") || file.path.startsWith("\\")) {
    filePath = filePath.substring(1);
  }
  return filePath;
}

class MainProjectTemplate {
  void makeCode(
      String projectRootPath, Map<Generator, List<ScanResult>> results) {
    File file = File("$projectRootPath/$_applicationRoutePath");
    file.createSync(recursive: true);

    /// 1. 遍历
    /// 2. 获取pkg的名字
    /// 3. 拼接出 import 头 做 as
    StringBuffer sb = StringBuffer();
    sb.writeln("import 'package:flutter/widgets.dart';");
    final generators = results.keys.toList();

    for (var i = 0; i < generators.length; i++) {
      final generator = generators[i];
      final pkgName = generator.getPackageName();
      sb.writeln("import 'package:$pkgName$_packageRoutePath' as m$i;");
    }

    sb.writeln();
    sb.writeln("class OKRouteMap {");

    sb.writeln("  static Map<String, WidgetBuilder> getRoutes() {");

    sb.write(" " * 4);
    sb.writeln("Map<String, WidgetBuilder> routes = {};");

    for (var i = 0; i < generators.length; i++) {
      final fileAs = "m$i";
      sb.write(" " * 4);
      sb.writeln(
          "routes.addAll($fileAs.$_packageClassName.$_packageFieldName);");
    }

    sb.write(" " * 4);
    sb.writeln("return routes;");

    sb.writeln("  }");
    sb.writeln("}");
    file.writeAsStringSync(sb.toString());
  }
}
