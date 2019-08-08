import 'package:flutter/material.dart';
import 'package:ok_route/ok_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

@OKRoute("/sub_home")
class Page extends StatelessWidget {
  final Map<String, dynamic> params = {};

  Page({Key key}) : super(key: key) {
    this.params.addAll(OKRouteParams.getParams(this));
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
