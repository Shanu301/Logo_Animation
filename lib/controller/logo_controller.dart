import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> rotation;
  late Animation<Offset> positionAnimation;
  RxDouble speed = 1.0.obs;
  bool isAnimating = false;
  bool isLogoVisible = true;
  bool isBouncing = false;
  double currentRotation = 0.0;
  double startRotation = 0.0;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
        // reverseCurve: Curves.linear,
      ),
    );

    final double screenWidth = Get.width;
    final double screenHeight = Get.height;

    positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(screenWidth - 200.0, screenHeight - 200.0),
    )
        .chain(
          CurveTween(curve: Curves.easeInQuad),
        )
        .animate(animationController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isBouncing = false;
      }
    });
  }

  void startBounceAnimation() {
    isBouncing = true;
    animationController.reset();
    animationController.forward();
  }

  void toggleAnimation() {
    if (isAnimating) {
      animationController.animateTo(
        1,
        duration: Duration(seconds: 4),
        curve: Curves.decelerate,
      );
      // animationController.stop();
      isAnimating = false;
    } else {
      animationController.repeat();
      isAnimating = true;
    }
  }

  void toggleVisibility() {
    if (isLogoVisible) {
      animationController.stop();
      isLogoVisible = false;
      update();
      Future.delayed(const Duration(seconds: 7), () {
        isLogoVisible = true;
        update();
      });
    }
  }

  void changeSpeed(double value) {
    speed.value = value;
    animationController.duration = Duration(
      milliseconds: (1000 / speed.value).round(),
    );

    if (isAnimating) {
      animationController.repeat();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
