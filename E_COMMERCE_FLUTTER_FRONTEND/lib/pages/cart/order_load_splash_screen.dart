import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/pages/cart/order_page.dart';

import 'package:intern_final/utils/dimension.dart';

import '../../controller/user_controller.dart';

class OrderLoadSplashScreen extends StatefulWidget {

  const OrderLoadSplashScreen(
      {Key? key})
      : super(key: key);

  @override
  State<OrderLoadSplashScreen> createState() => _OrderLoadSplashScreenState();
}

class _OrderLoadSplashScreenState extends State<OrderLoadSplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadCart() async {
    bool _userhasLoggedIn =await  Get.find<AuthController>().userHasLoggedIn();
    if (_userhasLoggedIn) {
      await Get.find<UserController>().getUserInfo();
      await  Get.find<CartController>().getOrderList(Get.find<UserController>().userModel.email);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCart();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
    Timer(
        const Duration(seconds: 3),
        () => Get.to(()=>const CartHistory()));
  }
  @override
  void dispose(){
    super.dispose();
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
                    child: Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                      ),
                    ),

                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
