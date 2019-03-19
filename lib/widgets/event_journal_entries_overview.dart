import 'package:dw_ticket_pos/model/event_entry.dart';
import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/widgets/event_entry_price.dart';
import 'package:dw_ticket_pos/widgets/ticket_entries.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EventJournalEntriesOverviewWidget extends StatelessWidget {
  const EventJournalEntriesOverviewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EventJournal>(
        builder: (context, _, model) => ScopedModel<EventEntry>(
            model: model.summary,
            child: Column(
              children: <Widget>[
                EventEntryPriceWidget(),
                TicketEntriesWidget(readonly: true,),
              ],
            )));
  }
}

