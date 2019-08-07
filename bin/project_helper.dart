import 'dart:io';

import 'package:yaml/yaml.dart';

class ProjectHelper {
  String applicationProjectPath;

  ProjectHelper(this.applicationProjectPath);

  List<String> loadProjectPathList() {
    final file = File("$applicationProjectPath/pubspec.yaml");
    if (!file.existsSync()) {
      throw Exception("The project path set error.");
    }
    final doc = loadYaml(file.readAsStringSync());
    final deps = doc["dependencies"];
    final result = <String>[];
    for (final dep in deps.keys) {
      var node = deps[dep];
      if (node is String) {
        continue;
      }
      if (node is YamlMap) {
        if (deps[dep]["path"] != null) {
          result.add(deps[dep]["path"]);
        }
      }
    }

    return result;
  }
}
