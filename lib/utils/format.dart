import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:intl/intl.dart';

import 'package:dw_ticket_pos/model/ticket_entries.dart';

String formatPrice(int price) {
  return (price ~/ 100).toString() +
      ',' +
      (price % 100).toString().padLeft(2, '0') +
      '€';
}

String formatTicketPrice(Ticket ticket) {
  String label = formatPrice(ticket.price);
  if (ticket.hasVirtualPrice)
    label = label + ' (' + formatPrice(ticket.virtualPrice) + ')';
  return label;
}

DateFormat _dateFormat;
DateFormat _dateTimeFormat;
DateFormat _inputDateFormat;
DateFormat _inputTimeFormat;

void initFormats() {
  _dateFormat = DateFormat.yMMMd('de_DE');
  _dateTimeFormat = DateFormat('dd. MMM y HH:mm', 'de_DE');
  _inputDateFormat = DateFormat('dd.MM.yyyy');
  _inputTimeFormat = DateFormat('HH:mm');
}

String formatDate(DateTime date) {
  return _dateFormat.format(date);
}

String formatDateTime(DateTime date) {
  return _dateTimeFormat.format(date);
}

String formatInputDate(DateTime date) {
  return _inputDateFormat.format(date);
}

String formatInputTime(DateTime date) {
  return _inputTimeFormat.format(date.toLocal());
}

String formatTicketEntries(TicketEntries ticketEntries) {
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
    return 'Keine Tickets verkauft';
  } else {
    return value;
  }
}
