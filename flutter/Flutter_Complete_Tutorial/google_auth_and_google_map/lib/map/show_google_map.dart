import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreeen extends StatefulWidget {
  final double latitude, longitude;

  const GoogleMapScreeen(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<GoogleMapScreeen> createState() => _GoogleMapScreeenState();
}

class _GoogleMapScreeenState extends State<GoogleMapScreeen> {
  double _latitude = 0.0, _longitude = 0.0;

  _initialize() {
    _latitude = widget.latitude;
    _longitude = widget.longitude;

    setState(() {});
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          mapType: MapType.hybrid,
          markers: {
            Marker(
                markerId: const MarkerId('locate'),
                zIndex: 1,
                draggable: true,
                onDragEnd: (latLng) {
                  _latitude = latLng.latitude;
                  _longitude = latLng.longitude;

                  setState(() {});
                },
                position: LatLng(_latitude, _longitude))
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(_latitude, _longitude), zoom: 18.478),
        ),
      ),
    );
  }
}
