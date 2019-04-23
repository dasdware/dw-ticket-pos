import 'package:dw_ticket_pos/widgets/summary_entries.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/widgets/ticket_entries_price.dart';

class BookingsSummaryWidget extends StatelessWidget {
  const BookingsSummaryWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Event>(
        builder: (context, _, model) => ScopedModel<TicketEntries>(
            model: model.summary,
            child: Column(
              children: <Widget>[
                TicketEntriesPriceWidget(),
                SummaryEntries(),
              ],
            )));
  }
}
