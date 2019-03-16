import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'event_journal.dart';
import 'ticket_journal_entry.dart';

class EventJournalEntry extends Model {
  final EventJournal journal;
  List<TicketJournalEntry> _ticketEntries;
  DateTime timestamp;

  EventJournalEntry(this.journal) {
    _ticketEntries = journal.availableTickets
        .map((ticket) => TicketJournalEntry(this, ticket))
        .toList();
  }

  List<TicketJournalEntry> get ticketEntries => _ticketEntries;

  int get price {
    return ticketEntries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.price);
  }

  void commit() {
    timestamp = DateTime.now();
    journal.commit(this);
  }

  static EventJournalEntry of(BuildContext context) =>
      ScopedModel.of<EventJournalEntry>(context);
}
