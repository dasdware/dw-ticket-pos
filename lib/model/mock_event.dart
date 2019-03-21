import 'event.dart';
import 'ticket.dart';

class MockEvent extends Event {

  MockEvent() : super(
    'Veranstaltung #1', 
    DateTime.utc(2019, 4, 11),
    [
      Ticket('Normalpreis', 800),
      Ticket('Ermäßigt', 500),
      Ticket('Freikarte', 0),
      Ticket('Virtuelle Freikarte', 0, 500),
    ]);
}
