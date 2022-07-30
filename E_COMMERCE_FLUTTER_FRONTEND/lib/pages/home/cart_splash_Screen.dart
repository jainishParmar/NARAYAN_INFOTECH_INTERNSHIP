import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';

import 'package:intern_final/utils/dimension.dart';

class CartSplashScreen extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  const CartSplashScreen({Key? key, required this.email, required this.name, required this.phone}) : super(key: key);

  @override
  State<CartSplashScreen> createState() => _CartSplashScreenState();
}

class _CartSplashScreenState extends State<CartSplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadCart() async {
    await Get.find<CartController>().getCartList(widget.email);
    await Get.find<CartController>().getCartTotalAmount(widget.email);
    await Get.find<InventoryPopularController>().getAllItems();



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
    Timer(const Duration(seconds: 3),
            () => Get.toNamed(RouteHelper.getCartPage(widget.email,widget.name,widget.phone)));
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
                        CustomLoader(),

                      ],
                    )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
