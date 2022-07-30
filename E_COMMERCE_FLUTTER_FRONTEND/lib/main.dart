import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<InventoryPopularController>(builder: (_) {
        return GetBuilder<InventoryRecommendedController>(builder: (_) {
          return GetBuilder<CartController>(builder: (_){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,

            );
          });

        });
      });
    });
  }
}
