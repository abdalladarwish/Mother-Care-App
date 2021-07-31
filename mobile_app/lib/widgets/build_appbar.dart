import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, title, {double elevation = 0, List<Widget>? actions}) {
  final theme = Theme.of(context);
  final nav = Navigator.of(context).canPop();
  return AppBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    elevation: elevation,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xff364861)),
    ),
    centerTitle: true,
    leading: nav?IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: theme.primaryColor,
        size: 20,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ): null,
    actions: actions,
  );
}
