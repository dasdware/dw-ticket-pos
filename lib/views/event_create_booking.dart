import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/widgets/ticket_entries_price.dart';
import 'package:dw_ticket_pos/widgets/ticket_entries.dart';
import 'package:dw_ticket_pos/model/event.dart';

class EventCreateBookingView extends StatefulWidget {
  final Event event;

  EventCreateBookingView(this.event, {Key key}) : super(key: key);

  @override
  _EventCreateBookingViewState createState() => _EventCreateBookingViewState();
}

class _EventCreateBookingViewState extends State<EventCreateBookingView> {
  Booking _booking;

  @override
  void initState() {
    super.initState();
    _booking = widget.event.addBooking();
  }

  void commit(BuildContext context) {
    _booking.commit();
    Navigator.of(context).pop();
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TicketEntries>(
      model: _booking,
      child: ApplicationScaffold(
        viewModel: ApplicationScaffoldViewModel(
          title: AppLocalizations.of(context).createBooking,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TicketEntriesPriceWidget(),
              TicketEntriesWidget(),
            ],
          ),
          mainAction: MainActionViewModel(
            icon: Icons.check,
            title: AppLocalizations.of(context).createBookingCommit,
            hint: AppLocalizations.of(context).createBookingCommitHint,
            onPressed: () => commit(context), 
          ),
        ),
      ),
    );
  }
}
