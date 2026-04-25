import 'package:event_hub/features/home/presentation/location/location_service.dart';
import 'package:event_hub/model/event_data.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  final LocationService _service = LocationService();

  LatLng? currentLocation;
  String? mapStyle;
  Set<Marker> markers = {};
  GoogleMapController? controller;

  List<EventModel> searchResults = [];
  Set<Polyline> polylines = {};

  EventModel? selectedEvent;

  // ✅ المتغيرات الجديدة
  bool _isLoading = false;
  String? _errorMessage;

  // ✅ أضف هذا المتغير لمنع الطلبات المتكررة
  bool _isLocationFetched = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> initializeMap() async {
    // ✅ منع الطلبات المتكررة: لو الموقع جابته قبل كده، متجيبوش تاني
    if (_isLocationFetched && currentLocation != null) {
      debugPrint("📍 Location already fetched, skipping...");
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      currentLocation = await _service.getCurrentLocation();

      if (currentLocation == null) {
        _errorMessage = "Could not get current location";
      } else {
        _errorMessage = null;
        _isLocationFetched = true; // ✅ علامة ان الموقع جابته
      }

      try {
        mapStyle =
            await rootBundle.loadString('assets/map_style/map_style.json');
      } catch (e) {
        debugPrint("Map style error: $e");
      }

      _loadEventsMarkers();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Initialize map error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ دالة refreshLocation
  Future<void> refreshLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      currentLocation = await _service.getCurrentLocation();

      if (currentLocation == null) {
        _errorMessage = "Could not refresh location";
      } else {
        _isLocationFetched = true; // ✅ تحديث العلامة
        _loadEventsMarkers();

        if (controller != null && currentLocation != null) {
          controller?.animateCamera(
            CameraUpdate.newLatLngZoom(currentLocation!, 14),
          );
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Refresh location error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ دالة retryLocation
  Future<void> retryLocation() async {
    await refreshLocation();
  }

  // ✅ دالة للتحقق من صحة الموقع
  bool get hasLocation => currentLocation != null;

  // ✅ تحميل الـ markers من repository
  void _loadEventsMarkers() {
    markers = EventRepository.allEvents.map((event) {
      return Marker(
        markerId: MarkerId(event.id),
        position: LatLng(event.latitude, event.longitude),
        infoWindow: InfoWindow(title: event.title),
        onTap: () {
          selectEvent(event);
        },
      );
    }).toSet();
  }

  // ✅ Search
  void searchEvents(String query) {
    if (query.isEmpty) {
      searchResults = [];
    } else {
      final lowerQuery = query.toLowerCase();

      final startMatches = EventRepository.allEvents.where((e) {
        return e.title.toLowerCase().startsWith(lowerQuery) ||
            e.category.toLowerCase().startsWith(lowerQuery) ||
            e.location.toLowerCase().startsWith(lowerQuery);
      }).toList();

      final containsMatches = EventRepository.allEvents.where((e) {
        return (e.title.toLowerCase().contains(lowerQuery) ||
                e.category.toLowerCase().contains(lowerQuery) ||
                e.location.toLowerCase().contains(lowerQuery)) &&
            !(e.title.toLowerCase().startsWith(lowerQuery) ||
                e.category.toLowerCase().startsWith(lowerQuery) ||
                e.location.toLowerCase().startsWith(lowerQuery));
      }).toList();

      searchResults = [...startMatches, ...containsMatches];
    }

    notifyListeners();
  }

  void selectEvent(EventModel event) {
    selectedEvent = event;

    final destination = LatLng(event.latitude, event.longitude);

    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(destination, 14),
    );

    controller?.showMarkerInfoWindow(
      MarkerId(event.id),
    );

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

    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(position, 15),
    );

    polylines.clear();
    notifyListeners();
  }

  // ✅ دالة لتنظيف الموارد
  void disposeMap() {
    controller?.dispose();
    polylines.clear();
    markers.clear();
    searchResults.clear();
  }
}
