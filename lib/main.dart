import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/views/storage_home.dart';
import 'package:dw_ticket_pos/widgets/application_theme.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/utils/format.dart';

Future<Storage> loadStorage() {
  return Storage.load();
}

Future<Null> main() async {
  await intl_local_date_data.initializeDateFormatting();
  initFormats();
  runApp(DWTicketPosApp(loadStorage()));
}

class DWTicketPosApp extends StatelessWidget {
  final Future<Storage> storageLoader;

  DWTicketPosApp(this.storageLoader);

  @override
  Widget build(BuildContext context) {
    return ApplicationTheme(
      primaryColor: Color.lerp(Colors.deepPurpleAccent, Colors.black, 0.4),
      backgroundColor: Colors.white,
      
      child: MaterialApp(
        title: 'DW Ticket Point of Sale',
        home: FutureBuilder<Storage>(
          future: this.storageLoader,
          builder: (context, storage) {
            if (!storage.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ScopedModel<Storage>(
                model: storage.data,
                child: StorageHomeView(),
              );
            }
          },
        ),
      ),
    );
  }
}
