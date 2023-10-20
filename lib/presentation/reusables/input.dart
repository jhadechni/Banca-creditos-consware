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
  final String regex;
  final Color backgroundColor;
  final Color internalTextColor;
  final TextEditingController controller;
  final Function(String)? customValidator;
  final Function(String)? onChanged;

  const CustomInput({
    Key? key,
    required this.placeholder,
    this.icon,
    required this.width,
    required this.height,
    required this.controller,
    this.regex = '',
    this.labelText = '',
    this.textColor = const Color.fromRGBO(128, 138, 147, 1),
    this.fontSize = 14,
    this.enabled = true,
    this.customValidator,
    this.backgroundColor = Colors.white,
    this.internalTextColor = const Color.fromRGBO(177, 181, 187, 1),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
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
            ),
          ),
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
                        backgroundColor: backgroundColor,
                      ),
                      decoration: InputDecoration(
                        hintText: placeholder,
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.redAccent.shade700,
                          fontSize: 0,
                        ),
                      ),
                      onEditingComplete: () {
                        // Mantener el foco después de completar la edición
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (value) {
                        if (onChanged != null) {
                          onChanged!(value);

                          // Actualizar el valor del campo de texto
                          controller.text = value;

                          // Manejar el cambio de salario y mantener el foco
                          _focusNode.requestFocus();
                        }
                      },
                      validator: (t) {
                        if (t!.isEmpty && customValidator == null) {
                          Get.snackbar(
                            'Info',
                            'El campo ${placeholder.toLowerCase()} es obligatorio',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Palette.kGray,
                            colorText: Colors.black,
                          );
                          return '';
                        } else if (customValidator != null) {
                          return customValidator!(t);
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
