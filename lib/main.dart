import 'dart:ui';

import 'package:dw_ticket_pos/backends/jsonfile_storage_backend.dart';
import 'package:dw_ticket_pos/backends/storage_backend.dart';
import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/views/storage_home.dart';
import 'package:dw_ticket_pos/widgets/application_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

StorageBackend createStorageBackend() {
  return JsonfileStorageBackend();
}

Future<Null> main() async {
  runApp(DWTicketPosApp(createStorageBackend()));
}

class DWTicketPosApp extends StatelessWidget {
  final StorageBackend backend;

  DWTicketPosApp(this.backend);

  @override
  Widget build(BuildContext context) {
    return ApplicationTheme(
      primaryColor: Color.lerp(Colors.deepPurple, Colors.black, 0.4),
      backgroundColor: Colors.white,
      child: new Application(storageLoader: backend.load()),
    );
  }
}

class Application extends StatelessWidget {
  const Application({
    Key key,
    @required this.storageLoader,
  }) : super(key: key);

  final Future<Storage> storageLoader;

  @override
  Widget build(BuildContext context) {
    final theme = ApplicationTheme.of(context);
    return MaterialApp(
      title: 'DW Ticket Point of Sale',
      theme: theme.themeData,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('de'),
      ],
      locale: Locale('en'),
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
    );
  }
}
