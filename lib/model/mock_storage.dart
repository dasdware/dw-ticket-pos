import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class MockStorage extends Storage {

  MockStorage() {
    tickets
      ..add(Ticket('Normalpreis', 800))
      ..add(Ticket('Ermäßigt', 500))
      ..add(Ticket('Freikarte', 0))
      ..add(Ticket('Virtuelle Freikarte', 0, 500));

    createEvent('Veranstaltung #1', DateTime.utc(2019, 4, 11), tickets);
  }
}
