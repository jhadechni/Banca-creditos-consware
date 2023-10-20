import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/app/util/currency_formatter.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_controller.dart';
import 'package:prueba_tecnica_consware/presentation/pages/cotizacion/cotizacion_page.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/dropbox.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = User(name: '', email: '', password: '', identification: '');
  TextEditingController tipoCredito = TextEditingController();
  TextEditingController salario = TextEditingController();
  TextEditingController meses = TextEditingController();
  TextEditingController maxPrestamoCalculado = TextEditingController();

  @override
  initState() {
    super.initState();
    tipoCredito.text = 'Selecciona el tipo de crédito';
    getUserInfo().then((value) => setState(() {
          user = value;
        }));

    salario.addListener(() {
      if (salario.text.isNotEmpty) {
        try {
          double credito =
              ((int.parse(salario.text) * 7) / 0.15).roundToDouble();
          maxPrestamoCalculado.text =
              Formatter.formatNumberCOP(credito.toString());
        } catch (e) {
          salario.text = '';
        }
      } else {
        maxPrestamoCalculado.text = '\$0';
      }
    });
  }

  Future<User> getUserInfo() async {
    UserController userController = Get.find<UserController>();
    String email = await userController.getLocalEmail;
    User user = await userController.getUser(email);

    return user;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Credito credito;
    double interestRate;
    String monto;

    double calcularTEA(double tasaMensual) {
      return double.parse(
          ((pow(1 + tasaMensual, 12) - 1) * 100).toStringAsPrecision(4));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 33),
              child: Row(
                children: [
                  Text(
                    'Hola ${user.name}.  👋',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_on_outlined),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Simulador de crédito',
                    style: TextStyle(
                        fontSize: 25,
                        color: Palette.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: () async => {
                        if (formKey.currentState!.validate())
                          {
                            interestRate =
                                tipoCredito.text == 'Crédito de vehículo'
                                    ? 0.03
                                    : tipoCredito.text == 'Crédito de vivienda'
                                        ? 0.01
                                        : 0.035,
                            monto = ((double.parse(Formatter.unFormatNumberCOP(maxPrestamoCalculado.text) ) *
                                        interestRate) /
                                    (1 -
                                        pow(1 + interestRate,
                                            -int.parse(meses.text))))
                                .toString(),
                            credito = Credito(
                              tipoCredito: tipoCredito.text,
                              anualInterest: calcularTEA(interestRate),
                              term: int.parse(meses.text),
                              salarioBase: salario.text,
                              maximoPrestamo: maxPrestamoCalculado.text,
                              cuotaCredito:
                                  Formatter.formatNumberCOP(monto.toString()),
                              idUsuario: user.id.toString(),
                            ),
                            logDebug('Credito: ${credito.toJson()}'),
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => CustomModal(
                                  maxLoan: credito.cuotaCredito,
                                  anualInterestRate: calcularTEA(interestRate),
                                  monthlyInterestRate: double.parse(
                                      (interestRate * 100).toStringAsFixed(2)),
                                  totalValue: credito.maximoPrestamo,
                                  monthlyFee: (double.parse(
                                          Formatter.unFormatNumberCOP(
                                              credito.cuotaCredito)) *
                                      int.parse(meses.text))),
                            )
                          },
                      },
                      icon: const Icon(Icons.info_outline),
                      color: Palette.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Ingresa los datos para tu crédito según lo que necesites.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomDropdown(
                    items: const [
                      'Crédito de vehículo',
                      'Crédito de vivienda',
                      'Crédito de libre inversión'
                    ],
                    placeholder: 'Selecciona el tipo de crédito',
                    hintText: tipoCredito.text,
                    width: MediaQuery.of(context).size.width * 0.84,
                    label: '¿Qué tipo de créditos deseas realizar?',
                    onChanged: (value) => {
                      setState(() {
                        tipoCredito.text = value;
                      })
                    },
                  ),
                  Column(
                    children: [
                      CustomInput(
                        placeholder: '\$1´000.000,00',
                        controller: salario,
                        width: MediaQuery.of(context).size.width * 0.87,
                        height: 40,
                        labelText: '¿Cúal es tu salario base?',
                        textColor: Colors.black,
                        customValidator: (value) {
                          if (value.isEmpty) {
                            Get.snackbar(
                              'Info',
                              'Debe ingresar su salario base',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Palette.kGray,
                              colorText: Colors.black,
                            );
                            return 'Este campo es obligatorio';
                          } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                            Get.snackbar(
                              'Info',
                              'Ingrese solo números',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Palette.kGray,
                              colorText: Colors.black,
                            );
                          }
                        },
                        fontSize: 14,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Digíta tu salario para calcular el préstamo que necesitas',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF525B64)),
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomInput(
                    placeholder: '\$0',
                    controller: maxPrestamoCalculado,
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: 40,
                    enabled: false,
                    customValidator: (value) {
                      if (value.isEmpty) {
                        return null;
                      }
                      return null;
                    },
                    backgroundColor: const Color(0xFFE0E0E0),
                  ),
                  Column(
                    children: [
                      CustomInput(
                        placeholder: '48',
                        controller: meses,
                        width: MediaQuery.of(context).size.width * 0.87,
                        height: 40,
                        labelText: '¿A cuántos meses?',
                        textColor: Colors.black,
                        fontSize: 14,
                        customValidator: (value) {
                          if (value.isEmpty) {
                            Get.snackbar(
                              'Info',
                              'Debe ingresar un plazo',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Palette.kGray,
                              colorText: Colors.black,
                            );
                            return 'Este campo es obligatorio';
                          } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                            Get.snackbar(
                              'Info',
                              'Ingrese solo números',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Palette.kGray,
                              colorText: Colors.black,
                            );
                          } else if (int.parse(value) < 12 ||
                              int.parse(value) > 84) {
                            Get.snackbar(
                              'Info',
                              'El plazo debe ser entre 12 y 84 meses',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Palette.kGray,
                              colorText: Colors.black,
                            );
                            return 'El plazo debe ser entre 12 y 84 meses';
                          }

                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Elige un plazo desde 12 hata 84 meses',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF525B64)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: CustomButton(
                  text: 'Simular',
                  color: Palette.kPrimaryColor,
                  textColor: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 40,
                  onPressed: () => {
                        if (formKey.currentState!.validate())
                          {
                            interestRate =
                                tipoCredito.text == 'Crédito de vehículo'
                                    ? 0.03
                                    : tipoCredito.text == 'Crédito de vivienda'
                                        ? 0.01
                                        : 0.035,
                            monto = ((double.parse(Formatter.unFormatNumberCOP(
                                            maxPrestamoCalculado.text)) *
                                        interestRate) /
                                    (1 -
                                        pow(1 + interestRate,
                                            -int.parse(meses.text))))
                                .toString(),
                            credito = Credito(
                              tipoCredito: tipoCredito.text,
                              anualInterest: calcularTEA(interestRate),
                              term: int.parse(meses.text),
                              salarioBase: salario.text,
                              maximoPrestamo: maxPrestamoCalculado.text,
                              cuotaCredito:
                                  Formatter.formatNumberCOP(monto.toString()),
                              idUsuario: user.id.toString(),
                            ),
                            Get.to(() =>
                                CotizacionPage(credito: credito, user: user)),
                            logDebug('Credito: ${credito.toJson()}'),
                          }
                      }),
            )
          ],
        ),
      ),
    );
  }
}

class CustomModal extends StatelessWidget {
  final String maxLoan;
  final double anualInterestRate;
  final double monthlyInterestRate;
  final String totalValue;
  final double monthlyFee;

  const CustomModal({
    Key? key,
    required this.maxLoan,
    required this.anualInterestRate,
    required this.monthlyInterestRate,
    required this.totalValue,
    required this.monthlyFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuota máxima del préstamo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maxLoan,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: const Text(
                          '*Este valor suele cambiar con respecto a tu salario',
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black,
                      ),
                      onPressed: () {
                        // Close the modal
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Palette.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ModalItems(
              text1: 'Tasa Efectiva Anual desde',
              text2: '$anualInterestRate%',
            ),
            ModalItems(
              text1: 'Tasa Mensual Vencida desde',
              text2: '$monthlyInterestRate%',
            ),
            ModalItems(
              text1: 'Valor total del préstamo',
              text2: totalValue,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      'Valor total a pagar (capital + intereses + seguro)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(Formatter.formatNumberCOP(monthlyFee.toString()),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ModalItems extends StatelessWidget {
  final String text1;
  final String text2;

  const ModalItems({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 18, color: Color(0xFF525B64)),
          ),
          Text(text2,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
