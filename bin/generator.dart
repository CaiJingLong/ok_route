import 'dart:io';
import 'package:yaml/yaml.dart' as yaml;

class Generator {
  String projectRootPath;

  Generator(this.projectRootPath);

  bool isFlutterProject() {
    final dir = Directory(projectRootPath);
    if (!dir.existsSync()) {
      return false;
    }
    final yamlPath = "$projectRootPath/pubspec.yaml";
    var yamlFile = File(yamlPath);
    if (!yamlFile.existsSync()) {
      return false;
    }
    final document = yaml.loadYaml(yamlFile.readAsStringSync());
    return document["dependencies"]["flutter"] != null;
  }

  String getPackageName() {
    final yamlPath = "$projectRootPath/pubspec.yaml";
    var yamlFile = File(yamlPath);
    if (!yamlFile.existsSync()) {
      return null;
    }
    final document = yaml.loadYaml(yamlFile.readAsStringSync());
    return document["name"];
  }

  List<ScanResult> scanLib() {
    final list = List<ScanResult>();
    final lib = Directory("$projectRootPath/lib");
    final dartFiles = lib
        .listSync(recursive: true)
        .where((file) => file.path.endsWith(".dart"));
    for (final dartFile in dartFiles) {
      final result = scanFile(dartFile);
      if (result != null) {
        list.add(result);
      }
    }

    return list;
  }

  ScanResult scanFile(File file) {
    final str = file.readAsStringSync();
    final regex = RegExp("(@OKRoute\\(\"(.+)\"\\))");
    final all = regex.allMatches(str);
    if (all.isEmpty) {
      return null;
    }
    final result = ScanResult()..file = file;
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
      result.routes.add(Route()
        ..className = className
        ..routeName = routeName);
    }
    return result;
  }
}

class ScanResult {
  File file;
  List<Route> routes = [];
}

class Route {
  String className;
  String routeName;
}
