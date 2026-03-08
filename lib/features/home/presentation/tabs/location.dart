import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GoogleMapController? mapController;

  // إحداثيات مبدئية (القاهرة مثلاً) لحد ما نحدد مكانه
  static const LatLng _center = LatLng(30.0444, 31.2357);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Locations'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        myLocationEnabled: true, // بيظهر النقطة الزرقاء مكان المستخدم
        myLocationButtonEnabled: true, // الزرار اللي بيرجعك لمكانك
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _determinePosition,
        label: const Text('Get Current Location'),
        icon: const Icon(Icons.location_searching),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // الفانكشن اللي بتجيب اللوكيشن الفعلي وتتحرك له
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تشيك هل الـ GPS شغال أصلاً؟
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    // جلب الإحداثيات الحالية
    Position position = await Geolocator.getCurrentPosition();

    // تحريك كاميرا الخريطة لمكان المستخدم
    mapController?.animateCamera(
      CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
    );
  }
}
