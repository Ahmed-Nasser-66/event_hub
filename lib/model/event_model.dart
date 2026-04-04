class EventModel {
  final String title;
  final String location;
  final DateTime datetime; 
  final double price;
  final String imagepath;
  final String category;
  bool isFavorite;

  EventModel({
    required this.title,
    required this.location,
    required this.datetime,
    required this.price,
    required this.imagepath,
    required this.category,
    this.isFavorite = false,
  });
}
