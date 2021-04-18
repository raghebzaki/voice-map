import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/widget/menu.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  final inputLang = TextEditingController();

  stt.SpeechToText _speech;
  bool _isListening = false;

  void _listen() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) =>
            setState(() {
              inputLang.text = val.recognizedWords;
              if(inputLang.text!=null)
                {speak(inputLang.text);}
            }),
      );
    }else {
      setState(() => _isListening = false);
      _speech.stop();
    }
   }

  FlutterTts flutterTts = FlutterTts();
  Future speak(String text) async{
    await flutterTts.setLanguage('ar');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void _getPosition() async {
    bool isLocationServiceEnabled  = await _location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      return flutterTts.speak('افتح خدمة تحديد الموقع');
    }
  }
  GoogleMapController googleMapController;
  Location _location = new Location();

  void _onMapCreated (GoogleMapController _controller)
  {
    googleMapController =_controller;
    _location.onLocationChanged.listen((l){
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15,)) );
    });

  }



  @override
  void initState() {
    super.initState();
    flutterTts.speak('مرحبا اين تريد ان تذهب');
    _getPosition();
    Future.delayed(Duration( seconds: 2),(){
      _speech = stt.SpeechToText();
      _listen();
    });
    }

  Set<Marker> markers = {};
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
              target: LatLng(35.0759441, 31.2385913),
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
              FloatingActionButton(onPressed: _listen,
                child: Icon(Icons.mic),
              ),
            ],
          )
        ],
      ),
    );
  }
}
