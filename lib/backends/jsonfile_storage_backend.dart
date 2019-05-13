import 'dart:convert';
import 'dart:io';

import 'package:dw_ticket_pos/backends/storage_backend.dart';
import 'package:dw_ticket_pos/json/storage.dart';
import 'package:dw_ticket_pos/model/booking.dart';
import 'package:dw_ticket_pos/model/event.dart';
import 'package:dw_ticket_pos/model/mock_storage.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:path_provider/path_provider.dart';

class JsonfileStorageBackend implements StorageBackend {

  Storage _storage;
  Future<Storage> _loader;

  @override
  void bookingAdded(Booking booking) {
    _save();
  }

  @override
  void bookingRemoved(Booking booking) {
    _save();
  }

  @override
  void eventAdded(Event event) {
    _save();
  }

  @override
  void eventChanged(Event event) {
    _save();
  }

  @override
  void eventRemoved(Event event) {
    _save();
  }

  @override
  void ticketAdded(Ticket ticket) {
    _save();
  }

  @override
  void ticketChanged(Ticket ticket) {
    _save();
  }

  @override
  void ticketRemoved(Ticket ticket) {
    _save();
  }

  @override
  Future<Storage> load() async {
    if (_loader == null) {
      _loader = _createLoader();
    }
    return _loader;
  }

  Future<Storage> _createLoader() async {
    final File input = await _getDefaultStorageFile();
    if (await input.exists()) {
      final jsonString = await input.readAsString();
      _storage = JSONStorage.fromJson(jsonDecode(jsonString)).toStorage(this);
    } else {
      _storage = MockStorage(this);
    }
    return _storage;
  }

  void _save() async {
    if (_storage != null) {
      final json = JSONStorage.fromStorage(_storage);
      final jsonString = jsonEncode(json);
      print(jsonString);

      File output = await _getDefaultStorageFile();
      print(output.path);
      await output.writeAsString(jsonString);
    }
  }

  static Future<File> _getDefaultStorageFile() async {
    final path = await getApplicationDocumentsDirectory();
    return File('${path.path}/storage.json');
  }
}