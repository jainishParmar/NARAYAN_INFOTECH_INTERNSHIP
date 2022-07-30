import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/utils/dimension.dart';

class LogOutSplashScreen extends StatefulWidget {
  const LogOutSplashScreen({Key? key}) : super(key: key);

  @override
  State<LogOutSplashScreen> createState() => _LogOutSplashScreenState();
}

class _LogOutSplashScreenState extends State<LogOutSplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;


  @override
  void initState() {
    super.initState();


    controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
    Timer(const Duration(seconds: 3),
            () => Get.toNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Column(
              children: [
                Center(
                  child: Text("Logging Out ",style: TextStyle(fontSize: Dimensions.font16*2,color: Colors.pink),)
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
