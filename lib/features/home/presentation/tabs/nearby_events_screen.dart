import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class NearbyEventsScreen extends StatelessWidget {
  final List<EventModel> allEvents;
  final String title;

  const NearbyEventsScreen({
    super.key,
    required this.allEvents,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allEvents.length,
        itemBuilder: (context, index) {
          return NearbyEventCard(event: allEvents[index]);
        },
      ),
    );
  }
}
