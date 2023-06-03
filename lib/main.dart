import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logo_animation/view/logo_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logo Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogoScreen(),
    );
  }
}