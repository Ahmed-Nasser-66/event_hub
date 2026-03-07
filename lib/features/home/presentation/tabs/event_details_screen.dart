import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      event.imagepath,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 25,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor:AppColors.white,
                        child: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: event.isFavorite ? Colors.red : AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          event.category.toLowerCase(),
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        event.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.black,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            event.location,
                            style: TextStyle(color: AppColors.black),
                          ),
                          Spacer(),
                          Icon(
                            Icons.access_time,
                            color: AppColors.black,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            event.datetime,
                            style: TextStyle(color: AppColors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Text(
                        locale.aboutEvent,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        locale.eventDetailsDescription,
                        style: TextStyle(color: AppColors.black, height: 1.5),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
