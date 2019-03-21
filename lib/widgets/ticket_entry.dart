import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_button.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_count.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_price.dart';
import 'package:dw_ticket_pos/utils/format.dart';

class TicketEntryWidget extends StatelessWidget {
  final TicketEntry _entry;
  final bool readonly;

  const TicketEntryWidget(this._entry, {Key key, this.readonly = false})
      : super(key: key);

  String get priceLabel {
    String label = formatPrice(_entry.ticket.price);
    if (_entry.ticket.realPrice > -1)
      label = label + ' (' + formatPrice(_entry.ticket.realPrice) + ')';
    return label;
  }

  List<Widget> _buildTrailingWidgets() {
    List<Widget> widgets = [];
    if (!readonly) {
      widgets
        ..add(TicketEntryButtonWidget(amount: -5))
        ..add(TicketEntryButtonWidget(amount: -1));
    }
    widgets.add(TicketEntryCountWidget());
    if (!readonly) {
      widgets
        ..add(TicketEntryButtonWidget(amount: 1))
        ..add(TicketEntryButtonWidget(amount: 5));
    }
    widgets.add(TicketEntryPriceWidget());
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TicketEntry>(
      model: this._entry,
      child: ListTile(
        title: Text(_entry.ticket.title),
        subtitle: Text(priceLabel),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _buildTrailingWidgets(),
        ),
      ),
    );
  }
}