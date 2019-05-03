import 'package:flutter/material.dart';

class ApplicationTheme extends InheritedWidget {
  final Color primaryColor;
  get primaryBackgroundColor => primaryColor.withOpacity(0.075);
  get primaryDimmedColor => primaryColor.withOpacity(0.6);
  get primaryButtonBackgroundColor => primaryColor.withOpacity(0.25);

  final Color backgroundColor;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  ApplicationTheme({
    Key key,
    @required this.primaryColor,
    @required this.backgroundColor,
    @required Widget child,
  }) 
  : titleTextStyle = TextStyle(
      color: primaryColor),
    subtitleTextStyle = TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.normal, 
      fontSize: 14),
    super(key: key, child: child);

  @override
  bool updateShouldNotify(ApplicationTheme oldWidget) =>
      primaryColor != oldWidget.primaryColor;

  ThemeData get themeData => ThemeData(
        accentColor: primaryColor,
        primaryColor: primaryColor,
        cursorColor: primaryColor,
        textSelectionColor: primaryColor,
        textSelectionHandleColor: primaryColor,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryDimmedColor,
            ),
          ),
        ),
      );

  static ApplicationTheme of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ApplicationTheme);
}
