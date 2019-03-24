import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/model/booking_ticket.dart';

class Booking extends TicketEntries {
  final Event _event;
  List<BookingTicket> _entries;
  DateTime _timestamp;

  Booking(this._event) {
    _entries = _event.availableTickets
        .map((ticket) => BookingTicket(this, ticket))
        .toList();
  }

  int get count {
    return entries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.count);
  }

  int get price {
    return entries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.price);
  }

  int get virtualPrice {
    return entries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.virtualPrice);
  }

  List<BookingTicket> get entries => _entries;

  DateTime get timestamp => _timestamp;

  void commit() {
    _timestamp = DateTime.now();
    _event.commit(this);
  }
}
