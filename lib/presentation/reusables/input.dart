import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';

class CustomInput extends StatelessWidget {
  final String placeholder;
  final IconData? icon;
  final double width;
  final double height;
  final String labelText;
  final Color textColor;
  final double fontSize;
  final bool enabled;
  final Color backgroundColor;
  final Color internalTextColor;
  final TextEditingController controller;

  const CustomInput(
      {super.key,
      required this.placeholder,
      this.icon,
      required this.width,
      required this.height,
      required this.controller,
      this.labelText = '',
      this.textColor = const Color.fromRGBO(128, 138, 147, 1),
      this.fontSize = 14,
      this.enabled = true,
      this.backgroundColor = Colors.white,
      this.internalTextColor = const Color.fromRGBO(177, 181, 187, 1)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: labelText != ''
                  ? const EdgeInsets.only(bottom: 14)
                  : const EdgeInsets.only(bottom: 0),
              child: Text(
                labelText,
                textAlign: TextAlign.left,
                style: TextStyle(color: textColor, fontSize: fontSize),
              )),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC8D0D9), width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: Palette.kGray,
                    ),
                    const SizedBox(width: 8.0),
                  ],
                  Expanded(
                    child: TextFormField(
                      enabled: enabled,
                      controller: controller,
                      obscureText: placeholder == 'Password' ? true : false,
                      style: TextStyle(
                          color: internalTextColor,
                          fontSize: 14,
                          backgroundColor: backgroundColor),
                      decoration: InputDecoration(
                        hintText: placeholder,
                        border: InputBorder.none,
                      ),
                      validator: (t) {
                        if (t!.isEmpty) {
                          Get.snackbar('Info',
                              'El campo ${placeholder.toLowerCase()} es obligatorio',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Palette.kPrimaryColor,
                              colorText: Colors.white);
                          return null;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
