import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/model/event_journal_summary_entry.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EventJournalEntriesOverviewWidget extends StatelessWidget {
  const EventJournalEntriesOverviewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EventJournalEntryOverviewPriceWidget(),
        EventJournalEntryOverviewTicketEntriesWidget()
      ],
    );
  }
}

class EventJournalEntryOverviewPriceWidget extends StatelessWidget {
  const EventJournalEntryOverviewPriceWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: ScopedModelDescendant<EventJournal>(
        builder: (context, _, model) => Text(
              formatPrice(model.summary.price),
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
      ),
    );
  }
}

class EventJournalEntryOverviewTicketEntriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventJournal journal = EventJournal.of(context);
    return Column(
      children: journal.summary.entries
          .map((entry) => ScopedModel<EventJournalSummaryEntry>(
                model: entry,
                child: EventJournalEntryOverviewTicketEntryWidget(),
              ))
          .toList(),
    );
  }
}

class EventJournalEntryOverviewTicketEntryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventJournalSummaryEntry entry = EventJournalSummaryEntry.of(context);
    return ListTile(
      title: Text(entry.ticket.title));
  }
}
