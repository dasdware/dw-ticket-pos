import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/ticket_entry.dart';

abstract class TicketEntries extends Model {
  int get count;
  int get price;
  int get virtualPrice;

  bool get hasVirtualPrice => (price != virtualPrice);

  List<TicketEntry> get entries;

  static TicketEntries of(BuildContext context) =>
      ScopedModel.of<TicketEntries>(context);
}
