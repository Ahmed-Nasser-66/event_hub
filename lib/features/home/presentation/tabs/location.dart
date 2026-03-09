import 'package:event_hub/model/event_model11.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String? _style;
  late GoogleMapController _controller;
  Future<void> _loadmapStyle() async {
    final style = await rootBundle.loadString(
      'assets/map_style/map_style.json',
    );
    setState(() {
      _style = style;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadmapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.04470424153187, 31.234431758699028),
          zoom: 10,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          _controller = controller;
        },
        style: _style,
        // هي الخط الازرق
        polylines: {
          Polyline(
            polylineId: const PolylineId('1'),
            color: Colors.blue,
            width: 5,
            points: const [
              LatLng(30.0444, 31.2357), // Cairo
              LatLng(30.1700, 30.9500), // 6th of October area
              LatLng(30.5000, 30.3000), // Banha area
              LatLng(30.8000, 30.0000), // Tanta area
              LatLng(31.0000, 29.8000), // Damanhour area
              LatLng(31.2001, 29.9187), // Alexandria
            ],
          ),
        },
        // الدبوس
        markers: Event11.egyptEvents11
            .map(
              (event) => Marker(
                onTap: () {
                  _updateCameraPosition(
                    LatLng(event.latitude, event.longitude),
                  );
                },
                infoWindow: InfoWindow(title: event.title),
                markerId: MarkerId(event.id),
                position: LatLng(event.latitude, event.longitude),
              ),
            )
            .toSet(),
      ),
    );
  }

  Future<void> _updateCameraPosition(LatLng latLng) async {
    await _controller.animateCamera(
      duration: Duration(milliseconds: 500),
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 14)),
    );
  }
}
