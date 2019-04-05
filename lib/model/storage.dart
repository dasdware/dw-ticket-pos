import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class Storage extends Model {
  List<Ticket> tickets = [];
  List<Event> events = [];

  Event createEvent(String name, DateTime dateTime, List<Ticket> tickets) {
    Event event =
        Event(name, dateTime, tickets.map((ticket) => ticket.clone()).toList());
    events.add(event);
    notifyListeners();
    return event;
  }

  void deleteTicket(Ticket ticket) {
    tickets.remove(ticket);
    notifyListeners();
  }

  static Storage of(BuildContext context) => ScopedModel.of<Storage>(context);
}
