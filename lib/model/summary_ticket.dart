import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/booking_ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class SummaryTicket extends TicketEntry {
  final Event _journal;
  final Ticket _ticket;

  SummaryTicket(this._journal, this._ticket);

  void _doForOurTickets(Function callback) {
    for (Booking booking in _journal.entries) {
      for (BookingTicket bookingTicket in booking.entries) {
        if (bookingTicket.ticket ==_ticket) {
          callback(bookingTicket);
          break;
        }
      }
    }
  }

  Ticket get ticket => _ticket;

  int get count {
    int sum = 0;
    _doForOurTickets((BookingTicket bookingTicket) { sum += bookingTicket.count; });
    return sum;
  }

  int get price {
    int sum = 0;
    _doForOurTickets((BookingTicket bookingTicket) { sum += bookingTicket.price; });
    return sum;
  }

  static SummaryTicket of(BuildContext context) =>
      ScopedModel.of<SummaryTicket>(context);     
}
