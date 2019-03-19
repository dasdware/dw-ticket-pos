import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/journal_event_entry.dart';
import 'package:dw_ticket_pos/model/journal_ticket_entry.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class SummaryTicketEntry extends TicketEntry {
  final EventJournal _journal;
  final Ticket _ticket;

  SummaryTicketEntry(this._journal, this._ticket);

  void _doForOurTickets(Function callback) {
    for (JournalEventEntry journalEntry in _journal.entries) {
      for (JournalTicketEntry ticketEntry in journalEntry.entries) {
        if (ticketEntry.ticket ==_ticket) {
          callback(ticketEntry);
          break;
        }
      }
    }
  }

  Ticket get ticket => _ticket;

  int get count {
    int sum = 0;
    _doForOurTickets((JournalTicketEntry entry) { sum += entry.count; });
    return sum;
  }

  int get price {
    int sum = 0;
    _doForOurTickets((JournalTicketEntry entry) { sum += entry.price; });
    return sum;
  }

  static SummaryTicketEntry of(BuildContext context) =>
      ScopedModel.of<SummaryTicketEntry>(context);     
}