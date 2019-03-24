import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry.dart';

class TicketEntriesWidget extends StatelessWidget {
  final bool readonly;

  const TicketEntriesWidget({Key key, this.readonly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: TicketEntries.of(context)
            .entries
            .map((ticketEntry) => TicketEntryWidget(
                  ticketEntry,
                  readonly: readonly,
                ))
            .toList(),
      ),
    );
  }
}
