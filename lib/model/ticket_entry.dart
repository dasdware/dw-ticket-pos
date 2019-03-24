import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket.dart';

abstract class TicketEntry extends Model {
  int get count;
  int get price;
  int get virtualPrice;

  Ticket get ticket;

  static TicketEntry of(BuildContext context) =>
      ScopedModel.of(context);

}
