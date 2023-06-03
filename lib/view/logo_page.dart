import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/logo_controller.dart';

class LogoScreen extends StatelessWidget {
  final LogoController _logoController = Get.put(LogoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Kapiva Animation',
              textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 10,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _logoController.toggleAnimation();
          },
          onDoubleTap: () {
            _logoController.toggleVisibility();
          },
          onLongPress: () {
            _logoController.startBounceAnimation();
          },
          child: GetBuilder<LogoController>(
            init: _logoController,
            builder: (_) {
              if (_logoController.isLogoVisible) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _logoController.animationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _logoController.rotation.value * 2 * 3.1415,
                            child: Transform.translate(
                              offset: _logoController.isBouncing
                                  ? _logoController.positionAnimation.value
                                  : Offset.zero,
                              child: Image.asset(
                                'assets/logo.png',
                                width: 300.0,
                                height: 250.0,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Obx(
                        () => Slider(
                          value: _logoController.speed.value,
                          min: 0.2,
                          max: 2.0,
                          activeColor: Colors.green,
                          inactiveColor: Colors.black,
                          onChanged: (value) {
                            _logoController.changeSpeed(value);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Why Kapiva?',
                      style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'HEALTHY INSIDE, HAPPY OUTSIDE',
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Image.asset(
                      'assets/logo2.png',
                      width: 350.0,

                      // height: 300.0,
                    ),
                    // Image.asset(
                    //   'assets/logo3.png',
                    //   fit: BoxFit.cover,
                    //
                    // ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
