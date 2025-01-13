import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Get.textTheme.labelLarge,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        prefixIcon: Icon(prefixIcon ?? null),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        
      ),
      
    );
  }
}
