import 'package:flutter/material.dart';

class PAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const PAppbar({
    Key? key,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: const TextStyle(
            color: Colors.black,
          )),
      centerTitle: true,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
