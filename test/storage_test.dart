import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dw_ticket_pos/json/storage.dart';

void main() {
  testWidgets('Should read json correctly', (WidgetTester tester) async {
    String fileContent = await rootBundle.loadString('assets/sample_data.json');
    // String fileContent = File('storage_test.json').readAsStringSync();
    var json = jsonDecode(fileContent);
    JSONStorage storage = JSONStorage.fromJson(json);
    print(storage.tickets[0].name);
  });
}
