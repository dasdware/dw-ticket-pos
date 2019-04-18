import 'package:dw_ticket_pos/views/event_details.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:dw_ticket_pos/views/event_home.dart';

class EventListWidget extends StatelessWidget {
  const EventListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Storage>(
      builder: (context, _, storage) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ListView(
                  children: storage.events
                      .map(
                        (event) => ListTile(
                              title: Text(event.name),
                              subtitle: Text(formatDate(event.dateTime)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventHomeView(storage: storage, event: event)));
                              },
                            ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.green.shade900,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'New Event',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () => addEvent(context, storage),
                ),
              ),
            ],
          ),
    );
  }
}
