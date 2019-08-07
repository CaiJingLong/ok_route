import 'dart:io';

import 'package:ok_route/ok_route.dart';

import 'generator.dart';

main(List<String> arguments) {
  final dir = Directory.current;
  var generator = Generator("/Users/caijinglong/code/flutter/sxw/sxw_order_2");
  print(generator.isFlutterProject());
  print(generator.getPackageName());
  // final file = File("${dir.path}/bin/main.dart");
  // scanFile(file);
}

void scanFile(File file) {
  final str = file.readAsStringSync();
  final regex = RegExp("(@OKRoute\\(\"(.+)\"\\))");
  final all = regex.allMatches(str);
  if (all.isEmpty) {
    return;
  }
  for (final match in all) {
    // print(match.group(1));
    final routeName = match.group(2);
    final next = str.substring(match.end, str.length);

    var classNameReg = RegExp("class\ (.+) extends");
    var nameMatch = classNameReg.firstMatch(next);
    if (nameMatch == null) {
      classNameReg = RegExp("class\ (.+) \\{");
      nameMatch = classNameReg.firstMatch(next);
    }
    final className = nameMatch.group(1).trim();
    // print("");
  }
}

@OKRoute("/home")
class Page extends BasePage {}

@OKRoute("/base")
class BasePage {}
