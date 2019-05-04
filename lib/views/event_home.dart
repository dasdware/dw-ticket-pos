import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/widgets/action_button.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/utils/format.dart';
import 'package:dw_ticket_pos/views/event_create_booking.dart';
import 'package:dw_ticket_pos/widgets/bookings_list.dart';
import 'package:dw_ticket_pos/widgets/bookings_summary.dart';
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
            subtitle: formatDate(event.dateTime),
            actions: [
              ActionViewModel(
                icon: Icons.save,
                hint: 'Save the current state in the storage',
                onPressed: () => storage.save(),
              ),
            ],
            tabs: TabsViewModel(initialTabIndex: 0, tabs: [
              TabViewModel(
                icon: Icons.assessment,
                hint: 'Bookings summary',
                body: BookingsSummaryWidget(),
              ),
              TabViewModel(
                icon: Icons.list,
                hint: 'Bookings list',
                body: BookingsListWidget(),
              ),
            ]),
            mainAction: MainActionViewModel(
              icon: Icons.add_circle,
              title: 'New Booking',
              hint: 'Create new ticket Booking',
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
