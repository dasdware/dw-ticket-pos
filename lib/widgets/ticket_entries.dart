import 'package:dw_ticket_pos/widgets/ticket_entry_edit.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/ticket_entries.dart';

class TicketEntriesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: TicketEntries.of(context)
            .entries
            .map((ticketEntry) => TicketEntryEditListTile(ticketEntry))
            .toList(),
      ),
    );
  }
}
