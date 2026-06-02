import 'dart:async';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/location/location_screen.dart';
import 'package:event_hub/features/home/presentation/notification/notification_screen.dart';
import 'package:event_hub/features/home/presentation/tabs/nearby_events_screen.dart';
import 'package:event_hub/features/widgets/category.dart';
import 'package:event_hub/features/widgets/event_skeleton.dart';
import 'package:event_hub/features/widgets/filter_button.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/features/widgets/upcoming_event_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:event_hub/providers/map_provider.dart';
import 'package:event_hub/providers/notification_provider.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debouncer;

  bool _isLocationInitialized = false;

  @override
  void initState() {
    super.initState();

    _initializeLocationOnce();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final eventProvider = context.read<EventProvider>();
      final favoriteProvider = context.read<FavoriteProvider>();
      final userEmail = context.read<UserProvider>().email;

      if (eventProvider.allEvents.isEmpty) {
        eventProvider.refreshEvents(
          favoriteProvider: favoriteProvider,
          userEmail: userEmail,
        );
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      context.read<EventProvider>().setSearchQuery(value);
    });
  }

  void goToAllEvents(List<EventModel> events, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NearbyEventsScreen(allEvents: events, title: title),
      ),
    );
  }

  void _initializeLocationOnce() {
    if (_isLocationInitialized) return;

    _isLocationInitialized = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final mapProvider = context.read<MapProvider>();
      final eventProvider = context.read<EventProvider>();

      mapProvider.initializeMap();

      if (!mounted) return;

      final location = mapProvider.currentLocation;

      if (location != null) {
        eventProvider.setUserLocation(
          location.latitude,
          location.longitude,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>();
    final eventProvider = context.watch<EventProvider>();
    final mapProvider = context.watch<MapProvider>();
    final notificationProvider = context.watch<NotificationProvider>();
    final upcomingEvents =
        eventProvider.filteredUpcomingEvents.take(5).toList();

    final nearbyEvents = eventProvider.filteredNearbyEvents.take(5).toList();

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final favoriteProvider = context.read<FavoriteProvider>();
            final userEmail = context.read<UserProvider>().email;

            await eventProvider.refreshEvents(
              favoriteProvider: favoriteProvider,
              userEmail: userEmail,
            );
            await mapProvider.refreshLocation();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationScreen(),
                                  ),
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/icon/location.svg',
                                width: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${locale.helloHome} ${user.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.grey,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen(),
                              ),
                            );
                          },
                          icon: Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/icon/bell.svg',
                                width: 20,
                              ),
                              if (notificationProvider.hasUnreadNotifications)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Searchbarwidget(
                          controller: searchController,
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Filterbutton(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Category(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.upcomingEvents,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => goToAllEvents(
                          eventProvider.filteredUpcomingEvents,
                          locale.upcomingEvents,
                        ),
                        child: Text(
                          locale.seeAll,
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 330,
                    child: eventProvider.isLoading
                        ? const EventSkeleton(isHorizontal: true)
                        : upcomingEvents.isEmpty
                            ? const Center(child: Text("No Events Found"))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: upcomingEvents.length,
                                itemBuilder: (context, index) {
                                  return UpcomingEventCard(
                                    event: upcomingEvents[index],
                                  );
                                },
                              ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.nearbyEvents,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => goToAllEvents(
                          eventProvider.filteredNearbyEvents,
                          locale.nearbyEvents,
                        ),
                        child: Text(
                          locale.seeAll,
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (mapProvider.currentLocation == null ||
                      eventProvider.isLoading)
                    const EventSkeleton(isHorizontal: false)
                  else if (nearbyEvents.isEmpty)
                    const Center(child: Text("No nearby events"))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nearbyEvents.length,
                      itemBuilder: (context, index) {
                        return NearbyEventCard(
                          event: nearbyEvents[index],
                        );
                      },
                    ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
