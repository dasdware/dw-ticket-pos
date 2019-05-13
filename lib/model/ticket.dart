import 'package:dw_ticket_pos/backends/storage_backend.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Ticket extends Model {
  final Storage storage;
  final Event event;

  String _title;
  int _price;
  int _virtualPrice;

  Ticket(this.storage, this._title, this._price, [this._virtualPrice = -1])
      : event = null;
  Ticket.forEvent(this.event, this._title, this._price, [this._virtualPrice = -1])
      : storage = null;

  StorageBackend get _backend  => (event != null) ? event.storage.backend : storage.backend;

  String get title => _title;
  int get price => _price;
  bool get hasVirtualPrice => (virtualPrice > -1);
  int get virtualPrice => _virtualPrice;

  Ticket cloneWithEvent(Event event) =>
      Ticket.forEvent(event, title, price, virtualPrice);

  void update(String title, int price, int virtualPrice) {
    _title = title;
    _price = price;
    _virtualPrice = virtualPrice;
    _backend.ticketChanged(this);
  }

  static Ticket of(BuildContext context) => ScopedModel.of<Ticket>(context);
}
