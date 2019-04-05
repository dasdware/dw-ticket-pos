import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/widgets/event_list.dart';
import 'package:dw_ticket_pos/widgets/ticket_list.dart';

class StorageHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('DW Ticket-Verkaufspunkt'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.event)),
              Tab(icon: Icon(Icons.note)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            new EventListWidget(),
            new TicketListWidget(),
          ],
        ),
      ),
    );
  }
}
