class EventModel {
  final String title;
  final String location;
  final double price;
  final String time;
  final String category;
  final String id;
  final String description;
  final double latitude;
  final double longitude;
  final DateTime date;
  bool isFavorite;
  final String image;
  double? distance;
  EventModel({
    required this.title,
    required this.location,
    required this.price,
    required this.category,
    this.isFavorite = false,
    required this.time,
    required this.id,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.image,
    this.distance,
  });
}
