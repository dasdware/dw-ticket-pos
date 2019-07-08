import 'dart:convert';
import 'dart:io';

import 'package:dw_ticket_pos/json/settings.dart';
import 'package:path_provider/path_provider.dart';

import 'localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef AppSettingsBuilder = Widget Function(BuildContext context, AppSettings settings);

class AppSettings extends ChangeNotifier {

  final AppSettingsStorage provider;

  String _version = "0.1";
  AppLanguage _language = AppLocalizations.defaultLanguage;

  AppSettings(this.provider);

  AppLanguage get language => _language;
  set language(AppLanguage language) {
    _language = language;
    notifyListeners();
  }

  String get version => _version;
}

class AppSettingsStorage {
  Future<AppSettings> _loader;
  AppSettings _settings;

  Future<AppSettings> load() async {
    if (_loader == null) {
      _loader = _createLoader();
    }
    return _loader;
  }

  Future<AppSettings> _createLoader() async {
    final File input = await _getDefaultSettingsFile();

    _settings = AppSettings(this);
    if (await input.exists()) {
      final jsonString = await input.readAsString();
      final jsonSettings = JSONSettings.fromJson(jsonDecode(jsonString));

      _settings._version = jsonSettings.version;
      _settings._language = AppLocalizations.supportedLanguages.where(
        (language) => language.languageCode == jsonSettings.language).first;
    }

    _settings.addListener(_save);
    return _settings;
  }

  void _save() async {
    if (_settings != null) {
      final json = JSONSettings();
      json.version = _settings.version;
      json.language = _settings.language.languageCode;
      final jsonString = jsonEncode(json);
      print(jsonString);

      File output = await _getDefaultSettingsFile();
      print(output.path);
      await output.writeAsString(jsonString);
    }
  }

  static Future<File> _getDefaultSettingsFile() async {
    final path = await getApplicationDocumentsDirectory();
    return File('${path.path}/settings.json');
  } 
}

class AppSettingsProvider extends StatelessWidget {

  final Widget child;
  final AppSettingsStorage _storage = AppSettingsStorage();

  AppSettingsProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => 
    FutureBuilder<AppSettings>(
      future: _storage.load(),
      builder: (BuildContext context, AsyncSnapshot<AppSettings> snapshot) {
        if (snapshot.hasData) {
          return  ChangeNotifierProvider<AppSettings>.value(
            value: snapshot.data,
            child: child,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
}
