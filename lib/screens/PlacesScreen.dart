import 'package:flutter/material.dart';
import 'package:flutter_map/widget/menu.dart';

class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Saved Places'),
      ),
      body: Center(
          child: Text('place screen')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed('AddNewPlaceScreen');
        },
      ),
    );
  }
}
