import 'package:flutter/material.dart';
import 'file:///C:/Users/raghebzaki/AndroidStudioProjects/flutter_map/lib/screens/MapScreen.dart';
import 'package:flutter_map/screens/PlacesScreen.dart';
import 'package:flutter_map/screens/AddNewPlaceScreen.dart';

import 'screens/ChooseOnMapScreen.dart';
import 'widget/theme.dart';


void main() {
  runApp(MyApp());
}

//api key = AIzaSyALjjwZbWSzttJvYm6QinIn-o9xTV1l2QY
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myThemeData,
      initialRoute: 'MapScreen',
      routes: {
        'MapScreen':(context) => MapScreen(),
        'PlacesScreen':(context) => PlacesScreen(),
        'AddNewPlaceScreen':(context) => AddNewPlaceScreen(),
        'ChooseOnMapScreen':(context) => ChooseOnMap(),
      },
    );
  }
}

