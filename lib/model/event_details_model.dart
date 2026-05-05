import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/speaker_model.dart';
import 'package:event_hub/model/sponsor_model.dart';

class EventDetailsModel {
  final EventModel event;
  final List<Speaker> speakers;
  final List<Sponsor> sponsors;

  EventDetailsModel({
    required this.event,
    required this.speakers,
    required this.sponsors,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return EventDetailsModel(
      event: EventModel.fromJson(data['event']),
      speakers: (data['speakers'] as List? ?? [])
          .map((e) => Speaker.fromJson(e))
          .toList(),
      sponsors: (data['sponsors'] as List? ?? [])
          .map((e) => Sponsor.fromJson(e))
          .toList(),
    );
  }
}
