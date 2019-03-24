import 'package:dw_ticket_pos/model/ticket_entries.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/summary_ticket.dart';

class Summary extends TicketEntries {
  final Event _journal;
  List<SummaryTicket> _entries;

  Summary(this._journal) {
    _entries = _journal.availableTickets
        .map((ticket) => SummaryTicket(_journal, ticket))
        .toList();
  }

  List<SummaryTicket> get entries => _entries;

  int get count {
    int sum = 0;
    for (SummaryTicket entry in _entries) {
      sum += entry.count;
    }
    return sum;
  }

  int get price {
    int sum = 0;
    for (SummaryTicket entry in _entries) {
      sum += entry.price;
    }
    return sum;
  }

  int get virtualPrice {
    int sum = 0;
    for (SummaryTicket entry in _entries) {
      sum += entry.virtualPrice;
    }
    return sum;
  }
}
