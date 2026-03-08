import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class NearbyEventsScreen extends StatelessWidget {
  final List<EventModel> allEvents; 

  const NearbyEventsScreen({super.key, required this.allEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Events"), centerTitle: true),
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
