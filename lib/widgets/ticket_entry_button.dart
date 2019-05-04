import 'package:dw_ticket_pos/widgets/action_button.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/booking_ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';

enum TicketEntryButtonKind { increment, decrement, reset }

class TicketEntryButtonWidget extends StatelessWidget {
  final TicketEntryButtonKind kind;

  const TicketEntryButtonWidget({Key key, this.kind}) : super(key: key);

  ActionViewModel _buildActionViewModel(BuildContext context) {
    print(kind);
    switch (kind) {
      case TicketEntryButtonKind.increment:
        return ActionViewModel(
          icon: Icons.add,
          hint: 'Add one ticket',
          onPressed: () => _updateEntry(TicketEntry.of(context)),
        );
      case TicketEntryButtonKind.decrement:
        return ActionViewModel(
          icon: Icons.remove,
          hint: 'Remove one ticket',
          onPressed: () => _updateEntry(TicketEntry.of(context)),
        );
      case TicketEntryButtonKind.reset:
        return ActionViewModel(
          icon: Icons.cancel,
          hint: 'Clear tickets',
          onPressed: () => _updateEntry(TicketEntry.of(context)),
        );
      default:
        return null;
    }
  }

  void _updateEntry(TicketEntry entry) {
    // TODO: This is a bit hacky
    if (entry is BookingTicket) {
      switch (kind) {
        case TicketEntryButtonKind.increment:
          entry.updateCount(1);
          return;
        case TicketEntryButtonKind.decrement:
          entry.updateCount(-1);
          return;
        case TicketEntryButtonKind.reset:
          entry.resetCount();
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      viewModel: _buildActionViewModel(context),
    );
  }
}
