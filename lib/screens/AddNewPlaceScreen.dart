import 'package:flutter/material.dart';
import 'package:flutter_map/widget/menu.dart';

class AddNewPlaceScreen extends StatefulWidget {
  @override
  _AddNewPlaceScreenState createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Center(
          child: Text('add new screen screen')
      ),
    );
  }
}
