import 'package:flutter/material.dart';
import 'package:ok_route_library/ok_route_library.dart';

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
  @override
  Widget build(BuildContext context) {
    final name = OKRouteParams.of(context)["name"];
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final params = OKRouteParams.of(context);
    return Text(params["name"] * 2);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
