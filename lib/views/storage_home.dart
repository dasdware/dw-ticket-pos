import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
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
    final localizations = AppLocalizations.of(context);
    return ApplicationScaffold(
      viewModel: ApplicationScaffoldViewModel(
          title: localizations.title,
          tabs: TabsViewModel(
            tabs: [
              TabViewModel(
                icon: Icons.event,
                hint: localizations.events,
                body: EventListWidget(),
                mainAction: MainActionViewModel(
                  icon: Icons.add_circle,
                  title: localizations.newEvent,
                  hint: localizations.newEventHint,
                  onPressed: () => addEvent(context, Storage.of(context)),
                ),
              ),
              TabViewModel(
                icon: Icons.note,
                hint: localizations.tickets,
                body: TicketListWidget(),
                mainAction: MainActionViewModel(
                  icon: Icons.add_circle,
                  title: localizations.newTicket,
                  hint: localizations.newTicketHint,
                  onPressed: () => addTicket(context, Storage.of(context)),
                ),
              )
            ],
          )),
    );
  }
}
