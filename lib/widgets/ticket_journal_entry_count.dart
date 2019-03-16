import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_journal_entry.dart';

class TicketEntryCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      alignment: Alignment.center,
      child: ScopedModelDescendant<TicketJournalEntry>(
        builder: (context, _, model) => Text(
              model.count.toString(),
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
      ),
    );
  }
}