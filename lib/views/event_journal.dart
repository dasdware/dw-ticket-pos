import 'package:dw_ticket_pos/model/event_journal_entry.dart';
import 'package:dw_ticket_pos/widgets/event_journal_entries_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/views/create_event_journal_entry.dart';

import '../model/event_journal.dart';
// import '../widgets/event_journal_entry.dart';
import '../utils/format.dart';

class EventJournalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventJournal eventJournal = EventJournal.of(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(eventJournal.name),
                    Text(formatDate(eventJournal.dateTime),
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
              Icon(Icons.assessment),
              new EventJournalEntriesListWidget(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateEventJournalEntryView(eventJournal)));
            },
            tooltip: 'Neue Buchung',
            child: Icon(Icons.add),
          ),
        ));
  }
}
