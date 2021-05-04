import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/services/Polyline.dart';
import 'package:flutter_map/services/TextToSpeech.dart';
import 'package:flutter_map/widget/menu.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  void _getPosition() async {
    bool isLocationServiceEnabled  = await location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      return flutterTts.speak('افتح خدمة تحديد الموقع');
    }
  }
  GoogleMapController googleMapController;
  Location location = new Location();
  void _onMapCreated (GoogleMapController _controller)
  {
    googleMapController =_controller;
    location.onLocationChanged.listen((l){
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 13)) );
    }) ;
  }


  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};



  Future<void> _drawPolyline(double fromlatitude, double fromlongitude, double tolatitude, double tolongitude) async {
    Polyline polyline = await PolylineService().drawPolyline(
        fromlatitude,
        fromlongitude,
        tolatitude ,
        tolongitude
    );
    _polylines.add(polyline);
    _setMarker(fromlatitude, fromlongitude);
    _setMarker(tolatitude, tolongitude);

    setState(() {

    });
  }

  stt.SpeechToText _speech;
  final inputLang = TextEditingController();
  void listen() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (val) =>
            setState(() {
              inputLang.text = val.recognizedWords;
              if(inputLang.text!=null)
              {
                Future.delayed(Duration( seconds: 2),(){
                  speak(inputLang.text);
                });
                location.onLocationChanged.listen((LocationData currentLocation) {
                  _drawPolyline(currentLocation.latitude, currentLocation.longitude, 30.063549, 31.249667);
                });
              }
            }),
      );
    }else {
      _speech.stop();
    }
  }

  void _setMarker(double lat, double lng) {
    Marker newMarker = Marker(
      markerId: MarkerId(lat.toString()),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat,lng),
    );
    _markers.add(newMarker);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    flutterTts.speak('مرحبا اين تريد ان تذهب');
    _getPosition();
    Future.delayed(Duration( seconds: 3),(){
      _speech = stt.SpeechToText();
      listen();
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('map'),
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
            polylines: _polylines,
            markers: _markers,
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
                        borderSide: BorderSide(
                            color: Colors.blueAccent,width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      )
                  ),
                  controller: inputLang,
                ),
              ),
              // FloatingActionButton(onPressed: ()=> speak(inputLang.text),
              //   child: Icon(Icons.audiotrack),
              // ),
              FloatingActionButton(onPressed: listen,
                child: Icon(Icons.mic),
              ),
            ],
          )
        ],
      ),
    );
  }
}
