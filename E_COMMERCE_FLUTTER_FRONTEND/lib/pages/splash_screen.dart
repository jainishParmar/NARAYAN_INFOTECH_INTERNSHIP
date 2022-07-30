import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await Get.find<InventoryPopularController>().getPopularProductList();
    await Get.find<InventoryRecommendedController>().getRecommendedProductList();

  }

  @override
  void initState() {
    super.initState();
    _loadResources();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
    Timer(const Duration(seconds: 5),
        () => Get.toNamed(RouteHelper.getInitial()));
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
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
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 350,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
