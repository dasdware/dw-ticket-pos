import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/event_journal_entry.dart';
import 'package:dw_ticket_pos/widgets/ticket_journal_entry.dart';

class TicketJournalEntriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: EventJournalEntry.of(context)
          .ticketEntries
          .map((ticketEntry) => TicketJournalEntryWidget(ticketEntry))
          .toList(),
    );
  }
}