import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/summary.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class Event extends Model {
  final String name;
  final DateTime dateTime;
  final List<Ticket> availableTickets;
  final List<Booking> entries = [];
  Summary _summary;

  Event(this.name, this.dateTime, this.availableTickets) {
    _summary = Summary(this);
  }

  Summary get summary => _summary;

  Booking addBooking() {
    return Booking(this);
  }

  void commit(Booking entry) {
    entries.add(entry);
    notifyListeners();
  }

  static Event of(BuildContext context) =>
      ScopedModel.of<Event>(context);   
}
