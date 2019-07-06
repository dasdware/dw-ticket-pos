import 'dart:ui';

import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:dw_ticket_pos/widgets/ticket_list_tiles.dart';
import 'package:flutter/material.dart';

void addEvent(BuildContext context, Storage storage) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailsView(
          storage: storage,
          viewTitle: AppLocalizations.of(context).createEvent,
          eventTitle: '',
          dateTime: DateTime.now(),
          mainActionTitle: AppLocalizations.of(context).createEvent,
          onCommit: (String title, DateTime dateTime, List<Ticket> tickets) {
            storage.createEvent(title, dateTime, tickets);
            return true;
          }),
    ),
  );
}

typedef OnEventDetailsCommit = bool Function(
    String title, DateTime dateTime, List<Ticket> tickets);

class _TicketSelection extends ChangeNotifier {
  final Ticket ticket;
  bool _selected;

  _TicketSelection({this.ticket}) : _selected = false;

  get selected => _selected;

  set selected(bool selected) {
    _selected = selected;
    notifyListeners();
  }
}

class EventDetailsView extends StatefulWidget {
  final Storage storage;
  final String viewTitle;
  final String eventTitle;
  final DateTime dateTime;
  final String mainActionTitle;
  final String mainActionHint;
  final OnEventDetailsCommit onCommit;

  const EventDetailsView(
      {Key key,
      this.storage,
      this.viewTitle,
      this.eventTitle,
      this.dateTime,
      this.mainActionTitle,
      this.mainActionHint,
      this.onCommit})
      : super(key: key);

  @override
  _EventDetailsViewState createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  TextEditingController titleController;
  DateTime dateTime;
  List<_TicketSelection> ticketSelection;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController(text: widget.eventTitle);
    dateTime = widget.dateTime;
    ticketSelection = widget.storage.tickets
        .map((ticket) => _TicketSelection(ticket: ticket))
        .toList();
    ticketSelection
        .forEach((selection) => selection.addListener(() => setState(() {})));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != dateTime)
      setState(() {
        dateTime = DateTime.utc(picked.year, picked.month, picked.day,
            dateTime.hour, dateTime.minute, dateTime.second);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dateTime),
    );

    if (picked != null &&
        (picked.hour != dateTime.hour || picked.minute != dateTime.minute)) {
      setState(() {
        dateTime = DateTime.utc(dateTime.year, dateTime.month, dateTime.day,
            picked.hour, picked.minute, dateTime.second);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
      viewModel: ApplicationScaffoldViewModel(
          title: widget.viewTitle,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    labelText: AppLocalizations.of(context).eventTitle,
                    controller: titleController,
                  ),
                  ButtonedText(
                    label: AppLocalizations.of(context).eventDate,
                    value: MaterialLocalizations.of(context).formatFullDate(dateTime),
                    icon: Icons.today,
                    onPressed: () => _selectDate(context),
                  ),
                  ButtonedText(
                    label: AppLocalizations.of(context).eventTime,
                    value: MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(dateTime)),
                    icon: Icons.watch_later,
                    onPressed: () => _selectTime(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(AppLocalizations.of(context).eventAvailableTickets),
                  ),
                ]..addAll(
                    ticketSelection.map(
                      (selection) =>
                          new TicketSelectionListTile(selection: selection),
                    ),
                  ),
              ),
            ),
          ),
          mainAction: MainActionViewModel(
            icon: Icons.check,
            title: widget.mainActionTitle,
            hint: widget.mainActionHint,
            onPressed: () {
              if (widget.onCommit == null ||
                  widget.onCommit(
                      titleController.text,
                      dateTime,
                      ticketSelection
                          .where((selection) => selection.selected)
                          .map((selection) => selection.ticket)
                          .toList())) {
                Navigator.of(context).pop();
              }
            },
          )),
    );
  }
}

class TicketSelectionListTile extends StatelessWidget {
  final _TicketSelection selection;

  const TicketSelectionListTile({
    Key key,
    this.selection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TicketListTile(
      ticket: selection.ticket,
      leading: Checkbox(
        value: selection.selected,
        onChanged: (value) => selection.selected = value,
      ),
    );
  }
}

class ButtonedText extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonedText(
      {Key key, this.label, this.value, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(label, style: TextStyle(fontSize: 11.0)),
                  Text(value, style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
            IconButton(
              iconSize: 26.0,
              icon: Icon(icon),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    @required this.controller,
    @required this.labelText,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final EdgeInsets padding;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        enabled: enabled,
        controller: controller,
      ),
    );
  }
}
