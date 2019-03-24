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
    textController.text = model.count.toString();

    return TextField(
      controller: textController,
      keyboardType: TextInputType.numberWithOptions(),
      textAlign: TextAlign.center,
      onChanged: (String value) {
        if (model is BookingTicket) {
          model.setCount(int.parse(value));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      alignment: Alignment.center,
      child: ScopedModelDescendant<TicketEntry>(
          builder: (context, _, model) => (readonly)
              ? textLabel(model, context)
              : textField(model, context)),
    );
  }
}
