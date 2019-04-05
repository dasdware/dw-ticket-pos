import 'dart:async';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/views/storage_home.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:dw_ticket_pos/model/mock_storage.dart';
import 'package:dw_ticket_pos/utils/format.dart';

Future<Null> main() async {
  await intl_local_date_data.initializeDateFormatting();
  initFormats();
  // debugPaintSizeEnabled = true;
  runApp(DWTicketPosApp());
}

class DWTicketPosApp extends StatelessWidget {
  Future<Storage> loadEvent(BuildContext context) {
    return Future<Storage>.delayed(
      Duration(seconds: 2),
      () => MockStorage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Storage>(
        future: loadEvent(context),
        builder: (context, storage) {
          if (!storage.hasData) {
            print("No data! " + new DateTime.now().toString());
            return Center(child: CircularProgressIndicator());
          } else {
            print("Data! " + new DateTime.now().toString());
            return ScopedModel<Storage>(
              model: storage.data,
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // Try running your application with "flutter run". You'll see the
                  // application has a blue toolbar. Then, without quitting the app, try
                  // changing the primarySwatch below to Colors.green and then invoke
                  // "hot reload" (press "r" in the console where you ran "flutter run",
                  // or simply save your changes to "hot reload" in a Flutter IDE).
                  // Notice that the counter didn't reset back to zero; the application
                  // is not restarted.
                  primarySwatch: Colors.blue,
                ),
                home: StorageHomeView(),
              ),
            );
          }
        });
  }
}
