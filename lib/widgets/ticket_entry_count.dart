import 'package:dw_ticket_pos/model/booking_ticket.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entry.dart';

class TicketEntryCountWidget extends StatelessWidget {
  final bool readonly;

  const TicketEntryCountWidget({Key key, this.readonly}) : super(key: key);

  Widget textLabel(TicketEntry model, BuildContext context) {
    return Text(
      model.count.toString(),
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }

  Widget textField(TicketEntry model, BuildContext context) {
    final TextEditingController textController = TextEditingController();
    if (model.count > 0) {
      textController.text = model.count.toString();
    } else {
      textController.text = '';
    }

    return TextField(
      controller: textController,
      keyboardType: TextInputType.numberWithOptions(),
      textAlign: TextAlign.center,
      decoration: InputDecoration(hintText: '0'),
      onSubmitted: (String value) {
        if (model is BookingTicket) {
          if (value != '') {
            model.setCount(int.parse(value));
          } else {
            model.setCount(0);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      alignment: Alignment.center,
      child: ScopedModelDescendant<TicketEntry>(
          builder: (context, _, model) => (readonly)
              ? textLabel(model, context)
              : textField(model, context)),
    );
  }
}
