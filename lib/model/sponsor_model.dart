class Sponsor {
  final int id;
  final String? name;
  final String? logo;

  Sponsor({
    required this.id,
    this.name,
    this.logo,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
