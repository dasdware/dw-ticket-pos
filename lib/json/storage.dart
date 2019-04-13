import 'package:dw_ticket_pos/json/event.dart';
import 'package:dw_ticket_pos/json/ticket.dart';
import 'package:dw_ticket_pos/model/storage.dart';

class JSONStorage {
  List<JSONTicket> tickets;
  List<JSONEvent> events;

  JSONStorage({this.tickets, this.events});

  JSONStorage.fromStorage(Storage storage) :
    tickets = storage.tickets.map((ticket) => JSONTicket.fromTicket(ticket)).toList(),
    events = storage.events.map((event) => JSONEvent.fromEvent(event)).toList();

  JSONStorage.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      tickets = new List<JSONTicket>();
      json['tickets'].forEach((v) {
        tickets.add(new JSONTicket.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = new List<JSONEvent>();
      json['events'].forEach((v) {
        events.add(new JSONEvent.fromJson(v));
      });
    }
  }

  Storage toStorage() {
    Storage storage = Storage();
    for (JSONTicket ticket in tickets) {
      storage.tickets.add(ticket.toTicket());
    }
    for (JSONEvent event in events) {
      storage.events.add(event.toEvent());
    }
    return storage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tickets != null) {
      data['tickets'] = this.tickets.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
