import 'package:dw_ticket_pos/views/ticket_details.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

import 'package:dw_ticket_pos/utils/format.dart';

class TicketListWidget extends StatelessWidget {
  const TicketListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Storage>(
      builder: (context, _, storage) => ListView(
            children: storage.tickets
                .map(
                  (ticket) => ListTile(
                        title: Text(ticket.title),
                        subtitle: Text(formatTicketPrice(ticket)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            EditTicketButton(ticket: ticket),
                            DeleteTicketButton(storage: storage, ticket: ticket)
                          ],
                        ),
                        onTap: () {},
                      ),
                )
                .toList(),
          ),
    );
  }
}

class EditTicketButton extends StatelessWidget {
  final Ticket ticket;
  const EditTicketButton({Key key, this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
      onPressed: () => editTicket(
            context,
            ticket,
          ),
    );
  }
}

class DeleteTicketButton extends StatelessWidget {
  final Storage storage;
  final Ticket ticket;

  const DeleteTicketButton({Key key, this.storage, this.ticket})
      : super(key: key);

  void askDeleteTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ticket'),
          content:
              Text('Are you sure that you want to delete the selected ticket?'),
          actions: [
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                storage.deleteTicket(ticket);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('NO'),
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
      color: Theme.of(context).primaryColor,
      onPressed: () => askDeleteTicket(context),
    );
  }
}
