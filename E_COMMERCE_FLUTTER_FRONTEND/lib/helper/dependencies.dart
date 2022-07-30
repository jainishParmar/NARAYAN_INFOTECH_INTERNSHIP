
import 'package:get/get.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/controller/user_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';

import 'package:intern_final/data/api/api_client.dart';
import 'package:intern_final/data/repositary/auth_repo.dart';
import 'package:intern_final/data/repositary/cart_repo.dart';
import 'package:intern_final/data/repositary/inventory_popular_repo.dart';
import 'package:intern_final/data/repositary/inventory_recommended_repo.dart';
import 'package:intern_final/data/repositary/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: Appconstants.BASE_URL,sharedPreferences:Get.find()));


  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => InventoryPopularRepo(apiClient: Get.find()));
  Get.lazyPut(() => InventoryRecommendedRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find(),apiClient:Get.find()));











  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => InventoryPopularController(inventoryPopularRepo: Get.find()));
  Get.lazyPut(() => InventoryRecommendedController(inventoryRecommendedRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));




}
