import 'dart:async';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../Controller/time_controller.dart';

class GeoFence extends StatefulWidget {
  const GeoFence({super.key});
  @override
  State<GeoFence> createState() => _GeoFenceState();
}

class _GeoFenceState extends State<GeoFence> {

  final AddTimeController controller = Get.put(AddTimeController());
  bool buttonShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geofencing App'),
        ),
        body: Column(
          children: [
            buttonShow ? ElevatedButton(
              onPressed: () {
                startFenceTrack();
                setState(() {
                  buttonShow = false;
                });
              },
              child: const Text('Start Fence '),
            ) : const Text(""),
            Obx(() {
              return Text(controller.timeOfDuty.toString());
            })
          ],
        ));
  }

}


final AddTimeController controller = Get.put(AddTimeController());

void startFenceTrack() async {
  print("Function Called");
  if ( await handleLocationPermission() ){

    EasyGeofencing.startGeofenceService(
        pointedLatitude: "31.4561234",
        pointedLongitude: "73.1627984",
        radiusMeter: "250.0",
        eventPeriodInSeconds: 5
    );
      print("stream function");
    StreamSubscription<GeofenceStatus> geofenceStatusStream = EasyGeofencing.getGeofenceStream()!.listen(
            (GeofenceStatus status) {
          print("Geo Status ------------- ${status}" );
        });

  }
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("location service disable");
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location denied");
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    print(
        "Location permissions are permanently denied, we cannot request permissions");
    return false;
  }
  return true;
}
