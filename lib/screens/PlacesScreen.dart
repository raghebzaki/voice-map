import 'package:flutter/material.dart';
import 'package:flutter_map/Database/MyDatabase.dart';
import 'package:flutter_map/widget/menu.dart';

class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  MyDatabase myDatabase =MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Saved Places'),
      ),
      // body: Center(
      //     child: FutureBuilder(
      //       future: myDatabase.getall(),
      //       builder: (context, AsyncSnapshot<List<PlaceList>> snapshot) {
      //         Switch(snapshot.connectionState, ){
      //           case ConnectionState.none:
      //             return Center(child: Text('error no connection made'),);
      //             break;
      //             case ConnectionState.waiting;
      //         }
      //       },
      //     )
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed('AddNewPlaceScreen');
        },
      ),
    );
  }
}
