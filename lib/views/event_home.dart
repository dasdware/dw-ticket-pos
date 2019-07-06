import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/views/event_create_booking.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/bookings_list.dart';
import 'package:dw_ticket_pos/widgets/bookings_summary.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EventHomeView extends StatelessWidget {
  final Storage storage;
  final Event event;

  const EventHomeView({Key key, this.storage, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Storage>(
      model: storage,
      child: ScopedModel<Event>(
        model: event,
        child: ApplicationScaffold(
          viewModel: ApplicationScaffoldViewModel(
            title: event.name,
            subtitle: MaterialLocalizations.of(context).formatFullDate(event.dateTime),
            tabs: TabsViewModel(initialTabIndex: 0, tabs: [
              TabViewModel(
                icon: Icons.assessment,
                hint: AppLocalizations.of(context).bookingsSummaryHint,
                body: BookingsSummaryWidget(),
              ),
              TabViewModel(
                icon: Icons.list,
                hint: AppLocalizations.of(context).bookingsListHint,
                body: BookingsListWidget(),
              ),
            ]),
            mainAction: MainActionViewModel(
              icon: Icons.add_circle,
              title: AppLocalizations.of(context).newBooking,
              hint: AppLocalizations.of(context).newBookingHint,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventCreateBookingView(event)));
              },
            ),
          ),
        ),
      ),
    );
  }
}
