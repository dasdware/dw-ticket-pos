import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ticket.dart';
import 'event_journal_entry.dart';

class TicketJournalEntry extends Model {
  final EventJournalEntry eventEntry;
  final Ticket ticket;
  int count = 0;

  TicketJournalEntry(this.eventEntry, this.ticket);

  int get price {
    return count * ticket.price;
  }

  void _changed() {
    notifyListeners();
    eventEntry.notifyListeners();
  }

  void updateCount(int amount) {
    count += amount;
    if (count < 0) {
      count = 0;
    }
    _changed();
  }

  void resetCount() {
    count = 0;
    _changed();
  }

  static TicketJournalEntry of(BuildContext context) =>
      ScopedModel.of<TicketJournalEntry>(context);  
}