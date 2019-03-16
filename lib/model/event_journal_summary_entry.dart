
import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/model/event_journal_entry.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/model/ticket_journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EventJournalSummaryEntry extends Model {
  final EventJournal _journal;
  final Ticket _ticket;

  EventJournalSummaryEntry(this._journal, this._ticket);

  void _doForOurTickets(Function callback) {
    for (EventJournalEntry journalEntry in _journal.entries) {
      for (TicketJournalEntry ticketEntry in journalEntry.ticketEntries) {
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
    _doForOurTickets((TicketJournalEntry entry) { sum += entry.count; });
    return sum;
  }

  int get price {
    int sum = 0;
    _doForOurTickets((TicketJournalEntry entry) { sum += entry.price; });
    return sum;
  }

  static EventJournalSummaryEntry of(BuildContext context) =>
      ScopedModel.of<EventJournalSummaryEntry>(context);     
}