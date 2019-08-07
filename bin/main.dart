import 'dart:io';

import 'package:ok_route/ok_route.dart';

main(List<String> arguments) {
  final dir = Directory.current;
  final file = File("${dir.path}/bin/main.dart");
  scanFile(file);
}

void scanFile(File file) {
  final str = file.readAsStringSync();
  final regex = RegExp("(@OKRoute\\(\"(.+)\"\\))");
  final all = regex.allMatches(str);
  for (final match in all) {
    print(match.group(1));
    print(match.group(2));
    final next = str.substring(match.end, str.length);

    final classNameReg = RegExp("class\ (.+) ({|extends)");
    final nameMatch = classNameReg.firstMatch(next);
    print(nameMatch.group(1));
    print("");
  }
}

@OKRoute("/home")
class Page extends BasePage {}

@OKRoute("/base")
class BasePage {}
