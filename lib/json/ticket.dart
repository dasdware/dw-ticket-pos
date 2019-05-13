import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';

class JSONTicket {
  String name;
  String color;
  int price;
  int virtualPrice;

  JSONTicket({this.name, this.color, this.price, this.virtualPrice});

  Ticket toTicket(Storage storage) => Ticket(storage, name, price, virtualPrice);
  Ticket toEventTicket(Event event) => Ticket.forEvent(event, name, price, virtualPrice);

  JSONTicket.fromTicket(Ticket ticket) :
    name = ticket.title,
    color = '',
    price = ticket.price,
    virtualPrice = ticket.virtualPrice;

  JSONTicket.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    price = json['price'];
    virtualPrice = json['virtualPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['price'] = this.price;
    data['virtualPrice'] = this.virtualPrice;
    return data;
  }


}