import 'package:dw_ticket_pos/widgets/ticket_entry_count_edit.dart';
import 'package:dw_ticket_pos/widgets/ticket_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_button.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_price.dart';

class TicketEntryEditListTile extends StatelessWidget {
  final TicketEntry _entry;

  const TicketEntryEditListTile(this._entry, {Key key})
      : super(key: key);

  List<Widget> _buildTrailingWidgets() {
    return [
      TicketEntryButtonWidget(kind: TicketEntryButtonKind.reset),
      TicketEntryButtonWidget(kind: TicketEntryButtonKind.decrement),
      SizedBox(width: 4.0),
      TicketEntryCountEdit(),
      SizedBox(width: 4.0),
      TicketEntryButtonWidget(kind: TicketEntryButtonKind.increment),
      TicketEntryPriceWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TicketEntry>(
      model: this._entry,
      child: TicketListTile(
        ticket: _entry.ticket,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _buildTrailingWidgets(),
        ),
      ),
    );
  }
}
