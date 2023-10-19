import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.3,
          horizontal: MediaQuery.of(context).size.width * 0.3),
      child: Column(
        children: [
          LoadingAnimationWidget.threeArchedCircle(
            color: Palette.kPrimaryColor,
            size: 120,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 22),
            child: Text('Simulando crédito',
                style: TextStyle(
                    fontSize: 16,
                    color: Palette.kPrimaryColor,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    ));
  }
}
