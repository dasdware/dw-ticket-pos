import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/utils/format.dart';

class TicketEntriesPriceWidget extends StatelessWidget {
  const TicketEntriesPriceWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child:
            ScopedModelDescendant<TicketEntries>(builder: (context, _, model) {
          List<Widget> prices = [];
          prices.add(Text(
            formatPrice(model.price),
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ));
          if (model.hasVirtualPrice) {
            prices.add(Text(
              '(${formatPrice(model.virtualPrice)})',
              style: TextStyle(fontSize: 18.0),
            ));
          }
          return Column(children: prices);
        }),
      ),
    );
  }
}
