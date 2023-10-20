import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/routes/routes.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/auth/auth_binding.dart';
import 'package:prueba_tecnica_consware/presentation/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/cotizacion/cotizacion_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/historial/historial_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/home/home_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/login/login_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/onboarding/onboarding_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/register/register_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: AuthBinding(),
      title: 'Banca Creditos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Palette.kPrimaryColor,
          primarySwatch: Colors.indigo,
          fontFamily: 'ProductSans'),
      //home: const NavBar(),
      home: const RegisterPage(),
      getPages: appRoutes(),
    );
  }
}
