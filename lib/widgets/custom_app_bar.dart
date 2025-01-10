import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? height;
  final Icon? icon;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.title,
    this.height,
    this.icon,
    this.bottom,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          title != null ? title! : Text("lomfu"),
          if (icon != null) icon!,
        ],
      ),
      bottom: bottom,
      elevation: 0,
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
    );
  }
}
