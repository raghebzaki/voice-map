import 'package:flutter/material.dart';
import 'package:flutter_map/Database/MyDatabase.dart';
import 'package:flutter_map/Database/PlaceList.dart';
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
      body: Center(
          child: FutureBuilder(
            future: myDatabase.getAll(),
            builder: (context, AsyncSnapshot snapshot){

              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder:  (context, i){
                      PlaceList placeList = PlaceList.fromMap(snapshot.data[i]);
                      return Card(
                        child: ListTile(
                          title: Text('${placeList.placeName} '),
                          subtitle: Text('${placeList.userlat} , ${placeList.userlng}'),
                          trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed: (){
                            setState(() {
                              myDatabase.delete(placeList.placeName);
                            });
                            },
                          ),
                        ),
                      );
                    }
                );
              }
            },
          ),
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
