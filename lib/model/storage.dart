import 'dart:convert';
import 'dart:io';

import 'package:dw_ticket_pos/model/mock_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/json/storage.dart';
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

  Ticket addTicket(String title, int price, int virtualPrice) {
    final Ticket ticket = Ticket(title, price, virtualPrice);
    tickets.add(ticket);
    notifyListeners();
    return ticket;
  }

  void deleteTicket(Ticket ticket) {
    tickets.remove(ticket);
    notifyListeners();
  }

  void save() async {
    final json = JSONStorage.fromStorage(this);
    final jsonString = jsonEncode(json);
    print(jsonString);

    File output = await _getStorageFile();
    print(output.path);
    await output.writeAsString(jsonString);
  }

  static Future<File> _getStorageFile() async {
    final path = await getApplicationDocumentsDirectory();
    return File('${path.path}/storage.json');
  }

  static Future<Storage> load() async {
    final File input = await _getStorageFile();
    if (await input.exists()) {
      final jsonString = await input.readAsString();
      return JSONStorage.fromJson(jsonDecode(jsonString)).toStorage();
    } else {
      return MockStorage();
    }
  }

  static Storage of(BuildContext context) => ScopedModel.of<Storage>(context);
}
