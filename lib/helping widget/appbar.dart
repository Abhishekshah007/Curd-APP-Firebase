import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const MyAppBar({Key? key, required this.title, this.height = kToolbarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title,style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
