import 'dart:io';

import 'package:ok_route/ok_route.dart';

import 'code_maker.dart';
import 'generator.dart';
import 'project_helper.dart';

main(List<String> arguments) {
  String projectRootPath;
  if (arguments.length == 0) {
    projectRootPath = Directory.current.path;
  } else {
    projectRootPath = arguments[0];
  }

  print("loading $projectRootPath dir.");

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
    print("scaning ${generator.getPackageName()} start."); // 应用的包名, 后面导入或导出的时候用
    final scanResults = generator.scanLib(); // 扫描包得到注解对应的结果, 注意:不递归
    print("scaning ${generator.getPackageName()} finish.");
    results[generator] = scanResults;
  }

  // 生成, 2种方案:

  //  1. 每个子项目生成自己的route map, 主工程引用子项目 ,初步决定用这种
  //  2. 主工程直接在同一个文件引入所有子工程的route map

  CodeMaker().makeCode(projectRootPath, results);

  print("make route finish.");
}

@OKRoute("/home")
class Page extends BasePage {}

@OKRoute("/base")
class BasePage {}
