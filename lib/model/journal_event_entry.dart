import 'package:dw_ticket_pos/model/event_entry.dart';
import 'package:dw_ticket_pos/model/journal_ticket_entry.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'event_journal.dart';

class JournalEventEntry extends EventEntry {
  final EventJournal _journal;
  List<JournalTicketEntry> _ticketEntries;
  DateTime _timestamp;

  JournalEventEntry(this._journal) {
    _ticketEntries = _journal.availableTickets
        .map((ticket) => JournalTicketEntry(this, ticket))
        .toList();
  }

  int get count {
    return entries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.count);
  }

  int get price {
    return entries.fold(
        0, (int value, ticketEntry) => value + ticketEntry.price);
  }

  List<JournalTicketEntry> get entries => _ticketEntries;

  DateTime get timestamp => _timestamp;

  void commit() {
    _timestamp = DateTime.now();
    _journal.commit(this);
  }
}
