import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/auth/auth_controller.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/checkbox.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _identification = TextEditingController();
    TextEditingController _name = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    AuthController authController = Get.find<AuthController>();
    bool register = false;
    User user;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0.8,
            left: MediaQuery.of(context).size.width * 0.49,
            child: Image(
              image: const AssetImage('assets/images/spinbg.png'),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.6,
            child: Image(
              image: const AssetImage('assets/images/bg2.png'),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child:
                        Image(image: AssetImage('assets/images/banklogo.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28),
                    child: Text(
                      'Regístrate',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 26),
                    child: Text(
                      'Solo te tomará unos minutos.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(145, 160, 178, 1),
                          fontSize: 16),
                    ),
                  ),
                ],
              )),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      placeholder: 'Escribe tu nombre',
                      controller: _name,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      labelText: 'Nombre completo',
                      icon: Icons.person_outline_sharp,
                    ),
                    CustomInput(
                      placeholder: 'Escribe tu número de identificación',
                      controller: _identification,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      labelText: 'Identificación',
                    ),
                    CustomInput(
                      placeholder: 'Uname@mail.com',
                      controller: _email,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      labelText: 'Email',
                      icon: Icons.person_outline_sharp,
                    ),
                    CustomInput(
                      placeholder: 'Password',
                      controller: _password,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      labelText: 'Contraseña',
                      icon: Icons.lock_outlined,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: CustomCheckbox(
                        customWidget: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: RichText(
                                text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Acepto los ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: 'Terminos',
                                  style: TextStyle(
                                      color: Palette.kPrimaryColor,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: ' y ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: 'Condiciones',
                                  style: TextStyle(
                                      color: Palette.kPrimaryColor,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: ' y la ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: 'Política de privacidad',
                                  style: TextStyle(
                                      color: Palette.kPrimaryColor,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                                TextSpan(
                                  text: ' de Banca Creditos.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'ProductSans'),
                                ),
                              ],
                            ))),
                        onChanged: (value) => {},
                      ),
                    ),
                    CustomButton(
                        text: 'Continuar',
                        color: Palette.kPrimaryColor,
                        textColor: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 50,
                        onPressed: () async => {
                              if (_formKey.currentState!.validate())
                                {
                                  user = User(
                                      name: _name.text,
                                      identification: _identification.text,
                                      email: _email.text,
                                      password: _password.text),
                                  print(user.toJson()),
                                  register = await authController.signUp(user),
                                  register
                                      ? Get.offNamed('/register-sucefull')
                                      : null
                                }
                            }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes una cuenta? ',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 138, 147, 1),
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    GestureDetector(
                      onTap: () => {Get.toNamed('/login')},
                      child: const Text('Inicia sesión',
                          style: TextStyle(
                            color: Palette.kPrimaryColor,
                            fontSize: 14,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
