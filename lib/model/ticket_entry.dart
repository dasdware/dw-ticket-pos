import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class TicketEntry extends Model {
  int get count;
  int get price;

  Ticket get ticket;

  static TicketEntry of(BuildContext context) =>
      ScopedModel.of(context);

}