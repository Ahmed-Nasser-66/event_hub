class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String? time;
  final String? image;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.time,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      time: json['created_at']?.toString(),
      image: json['image'] != null
          ? "https://eventhub.huma-volve.com${json['image']}"
          : null,
    );
  }
}
