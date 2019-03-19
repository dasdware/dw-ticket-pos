import 'package:dw_ticket_pos/model/event_entry.dart';
import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/model/summary_ticket_entry.dart';

class Summary extends EventEntry {
  final EventJournal _journal;
  List<SummaryTicketEntry> _entries;

  Summary(this._journal) {
    _entries = _journal.availableTickets
        .map((ticket) => SummaryTicketEntry(_journal, ticket))
        .toList();
  }

  List<SummaryTicketEntry> get entries => _entries;

  int get count {
    int sum = 0;
    for (SummaryTicketEntry entry in _entries) {
      sum += entry.count;
    }
    return sum;
  }

  int get price {
    int sum = 0;
    for (SummaryTicketEntry entry in _entries) {
      sum += entry.price;
    }
    return sum;
  }
}
