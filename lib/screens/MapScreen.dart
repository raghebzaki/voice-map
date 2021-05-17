import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/Database/MyDatabase.dart';
import 'package:flutter_map/Database/PlaceList.dart';
import 'package:flutter_map/services/TextToSpeech.dart';
import 'package:flutter_map/widget/menu.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as map;

import '../services/TextToSpeech.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  void _getPosition() async {
    bool isLocationServiceEnabled = await location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      return flutterTts.speak('افتح خدمة تحديد الموقع');
    }
  }

  GoogleMapController googleMapController;
  Location location = new Location();

  void _onMapCreated(GoogleMapController _controller) {
    googleMapController = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15)));
    });
  }


  // Set<Marker> _markers = {};
  // void _setMarker(double lat, double lng) {
  //   Marker newMarker = Marker(
  //     markerId: MarkerId(lat.toString()),
  //     icon: BitmapDescriptor.defaultMarker,
  //     position: LatLng(lat, lng),
  //   );
  //   _markers.add(newMarker);
  //   setState(() {});
  // }


  var items = [];
  PlaceList placeList;
  stt.SpeechToText _speech;
  final inputLang = TextEditingController();

  void listen() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      _speech.listen(
        onResult: (val) =>
            setState(() {
              inputLang.text = val.recognizedWords;
              if (inputLang.text != null) {
                Future.delayed(Duration(seconds: 2), () {
                  speak(inputLang.text);
                });

              }
            }),
      );
    } else {
      _speech.stop();
    }
  }


  @override
  void initState() {
    super.initState();
    flutterTts.speak('مرحبا اين تريد ان تذهب');
    _getPosition();
    Future.delayed(Duration(seconds: 3), () {
      _speech = stt.SpeechToText();
      listen();
    });
  }

  double destinationLatitude  ;
  double destinationLongitude ;
  double originLatitude ;
  double originLongitude ;

  void destination()async{
    if(inputLang.text!=null) {
      MyDatabase().getRow(inputLang.text).then((value) {
        setState(() {
          items = value;
          placeList = PlaceList.fromMap(items[0]);
          destinationLatitude = placeList.userLat;
          destinationLongitude = placeList.userLng;
        });
      });
    }
    LocationData _locationData = await location.getLocation();
    setState(() {
      originLatitude =_locationData.latitude;
      originLatitude =_locationData.longitude;
    });
  }

  map.DirectionsMode directionsMode = map.DirectionsMode.walking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('map'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.directions),
        onPressed: () async {
          if(inputLang.text!=null)
            {
              destination();
             await map.MapLauncher.showDirections(
              mapType: map.MapType.google,
              destination: map.Coords(destinationLatitude,destinationLongitude),
              origin: map.Coords(originLatitude, originLongitude),
              directionsMode: directionsMode
          );
        }
        else {
          speak('اختر المكان اولا');
          }
      }
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.063549, 31.249667),
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      )),
                  controller: inputLang,
                ),
              ),
              FloatingActionButton(
                onPressed: listen,
                child: Icon(Icons.mic),
              ),
            ],
          )
        ],
      ),
    );
  }

}