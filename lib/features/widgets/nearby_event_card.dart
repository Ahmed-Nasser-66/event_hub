import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/tabs/event_details_screen.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class NearbyEventCard extends StatelessWidget {
  final EventModel event;

  const NearbyEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.read<FavoriteProvider>();
    final userProvider = context.read<UserProvider>();
    final eventProvider = context.read<EventProvider>();
    final bool isFavorite = context.watch<FavoriteProvider>().isExist(event);

    // 🔥 Format time
    String formatTime(String? time) {
      if (time == null) return '';
      try {
        final parsed = DateTime.parse(time);
        return DateFormat('hh:mm a').format(parsed);
      } catch (_) {
        return '';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    event.imageUrl ?? '',
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: GestureDetector(
                    onTap: () {
                      favoriteProvider.toggleFavorite(
                        event,
                        userProvider.email,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColors.red : AppColors.secondary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // 🔥 INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      eventProvider.categoryName(event.categoryId), // ✅ FIX
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Title
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd MMM, yyyy')
                            .format(event.date ?? DateTime.now()),
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // 🔥 Time Range
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${formatTime(event.startTime)} - ${formatTime(event.endTime)}",
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // 🔥 Event Type
                  Text(
                    event.type == 'online' ? 'Online' : 'In Person',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 🔥 Price
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      event.priceType == 'free'
                          ? 'FREE'
                          : "${(event.price ?? 0).toStringAsFixed(0)} EGP",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
