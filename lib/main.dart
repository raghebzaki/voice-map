import 'package:flutter/material.dart';
import 'package:flutter_map/MapScreen.dart';


void main() {
  runApp(MyApp());
}

//api key = AIzaSyALjjwZbWSzttJvYm6QinIn-o9xTV1l2QY
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat',
      initialRoute: MapScreen.id,
      routes: {
        MapScreen.id:(context) => MapScreen(),
      },
    );
  }
}

