import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dw_ticket_pos/widgets/ticket_journal_entry_manipulation_button.dart';
import 'package:dw_ticket_pos/widgets/ticket_journal_entry_count.dart';
import 'package:dw_ticket_pos/widgets/ticket_journal_entry_price.dart';

import 'package:dw_ticket_pos/model/ticket_journal_entry.dart';
import 'package:dw_ticket_pos/utils/format.dart';

class TicketJournalEntryWidget extends StatelessWidget {
  final TicketJournalEntry _entry;

  const TicketJournalEntryWidget(this._entry, {Key key}) : super(key: key);

  String get priceLabel {
    String label = formatPrice(_entry.ticket.price);
    if (_entry.ticket.realPrice > -1)
      label = label + ' (' + formatPrice(_entry.ticket.realPrice) + ')';
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TicketJournalEntry>(
      model: this._entry,
      child: ListTile(
        title: Text(_entry.ticket.title),
        subtitle: Text(priceLabel),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TicketEntryManipulationButtonWidget(amount: -5),
            TicketEntryManipulationButtonWidget(amount: -1),
            TicketEntryCountWidget(),
            TicketEntryManipulationButtonWidget(amount: 1),
            TicketEntryManipulationButtonWidget(amount: 5),
            TicketEntryPriceWidget(),
          ],
        ),
      ),
    );
  }
}
