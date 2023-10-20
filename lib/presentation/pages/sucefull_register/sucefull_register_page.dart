import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_binding.dart';
import 'package:prueba_tecnica_consware/presentation/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';

class SplashRegister extends StatelessWidget {
  const SplashRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(image: AssetImage('assets/images/elipse.png')),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 150,
                  height: 150,
                  child: Image(
                      image: AssetImage('assets/images/registro_exitoso.png')),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Registro Exitoso',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Text(
                      'Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante.',
                      style: TextStyle(fontSize: 16, color: Color(0xff91A1B2)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: CustomButton(
                      text: 'Continuar',
                      color: Palette.kPrimaryColor,
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      onPressed: () => {
                        Get.offAll(() => const NavBar()),
                        UserBinding().dependencies()
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
