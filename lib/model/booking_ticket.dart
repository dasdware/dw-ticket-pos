import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/model/ticket_entry.dart';

class BookingTicket extends TicketEntry {
  final Booking _booking;
  final Ticket _ticket;
  int _count = 0;

  BookingTicket(this._booking, this._ticket);

  int get count => _count;
  int get price => count * _ticket.price;
  int get virtualPrice => count * ((_ticket.virtualPrice > -1) ? _ticket.virtualPrice : _ticket.price);

  Ticket get ticket => _ticket;

  void _changed() {
    notifyListeners();
    _booking.notifyListeners();
  }

  void updateCount(int amount) {
    _count += amount;
    if (count < 0) {
      _count = 0;
    }
    _changed();
  }

  void resetCount() {
    _count = 0;
    _changed();
  }
}
