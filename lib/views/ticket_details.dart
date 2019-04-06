import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:flutter/material.dart';

void editTicket(BuildContext context, Ticket ticket) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TicketDetailsView(
          ticket: ticket,
          onCommit: (String title, int price, bool hasVirtualPrice,
              int virtualPrice) {
            ticket.title = title;
            ticket.price = price;
            ticket.virtualPrice = hasVirtualPrice ? virtualPrice : -1;
            return true;
          }),
    ),
  );
}

typedef OnTicketDetailsCommit = bool Function(
    String title, int price, bool hasVirtualPrice, int virtualPrice);

class TicketDetailsView extends StatefulWidget {
  final Ticket ticket;
  final OnTicketDetailsCommit onCommit;

  const TicketDetailsView({Key key, this.ticket, this.onCommit})
      : super(key: key);

  @override
  _TicketDetailsViewState createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends State<TicketDetailsView> {
  TextEditingController titleController;
  TextEditingController priceController;
  bool hasVirtualPrice;
  TextEditingController virtualPriceController;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController(text: widget.ticket.title);
    priceController =
        TextEditingController(text: widget.ticket.price.toString());
    hasVirtualPrice = widget.ticket.hasVirtualPrice;
    virtualPriceController = TextEditingController(
        text: hasVirtualPrice ? widget.ticket.virtualPrice.toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket bearbeiten'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputField(
                labelText: 'Ticketname',
                controller: titleController,
              ),
              InputField(
                labelText: 'Preis',
                controller: priceController,
              ),
              CheckboxListTile(
                title: Text('Hat virtuellen Preis'),
                value: hasVirtualPrice,
                onChanged: (bool value) {
                  setState(() {
                    hasVirtualPrice = !hasVirtualPrice;
                  });
                },
              ),
              InputField(
                labelText: 'Virtueller Preis',
                enabled: hasVirtualPrice,
                controller: virtualPriceController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (showFab)
          ? FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                if (widget.onCommit == null ||
                    widget.onCommit(
                      titleController.text,
                      int.tryParse(priceController.text) ?? -1,
                      hasVirtualPrice,
                      int.tryParse(virtualPriceController.text) ?? -1,
                    )) {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    @required this.controller,
    @required this.labelText,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        enabled: enabled,
        controller: controller,
      ),
    );
  }
}
