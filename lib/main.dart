import 'package:flutter/material.dart';
import 'package:majar_event/res/strings.dart';
import 'package:majar_event/ui/add_event.dart';
import 'package:majar_event/ui/list.dart';

void main() => runApp(MajarEventApp());

class MajarEventApp extends StatelessWidget {
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (context) => EventListPage(title: Strings.titleList),
    '/add_event': (context) => AddEventPage(title: Strings.titleAddEvent),
  };

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
          primarySwatch: Colors.yellow,
        ),
        routes: _routes);
  }
}
