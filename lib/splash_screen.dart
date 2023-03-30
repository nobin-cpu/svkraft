import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'Features/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (() {
      Get.to(HomeScreen());
    }));
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Image.asset(
        "images/sss.png",
        width: double.infinity,
        fit: BoxFit.cover,
      )),
    );
  }
}
