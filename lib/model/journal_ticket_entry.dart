import 'package:dw_ticket_pos/model/journal_event_entry.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class JournalTicketEntry extends TicketEntry {
  final JournalEventEntry _eventEntry;
  final Ticket _ticket;
  int _count = 0;

  JournalTicketEntry(this._eventEntry, this._ticket);

  int get count => _count;
  int get price => count * _ticket.price;

  Ticket get ticket => _ticket;

  void _changed() {
    notifyListeners();
    _eventEntry.notifyListeners();
  }

  void updateCount(int amount) {
    _count += amount;
    if (count < 0) {
      _count = 0;
    }
    _changed();
  }

  void resetCount() {
    _count = 0;
    _changed();
  }
}