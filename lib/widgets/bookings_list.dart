import 'package:dw_ticket_pos/model/booking.dart';
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
              prices.add(Text(formatPrice(entry.price),
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)));
              if (entry.hasVirtualPrice) {
                prices.add(Text(
                  '(${formatPrice(entry.virtualPrice)})',
                  style: TextStyle(fontSize: 14.0),
                ));
              }
              return ListTile(
                title: Text(formatDateTime(entry.timestamp)),
                subtitle: Text(formatTicketEntries(entry)),
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
          title: Text('Buchung löschen'),
          content: Text(
              'Sind Sie sicher, dass die gewählte Buchung gelöscht werden soll?'),
          actions: [
            FlatButton(
              child: Text('JA'),
              onPressed: () {
                booking.delete();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('NEIN'),
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
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => askDeleteBooking(context),
    );
  }
}
