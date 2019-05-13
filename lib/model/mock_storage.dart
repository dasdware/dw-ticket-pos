import 'package:dw_ticket_pos/backends/storage_backend.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class MockStorage extends Storage {
  MockStorage(StorageBackend backend) : super(backend) {
    tickets
      ..add(Ticket(this, 'Standard Fare', 800))
      ..add(Ticket(this, 'Reduced Price', 500))
      ..add(Ticket(this, 'Free Entry', 0))
      ..add(Ticket(this, 'Virtual Free Entry', 0, 500));

    createEvent('Event #1', DateTime.utc(2019, 4, 11), tickets);
  }
}
