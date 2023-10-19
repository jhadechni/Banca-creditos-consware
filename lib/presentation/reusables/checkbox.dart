import 'package:flutter/material.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';

class CustomCheckbox extends StatefulWidget {
  final Widget customWidget;
  final Function(bool)? onChanged;
  final bool initialValue;

  const CustomCheckbox({super.key, 
    required this.customWidget,
    this.onChanged,
    this.initialValue = false,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isChecked = !_isChecked;
                widget.onChanged?.call(_isChecked);
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: const Color.fromRGBO(208, 213, 221, 1),
                  width: 2.0,
                ),
                color: _isChecked ? Palette.kPrimaryColor : Colors.transparent,
              ),
              child: _isChecked
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 8.0),
          widget.customWidget,
        ],
      ),
    );
  }
}

