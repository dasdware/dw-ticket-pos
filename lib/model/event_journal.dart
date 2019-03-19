import 'package:dw_ticket_pos/model/journal_event_entry.dart';
import 'package:dw_ticket_pos/model/summary.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EventJournal extends Model {
  final String name;
  final DateTime dateTime;
  final List<Ticket> availableTickets;
  final List<JournalEventEntry> entries = [];
  Summary _summary;

  EventJournal(this.name, this.dateTime, this.availableTickets) {
    _summary = Summary(this);
  }

  Summary get summary => _summary;

  JournalEventEntry addEntry() {
    return JournalEventEntry(this);
  }

  void commit(JournalEventEntry entry) {
    entries.add(entry);
    notifyListeners();
  }

  static EventJournal of(BuildContext context) =>
      ScopedModel.of<EventJournal>(context);   
}