import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/booking_ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';

enum TicketEntryButtonKind { increment, decrement, reset }

class TicketEntryButtonWidget extends StatelessWidget {
  final TicketEntryButtonKind kind;

  const TicketEntryButtonWidget({Key key, this.kind}) : super(key: key);

  IconData get icon {
    switch (kind) {
      case TicketEntryButtonKind.increment:
        return Icons.add;
      case TicketEntryButtonKind.decrement:
        return Icons.remove;
      case TicketEntryButtonKind.reset:
        return Icons.cancel;
      default:
        return null;
    }
  }

  Color get color {
    switch (kind) {
      case TicketEntryButtonKind.increment:
        return Colors.green;
      case TicketEntryButtonKind.decrement:
        return Colors.red;
      case TicketEntryButtonKind.reset:
        return Colors.grey;
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
    final TicketEntry entry = TicketEntry.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 1, right: 1),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Icon(
              icon,
              color: Color.lerp(color, Colors.black, 0.5),
            ),
          ),
          onTap: () => _updateEntry(entry),
        ),
      ),
    );
  }
}
