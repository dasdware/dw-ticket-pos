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
        builder: (context, _, storage) => ListView(
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
                                        EventHomeView(event: event)));
                          },
                        ),
                  )
                  .toList(),
            ));
  }
}
