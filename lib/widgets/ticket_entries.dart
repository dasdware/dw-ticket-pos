import 'package:dw_ticket_pos/model/event_entry.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry.dart';
import 'package:flutter/material.dart';

class TicketEntriesWidget extends StatelessWidget {
  final bool readonly;

  const TicketEntriesWidget({Key key, this.readonly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: EventEntry.of(context)
          .entries
          .map((ticketEntry) => TicketEntryWidget(
                ticketEntry,
                readonly: readonly,
              ))
          .toList(),
    );
  }
}
