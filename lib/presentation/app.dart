import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/routes/routes.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/auth/auth_binding.dart';
import 'package:prueba_tecnica_consware/presentation/controllers/user/user_binding.dart';
import 'package:prueba_tecnica_consware/presentation/pages/home/home_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/login/login_page.dart';

import 'package:prueba_tecnica_consware/presentation/pages/register/register_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: UserBinding(),
      title: 'Banca Creditos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Palette.kPrimaryColor,
          primarySwatch: Colors.indigo,
          fontFamily: 'ProductSans'),
      //home: const NavBar(),
      home: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: const HomePage(),
      ),
      getPages: appRoutes(),
    );
  }
}
