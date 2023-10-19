import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/checkbox.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    User user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Stack(children: [
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
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Image(image: AssetImage('assets/images/banklogo.png')),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 28, bottom: 49),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: 'Inicia sesión o continua,',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ProductSans',
                              ),
                            ),
                            TextSpan(
                              text: ' solo te tomará unos minutos.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'ProductSans'),
                            ),
                          ])),
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInput(
                        placeholder: 'Uname@mail.com',
                        controller: _email,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                        labelText: 'Email or Usuario',
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
                      const Padding(
                        padding:
                            EdgeInsets.only(right: 30, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomCheckbox(customWidget: Text('Recordarme')),
                            Text('¿Olvide mi contraseña?',
                                style: TextStyle(
                                    color: Palette.kPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'ProductSans'))
                          ],
                        ),
                      ),
                      CustomButton(
                          text: 'Iniciar sesión',
                          color: Palette.kPrimaryColor,
                          textColor: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.92,
                          height: 50,
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    user = User(
                                        id: 1,
                                        name: 'Juan Perez',
                                        email: _email.text,
                                        password: _password.text),
                                    logDebug(user.toJson().toString()),
                                  }
                              })
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Color.fromRGBO(200, 208, 217, 1),
                        )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 34),
                          child: Text("o",
                              style: TextStyle(
                                  color: Color.fromRGBO(160, 167, 174, 1),
                                  fontSize: 18,
                                  fontFamily: 'ProductSans')),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Color.fromRGBO(200, 208, 217, 1),
                        )),
                      ]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => {logDebug('Google')},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 17,
                            height: 17,
                            child: Image(
                                image: AssetImage('assets/images/google.png'))),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Ingresa con Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => {logDebug('apple')},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 17,
                              height: 17,
                              child: Image(
                                  image:
                                      AssetImage('assets/images/apple.png'))),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Ingresa con Apple',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes cuenta? ',
                        style: TextStyle(
                            color: Color.fromRGBO(128, 138, 147, 1),
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      GestureDetector(
                        onTap: () => {Get.toNamed('/register')},
                        child: const Text('Regístrate',
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
          )
        ]),
      ),
    );
  }
}
