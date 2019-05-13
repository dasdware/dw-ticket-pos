import 'package:dw_ticket_pos/json/booking.dart';
import 'package:dw_ticket_pos/json/ticket.dart';
import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';

class JSONEvent {
  String name;
  String timestamp;
  List<JSONTicket> tickets;
  List<JSONBooking> bookings;

  JSONEvent({this.name, this.timestamp, this.tickets, this.bookings});

  Event toEvent(Storage storage) {
    Event eventResult = Event(storage, name, DateTime.tryParse(timestamp));
    eventResult.availableTickets = this
        .tickets
        .map((ticket) => ticket.toEventTicket(eventResult))
        .toList();

    for (var booking in bookings) {
      Booking bookingResult = eventResult.addBooking();

      for (int i = 0; i < bookingResult.entries.length; ++i) {
        bookingResult.entries[i].updateCount(booking.counts[i]);
      }

      bookingResult.commit(timestamp: DateTime.tryParse(booking.timestamp));
    }

    return eventResult;
  }

  JSONEvent.fromEvent(Event event)
      : name = event.name,
        timestamp = event.dateTime.toIso8601String(),
        tickets = event.availableTickets
            .map((ticket) => JSONTicket.fromTicket(ticket))
            .toList(),
        bookings = event.entries
            .map((booking) => JSONBooking.fromBooking(booking))
            .toList();

  JSONEvent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timestamp = json['timestamp'];
    if (json['tickets'] != null) {
      tickets = new List<JSONTicket>();
      json['tickets'].forEach((v) {
        tickets.add(new JSONTicket.fromJson(v));
      });
    }
    if (json['bookings'] != null) {
      bookings = new List<JSONBooking>();
      json['bookings'].forEach((v) {
        bookings.add(new JSONBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timestamp'] = this.timestamp;
    if (this.tickets != null) {
      data['tickets'] = this.tickets.map((v) => v.toJson()).toList();
    }
    if (this.bookings != null) {
      data['bookings'] = this.bookings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
