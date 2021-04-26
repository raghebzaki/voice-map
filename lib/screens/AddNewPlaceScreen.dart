import 'package:flutter/material.dart';
import 'package:flutter_map/screens/ChooseOnMapScreen.dart';
import 'package:flutter_map/widget/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewPlaceScreen extends StatefulWidget {
  @override
  _AddNewPlaceScreenState createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  LatLng location ;
  var latController = TextEditingController();
  var lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
          children: [ Column(
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
                    hintText: 'enter latitude',
                    alignLabelWithHint: false,
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20,),
                  controller: latController,
                ),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                //height: height*.2,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: 'enter longitude',
                    alignLabelWithHint: false,
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20,),
                  controller: lngController,
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
                        onPressed: (){_awaitReturnValue(context);},
                        icon: FaIcon(FontAwesomeIcons.mapMarker),
                        label: Text('map'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('save'),
                onPressed: () {
                  Navigator.of(context).pushNamed('PlacesScreen');
                },
              ),
            ),
      ]
      ),
    );
  }
  void _awaitReturnValue(BuildContext context) async {
    LatLng result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChooseOnMap(),
        ));
    setState(() {
      location = result;
      latController.text =location.latitude.toString();
      lngController.text =location.longitude.toString();
    });
  }
}
