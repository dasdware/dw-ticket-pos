import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:dw_ticket_pos/views/event_create_booking.dart';
import 'package:dw_ticket_pos/widgets/bookings_list.dart';
import 'package:dw_ticket_pos/widgets/bookings_summary.dart';
import 'package:scoped_model/scoped_model.dart';

class EventHomeView extends StatelessWidget {
  final Event event;

  const EventHomeView({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Event>(
      model: event,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(event.name),
                      Text(formatDate(event.dateTime),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14)),
                    ]),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.assessment)),
                  Tab(icon: Icon(Icons.list)),
                ])
                // leading: Icon(Icons.arrow_back),
                ),
            body: TabBarView(
              children: [
                // EventJournalEntryWidget(eventJournal.addEntry(), null),
                new BookingsSummaryWidget(),
                new BookingsListWidget(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventCreateBookingView(event)));
              },
              tooltip: 'Neue Buchung',
              child: Icon(Icons.add),
            ),
          )),
    );
  }
}
