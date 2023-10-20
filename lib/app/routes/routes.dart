import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/presentation/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/login/login_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/register/register_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/sucefull_register/sucefull_register_page.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/loader.dart';


appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/register',
        page: () => const RegisterPage(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/register-sucefull',
        page: () => const SplashRegister(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/home',
        page: () => const NavBar(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/loader',
        page: () => const Loader(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
     
    ];
