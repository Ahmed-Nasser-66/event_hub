import 'dart:async';

import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/location/location_screen.dart';
import 'package:event_hub/features/home/presentation/notification/notification_screen.dart';
import 'package:event_hub/features/home/presentation/tabs/nearby_events_screen.dart';
import 'package:event_hub/features/widgets/category.dart';
import 'package:event_hub/features/widgets/filter_button.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/features/widgets/upcoming_event_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/map_provider.dart';
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

  // ✅ أضف هذا المتغير لمنع جلب الموقع أكثر من مرة
  bool _isLocationInitialized = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      debugPrint("Search text changed: ${searchController.text}");
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debugPrint("🔍 Searching for: '$value'");

    if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      debugPrint("✅ Executing search for: '$value'");
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

  // ✅ دالة جلب الموقع مرة واحدة فقط
  void _initializeLocationOnce() {
    if (_isLocationInitialized) return;

    final mapProvider = context.read<MapProvider>();
    final eventProvider = context.read<EventProvider>();

    _isLocationInitialized = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await mapProvider.initializeMap();
      if (mapProvider.currentLocation != null) {
        eventProvider.setUserLocation(
          mapProvider.currentLocation!.latitude,
          mapProvider.currentLocation!.longitude,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ استدعِ جلب الموقع مرة واحدة فقط
    _initializeLocationOnce();

    final locale = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>();
    final eventProvider = context.watch<EventProvider>();
    final mapProvider = context.watch<MapProvider>();

    // ✅ استخدام الدوال الجديدة
    final filteredEvents = eventProvider.filteredEvents; // للبحث
    final upcomingEvents =
        eventProvider.filteredUpcomingEvents; // ✅ أحداث قادمة + تصفية
    final nearbyEvents =
        eventProvider.filteredNearbyEvents; // ✅ أحداث قريبة + تصفية

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await eventProvider.refreshEvents();
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

                  /// 🔹 Header
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                          icon: SvgPicture.asset(
                            'assets/icon/bell.svg',
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🔍 Search
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

                  const SizedBox(height: 10),
                  const Category(),
                  const SizedBox(height: 15),

                  /// 🔵 عرض نتائج البحث إذا كان هناك بحث
                  if (searchController.text.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search Results',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                searchController.clear();
                                eventProvider.setSearchQuery('');
                              },
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        filteredEvents.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 50,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'No results found for "${searchController.text}"',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: filteredEvents.length,
                                  itemBuilder: (context, index) {
                                    return UpcomingEventCard(
                                      event: filteredEvents[index],
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 15),
                      ],
                    )
                  else ...[
                    /// 🔵 Upcoming Events (مع تصفية التصنيفات)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.upcomingEvents,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => goToAllEvents(
                              upcomingEvents, locale.upcomingEvents),
                          child: Text(
                            locale.seeAll,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.orange,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 320,
                      child: upcomingEvents.isEmpty
                          ? const Center(child: Text("No Events Found"))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: upcomingEvents.length > 5
                                  ? 5
                                  : upcomingEvents.length,
                              itemBuilder: (context, index) {
                                return UpcomingEventCard(
                                  event: upcomingEvents[index],
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 15),

                    /// 🟠 Nearby Events (مع تصفية التصنيفات)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.nearbyEvents,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              goToAllEvents(nearbyEvents, locale.nearbyEvents),
                          child: Text(
                            locale.seeAll,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.orange,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (mapProvider.currentLocation == null)
                      const Center(child: CircularProgressIndicator())
                    else if (nearbyEvents.isEmpty)
                      const Center(child: Text("No nearby events"))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            nearbyEvents.length > 5 ? 5 : nearbyEvents.length,
                        itemBuilder: (context, index) {
                          return NearbyEventCard(
                            event: nearbyEvents[index],
                          );
                        },
                      ),
                  ],
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
