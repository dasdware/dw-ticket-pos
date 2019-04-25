import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/views/event_details.dart';
import 'package:dw_ticket_pos/views/ticket_details.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';

import 'package:dw_ticket_pos/widgets/event_list.dart';
import 'package:dw_ticket_pos/widgets/ticket_list.dart';

class StorageHomeView extends StatefulWidget {
  @override
  _StorageHomeViewState createState() => _StorageHomeViewState();
}

class _StorageHomeViewState extends State<StorageHomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DW Ticket Point of Sale'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.event)),
            Tab(icon: Icon(Icons.note)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          new EventListWidget(),
          new TicketListWidget(),
        ],
      ),
      floatingActionButton: MainActionButtons(
        tabController: _tabController,
        viewModels: [
          MainActionButtonViewModel(
            icon: Icons.add_circle,
            caption: 'New Event',
            onPressed: () => addEvent(context, Storage.of(context)),
          ),
          MainActionButtonViewModel(
            icon: Icons.add_circle,
            caption: 'New Ticket',
            onPressed: () => addTicket(context, Storage.of(context)),
          ),
        ],
      ),
    );
  }
}
