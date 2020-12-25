import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:flutter_tts/flutter_tts.dart';


class MapScreen extends StatefulWidget {
  static String id = 'mapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


 // Completer<GoogleMapController> _controller = Completer();
  GoogleMapController googleMapController;

  final inputLang = TextEditingController();

  stt.SpeechToText _speech;
  bool _isListening = false;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            inputLang.text = val.recognizedWords;
          }),
        );
      }
    } else {
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

    bool isLocationServiceEnabled  = await Geolocator().isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return flutterTts.speak('افتح خدمة تحديد الموقع');
    }
    return getCurrentLocation();
  }
  // Position livelocation;
  // StreamSubscription<Position> positionStream =
  // Geolocator().getPositionStream(LocationOptions).
  // listen((Position position) {
  //
  // });


  Position position;
  void getCurrentLocation() async {
    try {

      Position currentposition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        position= currentposition;
      });

    } catch (e) {
      print(e);
    }
  }



  @override
  void initState() {
    super.initState();
    _getPosition();
    _speech = stt.SpeechToText();
    flutterTts.speak('مرحبا اين تريد ان تذهب');
    _listen();
    }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14.4746,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googleMapController = controller;
                markers.add(Marker(
                  markerId: MarkerId(''),
                  position: LatLng(position.latitude, position.longitude),
                ));
              });
            },
            markers: markers,
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
                child: Icon(_isListening ? Icons.mic : Icons.mic_none),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map),
            label: 'map',),
          BottomNavigationBarItem(icon: Icon(Icons.save),
            label: 'place',),
        ],
      ),
    );
  }
}
