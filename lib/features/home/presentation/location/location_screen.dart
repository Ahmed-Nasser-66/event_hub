import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/tabs/event_booking_screen.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late TextEditingController _searchController;
  bool _isShowingBottomSheet = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();

    final mapProvider = context.read<MapProvider>();
    mapProvider.searchResults = [];
    mapProvider.selectedEvent = null;

    super.dispose();
  }

  void _showEventDetails(BuildContext context, EventModel event) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withAlpha(26),
              blurRadius: 20,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.cardGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${event.location} • ${event.category ?? ''}",
              style: const TextStyle(
                color: AppColors.lightGrey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.aboutEvent,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.lightGrey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventBookingScreen(event: event),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  l10n.bookNow,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        debugPrint(
          "Markers On Screen: ${mapProvider.markers.length}",
        );

        if (mapProvider.selectedEvent != null && !_isShowingBottomSheet) {
          _isShowingBottomSheet = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showEventDetails(
              context,
              mapProvider.selectedEvent!,
            );

            mapProvider.selectedEvent = null;
            _isShowingBottomSheet = false;
          });
        }

        if (mapProvider.currentLocation == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.orange,
              ),
            ),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              ClipRRect(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: mapProvider.currentLocation!,
                    zoom: 12,
                  ),
                  onMapCreated: (controller) {
                    mapProvider.controller = controller;

                    mapProvider.moveToFirstEventIfReady();
                  },
                  style: mapProvider.mapStyle,
                  markers: mapProvider.markers,
                  polylines: mapProvider.polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
              ),
              _buildSearchArea(
                context,
                mapProvider,
              ),
              _buildButtons(mapProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchArea(
    BuildContext context,
    MapProvider mapProvider,
  ) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Searchbarwidget(
            controller: _searchController,
            onChanged: (value) => mapProvider.searchEvents(value),
          ),
          if (mapProvider.searchResults.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withAlpha(26),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: mapProvider.searchResults.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: AppColors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final event = mapProvider.searchResults[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: AppColors.orange,
                      ),
                      title: Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      subtitle: Text(
                        event.category ?? '',
                        style: const TextStyle(
                          color: AppColors.lightGrey,
                        ),
                      ),
                      onTap: () {
                        mapProvider.selectEvent(event);

                        _searchController.clear();

                        FocusScope.of(context).unfocus();

                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            )
          else if (_searchController.text.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'No events found for "${_searchController.text}"',
                  style: const TextStyle(
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildButtons(MapProvider provider) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: FloatingActionButton(
        heroTag: 'my_location_fab',
        backgroundColor: AppColors.white,
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () {
          provider.moveToLocation(
            provider.currentLocation!,
          );

          _searchController.clear();
        },
        child: const Icon(
          Icons.my_location,
          color: AppColors.orange,
          size: 28,
        ),
      ),
    );
  }
}
