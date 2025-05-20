import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SendLocation extends StatefulWidget {
  @override
  _SendLocationState createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {
  String? lat;
  String? long;
  String locationMessage = "Location not yet determined";

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openGoogleMap(String lat, String long) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Location")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  Position value = await _getCurrentLocation();
                  setState(() {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    locationMessage = 'Latitude: $lat, Longitude: $long';
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: Text("Get Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (lat != null && long != null) {
                  _openGoogleMap(lat!, long!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please get location first')),
                  );
                }
              },
              child: Text('Open in Google Maps'),
            ),
            SizedBox(height: 20),
            Text(locationMessage),
          ],
        ),
      ),
    );
  }
}
