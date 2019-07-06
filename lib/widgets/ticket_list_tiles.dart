import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_count.dart';
import 'package:dw_ticket_pos/widgets/ticket_entry_price.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TicketListTile extends StatelessWidget {
  final Ticket ticket;
  final Widget leading;
  final Widget trailing;

  const TicketListTile({Key key, this.ticket, this.leading, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket.title),
      subtitle: Text(formatTicketPrice(context, ticket)),
      leading: leading,
      trailing: trailing,
    );
  }
}

class TicketListSummaryTile extends StatelessWidget {
  final TicketEntry entry;

  const TicketListSummaryTile({Key key, this.entry}) : super(key: key);

  List<Widget> _buildTrailingWidgets() {
    return [
      TicketEntryCountWidget(readonly: true),
      TicketEntryPriceWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TicketEntry>(
      model: entry,
      child: TicketListTile(
        ticket: entry.ticket,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildTrailingWidgets(),
        ),
      ),
    );
  }
}
