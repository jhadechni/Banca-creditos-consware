import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> rowNames;
  final List<List<String>> data;
  final List<Color?> columnTextColors;

  const CustomTable({
    Key? key,
    required this.rowNames,
    required this.data,
    required this.columnTextColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        horizontalInside: BorderSide(
          color: Color.fromARGB(255, 211, 214, 216),
          width: 1,
        ),
        verticalInside: BorderSide(
          color: Color.fromARGB(255, 211, 214, 216),
          width: 1,
        ),
        bottom: BorderSide(
          color: Color.fromARGB(255, 211, 214, 216),
          width: 1,
        ),
      ),
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white,
                width: 0,
              ),
            ),
          ),
          children: rowNames
              .map((name) => TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
              .toList(),
        ),
        for (int i = 0; i < data.length; i++)
          TableRow(
            children: data[i]
                .asMap()
                .entries
                .map((entry) => TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: columnTextColors[entry.key],
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
