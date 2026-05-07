class EventModel {
  final int id;
  final String title;
  final String description;

  final String? category;
  final int? categoryId;

  final int capacity;

  final String location;
  final String type;

  final String? startTime;
  final String? endTime;

  final String? venueName;
  final String? address;

  final String? priceType;

  final double? price;

  final double? latitude;
  final double? longitude;

  final DateTime? date;

  final String? imageUrl;

  double? distance;

  bool isFavorite;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.category,
    this.categoryId,
    required this.capacity,
    required this.location,
    required this.type,
    this.startTime,
    this.endTime,
    this.venueName,
    this.address,
    this.priceType,
    this.price,
    this.latitude,
    this.longitude,
    this.date,
    this.imageUrl,
    this.distance,
    this.isFavorite = false,
  });

  factory EventModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return EventModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                json['id'].toString(),
              ) ??
              0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] != null ? json['category']['name'] : null,
      categoryId: json['category_id'] ??
          (json['category'] != null ? json['category']['id'] : null),
      capacity: json['capacity'] is int
          ? json['capacity']
          : int.tryParse(
                json['capacity'].toString(),
              ) ??
              0,
      location: json['location'] ?? '',
      type: json['type'] ?? '',
      startTime: json['start_time'],
      endTime: json['end_time'],
      venueName: json['venue_name'],
      address: json['address'],
      priceType: json['price_type'],
      price: json['price'] != null
          ? double.tryParse(
              json['price'].toString(),
            )
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      date: json['start_time'] != null
          ? DateTime.tryParse(
              json['start_time'],
            )
          : null,
      imageUrl: json['image_url']?.toString(),
      distance: json['distance'] != null
          ? double.tryParse(
              json['distance'].toString(),
            )
          : null,
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'category_id': categoryId,
      'capacity': capacity,
      'location': location,
      'type': type,
      'start_time': startTime,
      'end_time': endTime,
      'venue_name': venueName,
      'address': address,
      'price_type': priceType,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'distance': distance,
      'is_favorite': isFavorite,
    };
  }

  EventModel copyWith({
    bool? isFavorite,
    double? distance,
  }) {
    return EventModel(
      id: id,
      title: title,
      description: description,
      category: category,
      categoryId: categoryId,
      capacity: capacity,
      location: location,
      type: type,
      startTime: startTime,
      endTime: endTime,
      venueName: venueName,
      address: address,
      priceType: priceType,
      price: price,
      latitude: latitude,
      longitude: longitude,
      date: date,
      imageUrl: imageUrl,
      distance: distance ?? this.distance,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
