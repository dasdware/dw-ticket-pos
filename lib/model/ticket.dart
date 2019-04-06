import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Ticket extends Model {
  String title;
  int price;
  int virtualPrice;

  Ticket(this.title, this.price, [this.virtualPrice = -1]);

  Ticket clone() => Ticket(title, price, virtualPrice);

  bool get hasVirtualPrice => (virtualPrice > -1);

  static Ticket of(BuildContext context) => ScopedModel.of<Ticket>(context);
}
