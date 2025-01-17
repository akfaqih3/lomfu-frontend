import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/themes/app_theme_controller.dart';

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
    final _appThemeController = Get.find<AppThemeController>();

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title != null
              ? title!
              : Text(
                  "lomfu",
                  style: Get.textTheme.titleLarge!.copyWith(
                    color: AppColors.white,
                  ),
                ),
          if (icon != null) icon!,
          InkWell(
            child: Icon(
              Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.white,
            ),
            onTap: () {
              _appThemeController.toggleMode();
            },
          )
        ],
      ),
      bottom: bottom,
      elevation: 0,
    );
  }
}
