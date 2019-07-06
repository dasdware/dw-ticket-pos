import 'package:dw_ticket_pos/model/storage.dart';
import 'package:dw_ticket_pos/model/ticket.dart';
import 'package:dw_ticket_pos/utils/localization.dart';
import 'package:dw_ticket_pos/widgets/application_scaffold.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';

void editTicket(BuildContext context, Ticket ticket) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TicketDetailsView(
          viewTitle: AppLocalizations.of(context).editTicket,
          ticketTitle: ticket.title,
          price: ticket.price,
          virtualPrice: ticket.virtualPrice,
          commitButtonTitle: AppLocalizations.of(context).editTicketCommit,
          commitButtonHint: AppLocalizations.of(context).editTicketCommitHint,
          onCommit: (String title, int price, bool hasVirtualPrice,
              int virtualPrice) {
            ticket.update(title, price, hasVirtualPrice ? virtualPrice : -1);
            return true;
          }),
    ),
  );
}

void addTicket(BuildContext context, Storage storage) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TicketDetailsView(
          viewTitle: AppLocalizations.of(context).createTicket,
          ticketTitle: '',
          price: 1000,
          virtualPrice: -1,
          commitButtonTitle: AppLocalizations.of(context).createTicketCommit,
          commitButtonHint: AppLocalizations.of(context).createTicketCommitHint,
          onCommit: (String title, int price, bool hasVirtualPrice,
              int virtualPrice) {
            storage.addTicket(
                title, price, hasVirtualPrice ? virtualPrice : -1);
            return true;
          }),
    ),
  );
}

typedef OnTicketDetailsCommit = bool Function(
    String title, int price, bool hasVirtualPrice, int virtualPrice);

class TicketDetailsView extends StatefulWidget {
  final String viewTitle;
  final String ticketTitle;
  final int price;
  final int virtualPrice;
  final String commitButtonTitle;
  final String commitButtonHint;
  final OnTicketDetailsCommit onCommit;

  const TicketDetailsView(
      {Key key,
      this.viewTitle,
      this.ticketTitle,
      this.price,
      this.virtualPrice,
      this.commitButtonTitle,
      this.commitButtonHint,
      this.onCommit})
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
    titleController = TextEditingController(text: widget.ticketTitle);
    priceController = TextEditingController(text: widget.price.toString());
    hasVirtualPrice = (widget.virtualPrice > -1);
    virtualPriceController = TextEditingController(
        text: hasVirtualPrice ? widget.virtualPrice.toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
        viewModel: ApplicationScaffoldViewModel(
      title: widget.viewTitle,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              InputField(
                labelText: AppLocalizations.of(context).ticketTitle,
                controller: titleController,
              ),
              InputField(
                labelText: AppLocalizations.of(context).ticketPrice,
                controller: priceController,
              ),
              CheckboxListTile(
                title: Text(AppLocalizations.of(context).ticketHasVirtualPrice),
                value: hasVirtualPrice,
                onChanged: (bool value) {
                  setState(() {
                    hasVirtualPrice = !hasVirtualPrice;
                  });
                },
              ),
              InputField(
                labelText: AppLocalizations.of(context).ticketVirtualPrice,
                enabled: hasVirtualPrice,
                controller: virtualPriceController,
              ),
            ],
          ),
        ),
      ),
      mainAction: MainActionViewModel(
        title: widget.commitButtonTitle,
        hint: widget.commitButtonHint,
        icon: Icons.check,
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
      ),
    ));
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
        decoration: InputDecoration(
          labelText: labelText,
        ),
        enabled: enabled,
        controller: controller,
      ),
    );
  }
}
