# ok_route

Annotation route of flutter.

- [ok_route](#okroute)
  - [Usage](#usage)
    - [import project](#import-project)
    - [Add Annotation to your widget](#add-annotation-to-your-widget)
    - [Generate route class](#generate-route-class)
      - [How to use pub global](#how-to-use-pub-global)
      - [Get generator](#get-generator)
      - [Use generator](#use-generator)
    - [Use route in your project](#use-route-in-your-project)
  - [Pass params](#pass-params)
    - [Push](#push)
    - [Get](#get)
  - [LICENSE](#license)

## Usage

### import project

```yaml
dependencies:
  ok_route_library: ^0.1.1
```

### Add Annotation to your widget

```dart
import 'package:ok_route_library/ok_route_library.dart';

@OKRoute("/home")
class HomePage extends StatelessWidget{
    // ...
}
```

### Generate route class

#### How to use pub global

Use [`pub global`](https://dart.dev/tools/pub/cmd/pub-global)

Add `pub/pub.bat` to your `$PATH`.

Add cache/bin to your path like image

![20190808104703.png](https://raw.githubusercontent.com/kikt-blog/image/master/img/20190808104703.png)

#### Get generator

`$ pub global activate ok_route`

or

`$ pub.bat global activate ok_route`

#### Use generator

`$ ok_route $your_project`

### Use route in your project

```dart
import 'package:ok_route_example/okroutes.dart'; // The dart file have the routes.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: OKRouteMap.onGenerateRoute, // routes create by ok_route.
    );
  }
}
```

## Pass params

### Push

Only support basic type, because it will be converted to json during the transfer process.

```dart
import 'package:ok_route_library/ok_route_library.dart';

  final name = OKRoute.createPushString(
    "/sub_home",
    params: {"name": "hello"},
  );
  Navigator.of(context).pushNamed(name);

// or

  OKRoute.pushNamed(context, "/sub_home", params: {"name": "hello"},);

```

### Get

```dart
import 'package:ok_route_library/ok_route_library.dart';

@OKRoute("/sub_home")
class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = OKRoute.getParams(context)["name"]; // Get params , the params type is Map<String,dynamic>.
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(name),
          ],
        ),
      ),
    );
  }
}

```

## LICENSE

MIT style
