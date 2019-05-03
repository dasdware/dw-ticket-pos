import 'package:dw_ticket_pos/widgets/application_theme.dart';
import 'package:flutter/material.dart';

class MainActionButtonViewModel {
  final IconData icon;
  final String caption;
  final Color color;
  final VoidCallback onPressed;

  const MainActionButtonViewModel({
    this.icon,
    this.caption = '',
    this.color = Colors.black,
    this.onPressed,
  });
}

class MainActionButton extends StatelessWidget {
  final MainActionButtonViewModel viewModel;

  const MainActionButton({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ApplicationTheme.of(context).primaryButtonBackgroundColor,
        border: Border.all(
          color: viewModel.color,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: viewModel.onPressed,
        borderRadius: BorderRadius.circular(20.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                viewModel.icon,
                color: viewModel.color,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  viewModel.caption,
                  style: TextStyle(
                    color: viewModel.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainActionButtons extends StatefulWidget {
  final TabController tabController;
  final List<MainActionButtonViewModel> viewModels;

  const MainActionButtons({
    Key key,
    @required this.tabController,
    @required this.viewModels,
  }) : super(key: key);

  @override
  _MainActionButtonsState createState() => _MainActionButtonsState();
}

class _MainActionButtonsState extends State<MainActionButtons> {
  @override
  void initState() {
    super.initState();
    widget.tabController.animation.addListener(_update);
  }

  @override
  void dispose() {
    widget.tabController.animation.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabController.index < widget.viewModels.length) {
      final offset = widget.tabController.offset.abs();
      final opacity = (offset < 0.5) ? 1.0 - offset * 2 : (offset - 0.5) * 2.0;
      final index = (widget.tabController.index + widget.tabController.offset).round();

      return Opacity(
        opacity: opacity,
        child: MainActionButton(
          viewModel: widget.viewModels[index],
        ),
      );
    }
    return Container();
  }
}
