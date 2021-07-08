import 'package:flutter/material.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;

  const AppBarCommon({required this.title, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Color(0xFF2a9d8f),
      elevation: 0.0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
