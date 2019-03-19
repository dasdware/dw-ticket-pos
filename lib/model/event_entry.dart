import 'package:dw_ticket_pos/model/ticket_entry.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class EventEntry extends Model {
  int get count;
  int get price;
  List<TicketEntry> get entries;

  static EventEntry of(BuildContext context) =>
      ScopedModel.of<EventEntry>(context);
}