import 'package:flutter/material.dart';

class ApplicationTheme extends InheritedWidget {

  final Color primaryColor;
  get primaryBackgroundColor => primaryColor.withOpacity(0.075);
  get primaryDimmedColor => primaryColor.withOpacity(0.6);

  final Color backgroundColor;

  const ApplicationTheme({
    Key key,
    @required this.primaryColor,
    @required this.backgroundColor,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ApplicationTheme oldWidget) =>
      primaryColor != oldWidget.primaryColor;

  static ApplicationTheme of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ApplicationTheme);
}
