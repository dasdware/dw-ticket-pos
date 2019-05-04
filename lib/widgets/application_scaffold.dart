import 'package:dw_ticket_pos/widgets/action_button.dart';
import 'package:dw_ticket_pos/widgets/application_theme.dart';
import 'package:dw_ticket_pos/widgets/main_action_button.dart';
import 'package:flutter/material.dart';

class TabViewModel {
  final String hint;
  final IconData icon;

  final Widget body;

  final MainActionViewModel mainAction;

  TabViewModel(
      {@required this.hint,
      @required this.icon,
      @required this.body,
      this.mainAction});
}

class TabsViewModel {
  final List<TabViewModel> tabs;
  final int initialTabIndex;

  TabsViewModel({
    @required this.tabs,
    this.initialTabIndex = 0,
  });
}

class ApplicationScaffoldViewModel {
  final String title;
  final String subtitle;
  final List<ActionViewModel> actions;
  final TabsViewModel tabs;
  final Widget body;
  final MainActionViewModel mainAction;

  ApplicationScaffoldViewModel({
    @required this.title,
    this.subtitle,
    this.actions,
    this.tabs,
    this.body,
    this.mainAction,
  });
}

class ApplicationScaffold extends StatefulWidget {
  final ApplicationScaffoldViewModel viewModel;

  ApplicationScaffold({@required this.viewModel});

  @override
  _ApplicationScaffoldState createState() => _ApplicationScaffoldState();
}

class _ApplicationScaffoldState extends State<ApplicationScaffold>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  ApplicationScaffoldViewModel get viewModel => widget.viewModel;

  @override
  initState() {
    super.initState();
    if (viewModel.tabs != null) {
      _tabController = TabController(
        length: viewModel.tabs.tabs.length,
        vsync: this,
        initialIndex: viewModel.tabs.initialTabIndex,
      );
    } else {
      _tabController = null;
    }
  }

  @override
  void dispose() {
    if (_haveTabs) {
      _tabController.dispose();
    }
    super.dispose();
  }

  get _haveTabs => _tabController != null;

  get _haveMainActionButtonPerTab {
    if (!_haveTabs) {
      return false;
    }

    for (TabViewModel tab in viewModel.tabs.tabs) {
      if (tab.mainAction == null) {
        return false;
      }
    }

    return true;
  }

  Widget _buildTitle(BuildContext context) {
    Text title = Text(
      viewModel.title,
      style: ApplicationTheme.of(context).titleTextStyle,
    );

    if (viewModel.subtitle != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title,
          Text(viewModel.subtitle,
              style: ApplicationTheme.of(context).subtitleTextStyle)
        ],
      );
    } else {
      return title;
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    if (viewModel.actions == null || viewModel.actions.length == 0) {
      return null;
    }

    return viewModel.actions
        .map((action) => ActionButton(viewModel: action))
        .toList();
  }

  Widget _buildAppBarBottom(BuildContext context) {
    if (_haveTabs) {
      final ApplicationTheme theme = ApplicationTheme.of(context);
      return TabBar(
        controller: _tabController,
        indicatorColor: theme.primaryColor,
        labelColor: theme.primaryColor,
        unselectedLabelColor: theme.primaryDimmedColor,
        tabs: viewModel.tabs.tabs
            .map((tab) => Tab(
                  icon: Icon(tab.icon),
                ))
            .toList(),
      );
    } else {
      return null;
    }
  }

  Widget _buildBody(BuildContext context) {
    if (_haveTabs) {
      return TabBarView(
        controller: _tabController,
        children: viewModel.tabs.tabs.map((tab) => tab.body).toList(),
      );
    } else {
      return viewModel.body;
    }
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      return null;
    } else if (_haveMainActionButtonPerTab) {
      return MainActionButtons(
        tabController: _tabController,
        viewModels: viewModel.tabs.tabs.map((tab) => tab.mainAction).toList(),
      );
    } else if (viewModel.mainAction != null) {
      return MainActionButton(
        viewModel: viewModel.mainAction,
      );
    } else {
      return null;
    }
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = ApplicationTheme.of(context);
    final navigator = Navigator.of(context);

    return AppBar(
      backgroundColor: theme.primaryBackgroundColor,
      elevation: 0,
      leading: (navigator.canPop())
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.primaryColor,
              ),
              onPressed: () => navigator.pop(),
            )
          : null,
      title: _buildTitle(context),
      actions: _buildActions(context),
      bottom: _buildAppBarBottom(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationTheme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}
