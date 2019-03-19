// import 'package:intl/date_symbol_data_file.dart';
import 'package:dw_ticket_pos/model/journal_event_entry.dart';
import 'package:intl/intl.dart';

String formatPrice(int price) {
  return (price ~/ 100).toString() +
      ',' +
      (price % 100).toString().padLeft(2, '0') +
      '€';
}

DateFormat _dateFormat;
DateFormat _dateTimeFormat;

void initFormats() {
  _dateFormat = DateFormat.yMMMd('de_DE');
  _dateTimeFormat = DateFormat('dd. MMM y HH:mm:ss', 'de_DE');
}

String formatDate(DateTime date) {
  return _dateFormat.format(date);
}

String formatDateTime(DateTime date) {
  return _dateTimeFormat.format(date);
}

String formatTicketEntries(JournalEventEntry entry) {
  String value = entry.entries.fold('', (combined, ticketEntry) {
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
