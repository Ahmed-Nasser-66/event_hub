class Event11 {
  final String id;
  final String title;
  final String description;
  final String city;

  final double latitude;
  final double longitude;

  final String? imageUrl;

  const Event11({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
  });

  static List<Event11> egyptEvents11 = [
    const Event11(
      id: '1',
      title: 'Cairo Tech Summit',
      description: 'Annual technology conference with startups and developers.',
      city: 'Cairo',
      latitude: 30.0444,
      longitude: 31.2357,
      imageUrl: 'https://images.unsplash.com/photo-1551836022-deb4988cc6c0',
    ),

    const Event11(
      id: '2',
      title: 'Alexandria Music Festival',
      description: 'Live music festival on the Mediterranean coast.',
      city: 'Alexandria',
      latitude: 31.2001,
      longitude: 29.9187,
      imageUrl: 'https://images.unsplash.com/photo-1506157786151-b8491531f063',
    ),

    const Event11(
      id: '3',
      title: 'Giza Pyramids Marathon',
      description: 'International marathon around the pyramids.',
      city: 'Giza',
      latitude: 29.9792,
      longitude: 31.1342,
      imageUrl: 'https://images.unsplash.com/photo-1544986581-efac024faf62',
    ),

    const Event11(
      id: '4',
      title: 'Luxor Cultural Festival',
      description: 'Cultural and heritage celebration in Luxor temples.',
      city: 'Luxor',
      latitude: 25.6872,
      longitude: 32.6396,
      imageUrl: 'https://images.unsplash.com/photo-1568322445389-f64ac2515020',
    ),

    const Event11(
      id: '5',
      title: 'Hurghada Diving Event',
      description: 'Professional diving event in the Red Sea.',
      city: 'Hurghada',
      latitude: 27.2579,
      longitude: 33.8116,
      imageUrl: 'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
    ),

    const Event11(
      id: '6',
      title: 'Aswan Nile Festival',
      description: 'Festival celebrating Nile culture and traditions.',
      city: 'Aswan',
      latitude: 24.0889,
      longitude: 32.8998,
      imageUrl: 'https://images.unsplash.com/photo-1526772662000-3f88f10405ff',
    ),

    const Event11(
      id: '7',
      title: 'Mansoura Book Fair',
      description: 'Book fair with local and international publishers.',
      city: 'Mansoura',
      latitude: 31.0409,
      longitude: 31.3785,
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    ),

    const Event11(
      id: '8',
      title: 'Sharm El Sheikh Tourism Conference',
      description: 'Tourism and hospitality industry conference.',
      city: 'Sharm El Sheikh',
      latitude: 27.9158,
      longitude: 34.3299,
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    ),
  ];
}
