import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/views/event_home.dart';
import 'package:dw_ticket_pos/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
                    subtitle: Text(MaterialLocalizations.of(context).formatFullDate(event.dateTime)),
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
          title: Text(AppLocalizations.of(context).deleteEvent),
          content:
              Text(AppLocalizations.of(context).deleteEventMessage),
          actions: [
            FlatButton(
              child: Text(AppLocalizations.of(context).dialogYes),
              onPressed: () {
                storage.deleteEvent(event);
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
        hint: AppLocalizations.of(context).deleteEventHint,
        onPressed: () => askDeleteEvent(context),
      ),
    );
  }
}

