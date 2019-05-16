import 'package:dw_ticket_pos/model/event.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:dw_ticket_pos/views/event_home.dart';

import 'action_button.dart';

class EventListWidget extends StatelessWidget {
  const EventListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Storage>(
      builder: (context, _, storage) => ListView(
        children: storage.events
            .map(
              (event) => ListTile(
                    title: Text(event.name),
                    subtitle: Text(formatDate(event.dateTime)),
                    trailing: DeleteEventButton(storage: storage, event: event),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventHomeView(
                                  storage: storage, event: event)));
                    },
                  ),
            )
            .toList(),
      ),
    );
  }
}

class DeleteEventButton extends StatelessWidget {
  final Storage storage;
  final Event event;

  const DeleteEventButton({Key key, this.storage, this.event})
      : super(key: key);

  void askDeleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete event'),
          content:
              Text('Are you sure that you want to delete the selected event?'),
          actions: [
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                storage.deleteEvent(event);
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
    return ActionButton(
      viewModel: ActionViewModel(
        icon: Icons.delete,
        hint: 'Delete this event',
        onPressed: () => askDeleteEvent(context),
      ),
    );
  }
}

