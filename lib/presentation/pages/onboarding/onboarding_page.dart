import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/app/util/textos.dart';
import 'package:prueba_tecnica_consware/presentation/reusables/button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: 2,
            onPageChanged: (index) {
              setState(() {});
            },
            itemBuilder: (context, index) {
              return OnboardingContent(
                controller: _pageController,
                image: 'assets/images/onboarding${index + 1}.png',
                textKey: 'texto${index + 1}',
              );
            },
          ),
        ),
      ],
    ));
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.image,
    required this.textKey,
    required this.controller,
  }) : super(key: key);

  final String image, textKey;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(image),
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF0E111D),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: SmoothPageIndicator(
              controller: controller,
              count: 2,
              effect: WormEffect(
                dotWidth: MediaQuery.of(context).size.width * 0.43,
                dotHeight: 5,
                dotColor: Colors.grey,
                activeDotColor: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.0, // Ajusta según sea necesario
          left: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Textos.onboarding[textKey]!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 33),
                child: CustomButton(
                    text: 'Ingresar',
                    color: Colors.white,
                    textColor: Colors.black,
                    width: 358,
                    height: 50,
                    onPressed: () => {Get.toNamed('/home')}),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomButton(
                    text: 'Registrarme',
                    color: Palette.kPrimaryColor,
                    textColor: Colors.white,
                    width: 358,
                    height: 50,
                    onPressed: () => {Get.toNamed('/register')}),
              )
            ],
          ),
        ),
      ],
    );
  }
}
