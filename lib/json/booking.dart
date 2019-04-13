import 'package:dw_ticket_pos/model/booking.dart';

class JSONBooking {
  String timestamp;
  List<int> counts;

  JSONBooking({this.timestamp, this.counts});

  JSONBooking.fromBooking(Booking booking) :
    timestamp = booking.timestamp.toIso8601String(),
    counts = booking.entries.map((entry) => entry.count).toList();

  JSONBooking.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    counts = json['counts'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['counts'] = this.counts;
    return data;
  }
}