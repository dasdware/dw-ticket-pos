import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ticket.dart';
import 'event_journal_entry.dart';

class EventJournal extends Model {
  final String name;
  final DateTime dateTime;
  final List<Ticket> availableTickets;
  final List<EventJournalEntry> entries = [];

  EventJournal(this.name, this.dateTime, this.availableTickets);

  EventJournalEntry addEntry() {
    return EventJournalEntry(this);
  }

  void commit(EventJournalEntry entry) {
    assert(entry.journal == this);
    entries.add(entry);
    notifyListeners();
  }

  static EventJournal of(BuildContext context) =>
      ScopedModel.of<EventJournal>(context);   
}