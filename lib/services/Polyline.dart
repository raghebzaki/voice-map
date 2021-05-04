import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineService {
  Future<Polyline> drawPolyline(double fromlatitude, double fromlongitude, double tolatitude, double tolongitude) async {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyALjjwZbWSzttJvYm6QinIn-o9xTV1l2QY',
        PointLatLng(fromlatitude, fromlongitude),
        PointLatLng(tolatitude, tolongitude)
    );

    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });

    return Polyline(
      polylineId: PolylineId("polyline_id ${result.points.length}"),
      points: polylineCoordinates,
      color: Colors.blue,
    );
  }
}