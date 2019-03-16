import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/event_journal_entry.dart';
import 'package:dw_ticket_pos/model/event_journal.dart';

import 'package:dw_ticket_pos/widgets/event_journal_entry_price.dart';
import 'package:dw_ticket_pos/widgets/ticket_journal_entries.dart';

class CreateEventJournalEntryView extends StatefulWidget {
  final EventJournal eventJournal;

  CreateEventJournalEntryView(this.eventJournal, {Key key}) : super(key: key);

  @override
  _CreateEventJournalEntryViewState createState() =>
      _CreateEventJournalEntryViewState();
}

class _CreateEventJournalEntryViewState
    extends State<CreateEventJournalEntryView> {
  EventJournalEntry _entry;

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
    return ScopedModel<EventJournalEntry>(
      model: _entry,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Neue Ticketbuchung'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new EventJournalEntryPriceWidget(),
            new TicketJournalEntriesWidget(),
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
