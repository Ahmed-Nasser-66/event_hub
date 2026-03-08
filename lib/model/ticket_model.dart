class TicketModel {
  final String title;
  final String date;
  final String category;
  final bool isUpcoming;
  final String bookingId;
  final String location;
  final String image;
  final String section;
  final String row;
  final String time;
  final String price;
  int ticketsCount;

  TicketModel({
    required this.title,
    required this.date,
    required this.category,
    required this.isUpcoming,
    required this.bookingId,
    required this.location,
    required this.image,
    required this.section,
    required this.row,
    required this.time,
    required this.ticketsCount,
    required this.price,
  });
}
