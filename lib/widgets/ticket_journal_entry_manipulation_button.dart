import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/ticket_journal_entry.dart';

class TicketEntryManipulationButtonWidget extends StatelessWidget {
  final int amount;

  const TicketEntryManipulationButtonWidget({Key key, this.amount})
      : super(key: key);

  String get caption {
    if (amount > 0)
      return '+' + amount.toString();
    else
      return amount.toString();
  }

  Color get color {
    if (amount > 0)
      return Colors.greenAccent;
    else if (amount < 0)
      return Colors.redAccent;
    else
      return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final TicketJournalEntry entry = TicketJournalEntry.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 1, right: 1),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              this.caption,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          onTap: () {
            entry.updateCount(amount);
          },
        ),
      ),
    );
  }
}
