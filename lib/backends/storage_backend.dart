import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

abstract class StorageBackend {

  Future<Storage> load();

  void ticketAdded(Ticket ticket);
  void ticketChanged(Ticket ticket);
  void ticketRemoved(Ticket ticket);

  void eventAdded(Event event);
  void eventChanged(Event event);
  void eventRemoved(Event event);

  void bookingAdded(Booking booking);
  void bookingRemoved(Booking booking);
}