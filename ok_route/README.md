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
      - [aboult resource](#aboult-resource)
  - [LICENSE](#license)

## Usage

### import project

```yaml
dependencies:
  ok_route: ^0.1.2
```

### Add Annotation to your widget

```dart
import `package:ok_route:okroute.dart`;

@OKRoute("/home")
class HomePage extends StatelessWidget{
    // ...
}
```

### Generate route class

#### How to use pub global

Use [`pub global`](https://dart.dev/tools/pub/cmd/pub-global)

Add `pub/pub.bat` to your \$PATH.

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
      routes: OKRouteMap.getRoutes(), // routes create by ok_route.
    );
  }
}
```

## Pass params

### Push

Only support basic type, because it will be converted to json during the transfer process.

```dart
  final name = OKRoute.createPushString(
    "/sub_home",
    params: {"name": "hello"},
  );
  Navigator.of(context).pushNamed(name);
```

### Get

```dart
  final params = OKRouteParams.getParams(this); // 'this' is widget. If you use the mothod in state, you need use OKRouteParams.getParams(widget);
  final name = params["name"];
  print(name); // "hello"
```

#### aboult resource

Because the parameters passed are cached, you need to release the resources of the parameters at the right time.

StatelessWidget:

```dart
@OKRoute("/sub_home")
class Page extends StatelessWidget {
  final Map<String, dynamic> params = {};

  Page({Key key}) : super(key: key) {
    this.params.addAll(OKRouteParams.getParams(this)); // the method will remove param in current;
  }

  @override
  Widget build(BuildContext context) {
    final name = params["name"];

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

StatefulWidget:

```dart
@OKRoute("/route_page")
class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  Map<String, dynamic> params;

  @override
  void initState() {
    super.initState();
    params = OKRouteParams.getParams(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Text(params["name"]);
  }

  @override
  void dispose() {
    OKRouteParams.removeParams(widget);
    super.dispose();
  }

}
```

## LICENSE

MIT style
