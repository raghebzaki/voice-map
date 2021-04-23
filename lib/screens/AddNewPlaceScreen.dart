import 'package:flutter/material.dart';
import 'package:flutter_map/widget/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewPlaceScreen extends StatefulWidget {
  LatLng position;
  AddNewPlaceScreen({this.position});
  @override
  _AddNewPlaceScreenState createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  LatLng position;
  _AddNewPlaceScreenState({this.position});

  var location = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(position);
    location.text=position as String;
  }
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              //height: height*.2,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'enter place name',
                  alignLabelWithHint: false,
                  filled: true,
                ),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.blueAccent, fontSize: 20,),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              margin: EdgeInsets.all(10.0),
              //height: height*.2,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'enter latitude and longitude',
                  alignLabelWithHint: false,
                ),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.blueAccent, fontSize: 20,),
                controller: location,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    child: Text('choose on map'),
                    width: width*.5,
                  ),

                  Expanded(
                    child: Container(
                      width: width*.5,
                      child: RaisedButton.icon(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.of(context).pushNamed('ChooseOnMapScreen');
                      },
                      icon: FaIcon(FontAwesomeIcons.mapMarker),
                      label: Text('map'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
      ),
    );
  }
}
