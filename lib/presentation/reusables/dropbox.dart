import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class CustomDropdown extends StatefulWidget {
  final String? selectedValue;
  final List<String> items;
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final double width;
  final double height;
  final String? label;
  final String? hintText;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.placeholder,
      this.selectedValue,
      this.hintText,
      this.onChanged,
      this.width = 200.0,
      this.height = 40.0,
      this.label});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              widget.label!,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: const Color(0xFFC8D0D9), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: widget.selectedValue ,
                      hint: Text(widget.hintText ?? ''),
                      onChanged: (newValue) {
                        setState(() {
                          widget.onChanged?.call(newValue!);
                          logInfo('selected value $newValue');
                        });
                      },
                      items: widget.items.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
