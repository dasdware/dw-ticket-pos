import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/views/event_details.dart';
import 'package:dw_ticket_pos/views/ticket_details.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/widgets/event_list.dart';
import 'package:dw_ticket_pos/widgets/ticket_list.dart';

class StorageHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
      viewModel: ApplicationScaffoldViewModel(
          title: 'DW Ticket Point of Sale',
          tabs: TabsViewModel(
            tabs: [
              TabViewModel(
                icon: Icons.event,
                hint: 'Events',
                body: EventListWidget(),
                mainAction: MainActionViewModel(
                  icon: Icons.add_circle,
                  title: 'New Event',
                  hint: 'Create a new event in the current storage',
                  onPressed: () => addEvent(context, Storage.of(context)),
                ),
              ),
              TabViewModel(
                icon: Icons.note,
                hint: 'Tickets',
                body: TicketListWidget(),
                mainAction: MainActionViewModel(
                  icon: Icons.add_circle,
                  title: 'New Ticket',
                  hint: 'Create a new ticket in the current storage',
                  onPressed: () => addTicket(context, Storage.of(context)),
                ),
              )
            ],
          )),
    );
  }
}
