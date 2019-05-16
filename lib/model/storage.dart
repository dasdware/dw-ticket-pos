import 'dart:convert';
import 'dart:io';

import 'package:dw_ticket_pos/backends/storage_backend.dart';
import 'package:dw_ticket_pos/model/mock_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/json/storage.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class Storage extends Model {
  final StorageBackend backend;

  List<Ticket> tickets = [];
  List<Event> events = [];

  Storage(this.backend);

  Event createEvent(String name, DateTime dateTime, List<Ticket> tickets) {
    Event event = Event(this, name, dateTime);
    event.availableTickets =
        tickets.map((ticket) => ticket.cloneWithEvent(event)).toList();
    events.add(event);
    notifyListeners();
    backend.eventAdded(event);
    return event;
  }

  void deleteEvent(Event event) {
    events.remove(event);
    notifyListeners();
    backend.eventRemoved(event);
  }

  Ticket addTicket(String title, int price, int virtualPrice) {
    final Ticket ticket = Ticket(this, title, price, virtualPrice);
    tickets.add(ticket);
    notifyListeners();
    backend.ticketAdded(ticket);
    return ticket;
  }

  void deleteTicket(Ticket ticket) {
    tickets.remove(ticket);
    notifyListeners();
    backend.ticketRemoved(ticket);
  }

  static Storage of(BuildContext context) => ScopedModel.of<Storage>(context);
}
