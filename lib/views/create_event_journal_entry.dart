import 'package:dw_ticket_pos/model/event_entry.dart';
import 'package:dw_ticket_pos/model/journal_event_entry.dart';
import 'package:dw_ticket_pos/widgets/event_entry_price.dart';
import 'package:dw_ticket_pos/widgets/ticket_entries.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/event_journal.dart';

class CreateEventJournalEntryView extends StatefulWidget {
  final EventJournal eventJournal;

  CreateEventJournalEntryView(this.eventJournal, {Key key}) : super(key: key);

  @override
  _CreateEventJournalEntryViewState createState() =>
      _CreateEventJournalEntryViewState();
}

class _CreateEventJournalEntryViewState
    extends State<CreateEventJournalEntryView> {
  JournalEventEntry _entry;

  @override
  void initState() {
    super.initState();
    _entry = widget.eventJournal.addEntry();
  }

  void commit(BuildContext context) {
    _entry.commit();
    Navigator.of(context).pop();
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EventEntry>(
      model: _entry,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Neue Ticketbuchung'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new EventEntryPriceWidget(),
            new TicketEntriesWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => commit(context),
          tooltip: 'Tickets buchen',
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}

