import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/utils/format.dart';

class TicketEntryPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        alignment: Alignment.centerRight,
        child: ScopedModelDescendant<TicketEntry>(
          builder: (context, _, model) => Text(
                formatPrice(model.price),
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
        ));
  }
}