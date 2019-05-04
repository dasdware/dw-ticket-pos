import 'package:dw_ticket_pos/widgets/application_theme.dart';
import 'package:flutter/material.dart';

class ActionViewModel {
  final IconData icon;
  final String hint;
  final VoidCallback onPressed;

  ActionViewModel({
    @required this.icon,
    @required this.hint,
    @required this.onPressed,
  });
}

class ActionButton extends StatelessWidget {
  final ActionViewModel viewModel;

  const ActionButton({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(viewModel.icon),
      color: ApplicationTheme.of(context).primaryColor,
      tooltip: viewModel.hint,
      onPressed: viewModel.onPressed,
    );
  }
}
