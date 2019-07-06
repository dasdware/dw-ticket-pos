import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/utils/format.dart';

class BookingsListWidget extends StatelessWidget {
  const BookingsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Event>(
      builder: (context, _, model) => ListView(
            children: model.entries.reversed.map((entry) {
              List<Widget> prices = [];
              prices.add(Text(formatPrice(context, entry.price),
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)));
              if (entry.hasVirtualPrice) {
                prices.add(Text(
                  '(${formatPrice(context, entry.virtualPrice)})',
                  style: TextStyle(fontSize: 14.0),
                ));
              }
              return ListTile(
                title: Text(formatDateTime(context, entry.timestamp)),
                subtitle: Text(formatTicketEntries(context, entry)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(children: prices),
                    DeleteBookingButton(booking: entry),
                  ],
                ),
              );
            }).toList(),
          ),
    );
  }
}

class DeleteBookingButton extends StatelessWidget {
  final Booking booking;

  const DeleteBookingButton({Key key, this.booking}) : super(key: key);

  void askDeleteBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).deleteBooking),
          content: Text(AppLocalizations.of(context).deleteBookingMessage),
          actions: [
            FlatButton(
              child: Text(AppLocalizations.of(context).dialogYes),
              onPressed: () {
                booking.delete();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).dialogNo),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      viewModel: ActionViewModel(
        icon: Icons.delete,
        hint: AppLocalizations.of(context).deleteBookingHint,
        onPressed: () => askDeleteBooking(context),  
      ),
    );
  }
}
