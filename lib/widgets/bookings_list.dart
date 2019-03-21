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
            children: model.entries.reversed
                .map((entry) => ListTile(
                      title: Text(formatDateTime(entry.timestamp)),
                      subtitle: Text(formatTicketEntries(entry)),
                      trailing: Text(formatPrice(entry.price),
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                    ))
                .toList(),
          ),
    );
  }
}
