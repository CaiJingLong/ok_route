import 'dart:io';

import 'package:ok_route/ok_route.dart';

import 'generator.dart';
import 'project_helper.dart';

main(List<String> arguments) {
  var projectRootPath =
      "/Users/caijinglong/code/flutter/sxw/sxw_order_2"; // 主应用文件夹

  final helper = ProjectHelper(projectRootPath);
  final projects = helper.loadProjectPathList(); // 获取所有主应用的依赖文件夹(相对路径)
  projects.add("."); // 把主文件夹对应的目录放进来

  Map<Generator, List<ScanResult>> results = {};

  for (var libraryPath in projects) {
    libraryPath = "$projectRootPath/$libraryPath"; // 绝对路径
    var generator = Generator(libraryPath);

    // 不是flutter工程,忽略
    if (!generator.isFlutterProject()) {
      continue;
    }
    print(generator.getPackageName()); // 应用的包名, 后面导入或导出的时候用
    final scanResults = generator.scanLib(); // 扫描包得到注解对应的结果, 注意:不递归
    results[generator] = scanResults;
  }

  // final file = File("${dir.path}/bin/main.dart");
  // scanFile(file);
}

@OKRoute("/home")
class Page extends BasePage {}

@OKRoute("/base")
class BasePage {}
