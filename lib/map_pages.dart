import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ice_breaker_2025/const.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// void main() {
//   runApp(const Maps());
// }

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Location _locationController =
      new Location(); // This is location class which has some function
  // and we are initiating the class with a variable _locationController
  // & later using this variable for performing other thigs

  //late GoogleMapController mapController;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Map<PolylineId, Polyline> polylines = {};

  final LatLng herlocation = const LatLng(44.4071, 8.9347);
  final LatLng yourlocation = const LatLng(44.4171, 8.9447);
  LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
    getUpdateLocations().then((_) => {
          getPolylinePoints().then((coordinates) => {
                generatePolyLinesFromPoints(coordinates),
              }),
        });
  }

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Maps  App'),
            elevation: 2,
          ),
          body: _currentP == null
              ? const Center(
                  child: Text('Loading.....'),
                )
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) =>
                      (mapController.complete(controller)),
                  initialCameraPosition: CameraPosition(
                    target: herlocation,
                    zoom: 8.0,
                  ),
                  markers: {
                    Marker(
                        markerId: MarkerId("current location"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _currentP!),
                    Marker(
                        markerId: MarkerId("herlocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: herlocation),
                    Marker(
                        markerId: MarkerId("yourlocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: yourlocation)
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                )),
    );
  }

// Build a function which point the camera  towards sepcific loation

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 7);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

//// The above function is updating the new position
  Future<void> getUpdateLocations() async {
    bool _serviceEnable;
    PermissionStatus _permissionGranted;

    // For here we are using service enable function

    _serviceEnable = await _locationController.serviceEnabled();
    if (_serviceEnable) {
      _serviceEnable = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // _cameraToPosition(_currentP!);
        });
      }
    });
  }

  void generatePolyLinesFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
      visible: true,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAPS_API_KEYS,
      request: PolylineRequest(
        origin: PointLatLng(yourlocation.latitude, yourlocation.longitude),
        destination: PointLatLng(_currentP!.latitude, _currentP!.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      print("Polyline points: $polylineCoordinates");
    } else {
      print("Error fetching polyline: ${result.errorMessage}");
    }

    return polylineCoordinates;
  }
}
