import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:dw_ticket_pos/utils/format.dart';

class TicketEntryPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        alignment: Alignment.centerRight,
        child: ScopedModelDescendant<TicketEntry>(builder: (context, _, model) {
          List<Widget> prices = [];
          prices.add(Text(
            formatPrice(model.price),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ));
          if (model.hasVirtualPrice) {
            prices.add(Text(
              '(${formatPrice(model.virtualPrice)})',
              style: TextStyle(fontSize: 13.0),
            ));
          }
          return Column(
            children: prices,
            mainAxisAlignment: MainAxisAlignment.center,
          );
        }));
  }
}
