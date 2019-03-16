import 'package:dw_ticket_pos/model/event_journal.dart';
import 'package:dw_ticket_pos/model/event_journal_summary_entry.dart';
import 'package:scoped_model/scoped_model.dart';

class EventJournalSummary extends Model {
  final EventJournal _journal;
  List<EventJournalSummaryEntry> _entries;

  EventJournalSummary(this._journal) {
    _entries = _journal.availableTickets
        .map((ticket) => EventJournalSummaryEntry(_journal, ticket))
        .toList();
  }

  List<EventJournalSummaryEntry> get entries => _entries;

  int get count {
    int sum = 0;
    for (EventJournalSummaryEntry entry in _entries) {
      sum += entry.count;
    }
    return sum;
  }

  int get price {
    int sum = 0;
    for (EventJournalSummaryEntry entry in _entries) {
      sum += entry.price;
    }
    return sum;
  }
}
