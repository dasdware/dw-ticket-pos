import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/widgets/ticket_list_tiles.dart';
import 'package:flutter/material.dart';

class SummaryEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: TicketEntries.of(context)
            .entries
            .map((ticketEntry) => TicketListSummaryTile(
              entry: ticketEntry,
                ))
            .toList(),
      ),
    );
  }
}