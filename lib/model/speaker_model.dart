class Speaker {
  final int id;
  final String name;
  final String? profilePicture;

  final String? sessionTitle;

  final String? summary;

  Speaker({
    required this.id,
    required this.name,
    this.profilePicture,
    this.sessionTitle,
    this.summary,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'],
      name: json['name'] ?? '',
      profilePicture: json['profile_picture'],
      sessionTitle: json['session_title'],
      summary: json['summary'],
    );
  }
}
