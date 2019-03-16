import 'dart:async';

import 'package:dw_ticket_pos/views/event_journal.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/event_journal.dart';
import 'model/mock_event_journal.dart';

import 'utils/format.dart';

Future<Null> main() async {
  await intl_local_date_data.initializeDateFormatting();
  initFormats();
  // debugPaintSizeEnabled = true;
  runApp(DWTicketPosApp());
}

class DWTicketPosApp extends StatelessWidget {
  final EventJournal _eventJournal = MockEventJournal();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EventJournal>(
      model: _eventJournal,
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
        home: EventJournalView(),
      ),
    );
  }
}
