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

  List<Widget> _buildTrailingWidgets() {
    List<Widget> widgets = [];
    if (!readonly) {
      widgets
        ..add(TicketEntryButtonWidget(kind: TicketEntryButtonKind.reset))
        ..add(TicketEntryButtonWidget(kind: TicketEntryButtonKind.decrement));
    }
    widgets.add(SizedBox(width: 4.0,));
    widgets.add(TicketEntryCountWidget(readonly: readonly,));
    widgets.add(SizedBox(width: 4.0,));
    if (!readonly) {
      widgets
          .add(TicketEntryButtonWidget(kind: TicketEntryButtonKind.increment));
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
        subtitle: Text(formatTicketPrice(_entry.ticket)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _buildTrailingWidgets(),
        ),
      ),
    );
  }
}
