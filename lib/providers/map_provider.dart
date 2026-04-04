import 'package:event_hub/features/home/presentation/location/location_service.dart';
import 'package:event_hub/model/event_model11.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  final LocationService _service = LocationService();

  LatLng? currentLocation;
  String? mapStyle;
  Set<Marker> markers = {};
  GoogleMapController? controller;

  List<Event11> searchResults = [];
  Set<Polyline> polylines = {};

  Event11? selectedEvent;

  Future<void> initializeMap() async {
    currentLocation = await _service.getCurrentLocation();
    try {
      mapStyle = await rootBundle.loadString('assets/map_style/map_style.json');
    } catch (e) {
      debugPrint("Map style error: $e");
    }
    _loadEventsMarkers();
    notifyListeners();
  }

  void _loadEventsMarkers() {
    markers = Event11.egyptEvents11
        .map((event) => Marker(
              markerId: MarkerId(event.id),
              position: LatLng(event.latitude, event.longitude),
              infoWindow: InfoWindow(title: event.title),
              onTap: () {
                selectEvent(event);
              },
            ))
        .toSet();
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      searchResults = [];
    } else {
      searchResults = Event11.egyptEvents11.where((e) {
        final lowerQuery = query.toLowerCase();
        return e.title.toLowerCase().contains(lowerQuery) ||
            e.category.toLowerCase().contains(lowerQuery) ||
            e.city.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  void selectEvent(Event11 event) {
    selectedEvent = event;

    final destination = LatLng(event.latitude, event.longitude);

    controller?.animateCamera(CameraUpdate.newLatLngZoom(destination, 14));
    controller?.showMarkerInfoWindow(MarkerId(event.id));

    if (currentLocation != null) {
      _drawRoute(currentLocation!, destination);
    }

    searchResults = [];
    notifyListeners();
  }

  void _drawRoute(LatLng start, LatLng end) {
    polylines.clear();
    polylines.add(
      Polyline(
        polylineId: const PolylineId("path_to_event"),
        points: [start, end],
        color: Colors.orange,
        width: 5,
        geodesic: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    );
    notifyListeners();
  }

  void moveToLocation(LatLng position) {
    selectedEvent = null;
    controller?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    polylines.clear();
    notifyListeners();
  }
}
