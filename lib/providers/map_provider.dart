import 'package:event_hub/core/api/events_service.dart';
import 'package:event_hub/features/home/presentation/location/location_service.dart';
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

  bool _isMapInitializing = false;
  bool _isEventsLoading = false;

  bool get isLoading => _isMapInitializing || _isEventsLoading;

  String? _errorMessage;

  bool _isLocationFetched = false;

  List<EventModel> _allEvents = [];

  String? get errorMessage => _errorMessage;

  Future<void> initializeMap() async {
    if (_isLocationFetched && currentLocation != null) return;

    _isMapInitializing = true;
    notifyListeners();

    try {
      currentLocation = await _service.getCurrentLocation();

      if (currentLocation == null) {
        _errorMessage = "Could not get current location";
      } else {
        _errorMessage = null;
        _isLocationFetched = true;
      }

      try {
        mapStyle = await rootBundle.loadString(
          'assets/map_style/map_style.json',
        );
      } catch (e) {
        debugPrint("Map style error: $e");
      }

      await loadEventsFromApi();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Initialize map error: $e");
    } finally {
      _isMapInitializing = false;
      notifyListeners();
    }
  }

  Future<void> loadEventsFromApi() async {
    if (_isEventsLoading) return;

    _isEventsLoading = true;

    try {
      final eventsService = EventsService();

      final response = await eventsService.getAllEvents();

      if (response.data['success'] == true) {
        final List<dynamic> eventsJson = response.data['message']['data'] ?? [];

        debugPrint("Events Count: ${eventsJson.length}");

        _allEvents = eventsJson.map((json) {
          return EventModel.fromJson(json);
        }).toList();

        _loadEventsMarkers();

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Load events error: $e");
    } finally {
      _isEventsLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshLocation() async {
    _isMapInitializing = true;
    _errorMessage = null;

    notifyListeners();

    try {
      currentLocation = await _service.getCurrentLocation();

      if (currentLocation == null) {
        _errorMessage = "Could not refresh location";
      } else {
        _isLocationFetched = true;

        _loadEventsMarkers();

        if (controller != null && currentLocation != null) {
          controller?.animateCamera(
            CameraUpdate.newLatLngZoom(
              currentLocation!,
              14,
            ),
          );
        }
      }
    } catch (e) {
      _errorMessage = e.toString();

      debugPrint(
        "Refresh location error: $e",
      );
    } finally {
      _isMapInitializing = false;

      notifyListeners();
    }
  }

  Future<void> retryLocation() async {
    await refreshLocation();
  }

  bool get hasLocation => currentLocation != null;

  void _loadEventsMarkers() {
    markers = _allEvents
        .where(
      (event) => event.latitude != null && event.longitude != null,
    )
        .map((event) {
      debugPrint(
        "Event => ${event.title} | ${event.latitude} | ${event.longitude}",
      );

      return Marker(
        markerId: MarkerId(event.id.toString()),
        position: LatLng(
          event.latitude!,
          event.longitude!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        ),
        infoWindow: InfoWindow(
          title: event.title,
        ),
        onTap: () {
          selectEvent(event);
        },
      );
    }).toSet();

    debugPrint(
      "Markers Count: ${markers.length}",
    );

    notifyListeners();
  }

  void moveToFirstEventIfReady() {
    if (markers.isEmpty || controller == null) return;

    controller!.animateCamera(
      CameraUpdate.newLatLngZoom(
        markers.first.position,
        10,
      ),
    );
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      searchResults = [];
    } else {
      final lowerQuery = query.toLowerCase();

      final startMatches = _allEvents.where((e) {
        return e.title.toLowerCase().startsWith(lowerQuery) ||
            (e.category ?? '').toLowerCase().startsWith(lowerQuery) ||
            e.location.toLowerCase().startsWith(lowerQuery);
      }).toList();

      final containsMatches = _allEvents.where((e) {
        return (e.title.toLowerCase().contains(lowerQuery) ||
                (e.category ?? '').toLowerCase().contains(lowerQuery) ||
                e.location.toLowerCase().contains(lowerQuery)) &&
            !(e.title.toLowerCase().startsWith(lowerQuery) ||
                (e.category ?? '').toLowerCase().startsWith(lowerQuery) ||
                e.location.toLowerCase().startsWith(lowerQuery));
      }).toList();

      searchResults = [
        ...startMatches,
        ...containsMatches,
      ];
    }

    notifyListeners();
  }

  void selectEvent(EventModel event) {
    selectedEvent = event;

    final destination = LatLng(
      event.latitude ?? 0.0,
      event.longitude ?? 0.0,
    );

    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(
        destination,
        14,
      ),
    );

    controller?.showMarkerInfoWindow(
      MarkerId(event.id.toString()),
    );

    if (currentLocation != null) {
      _drawRoute(
        currentLocation!,
        destination,
      );
    }

    searchResults = [];

    notifyListeners();
  }

  void _drawRoute(
    LatLng start,
    LatLng end,
  ) {
    polylines.clear();

    polylines.add(
      Polyline(
        polylineId: const PolylineId(
          "path_to_event",
        ),
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

  void moveToLocation(
    LatLng position,
  ) {
    selectedEvent = null;

    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(
        position,
        15,
      ),
    );

    polylines.clear();

    notifyListeners();
  }

  void disposeMap() {
    controller?.dispose();

    polylines.clear();
    markers.clear();
    searchResults.clear();
  }
}
