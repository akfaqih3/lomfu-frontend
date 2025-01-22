import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/themes/theme_service.dart';
import 'package:lomfu_app/home.dart';

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
          Row(
            children: [
              InkWell(
                child: Icon(
                  Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: AppColors.white,
                ),
                onTap: () {
                  AppTheme.toggleMode();
                },
              ),
              
              InkWell(
                child: DropdownButton(
                  icon: const Icon(Icons.language, color: AppColors.white),
                  underline: const SizedBox(),
                  onChanged: (String? value) {
                    AppLanguage.changeLanguage(value!);
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(lblEnglishLang.tr),
                      value: AppLanguage.enKey,
                    ),
                    DropdownMenuItem(
                      child: Text(lblArabicLang.tr),
                      value: AppLanguage.arKey,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      bottom: bottom,
      elevation: 0,
    );
  }
}
