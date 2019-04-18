import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class MockStorage extends Storage {

  MockStorage() {
    tickets
      ..add(Ticket('Standard Fare', 800))
      ..add(Ticket('Reduced Price', 500))
      ..add(Ticket('Free Entry', 0))
      ..add(Ticket('Virtual Free Entry', 0, 500));

    createEvent('Event #1', DateTime.utc(2019, 4, 11), tickets);
  }
}
