import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/model/ticket_entries.dart';

String formatPrice(BuildContext context, int price) {
  return (price ~/ 100).toString() +
      ',' +
      (price % 100).toString().padLeft(2, '0') +
      '€';
}

String formatTicketPrice(BuildContext context, Ticket ticket) {
  String label = formatPrice(context, ticket.price);
  if (ticket.hasVirtualPrice)
    label = label + ' (' + formatPrice(context, ticket.virtualPrice) + ')';
  return label;
}

String formatDate(BuildContext context, DateTime date) {
  var localizations = MaterialLocalizations.of(context);
  return localizations.formatMediumDate(date);
}

String formatDateTime(BuildContext context, DateTime date) {
  var localizations = MaterialLocalizations.of(context);
  return localizations.formatMediumDate(date) + ' ' + 
    localizations.formatTimeOfDay(TimeOfDay.fromDateTime(date));
}

String formatTicketEntries(BuildContext context, TicketEntries ticketEntries) {
  String value = ticketEntries.entries.fold('', (combined, ticketEntry) {
    if (ticketEntry.count > 0) {
      if (combined.isNotEmpty) {
        combined += ', ';
      }
      combined +=
          ticketEntry.count.toString() + 'x ' + ticketEntry.ticket.title;
    }
    return combined;
  });

  if (value.isEmpty) {
    return AppLocalizations.of(context).noTicketsSold;
  } else {
    return value;
  }
}
