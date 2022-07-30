import 'package:get/get.dart';
import 'package:intern_final/pages/auth/forget_password_page.dart';
import 'package:intern_final/pages/auth/login_page.dart';
import 'package:intern_final/pages/auth/register_page.dart';
import 'package:intern_final/pages/cart/cart_delete_splash_screen.dart';
import 'package:intern_final/pages/home/cart_return_page.dart';
import 'package:intern_final/pages/home/cart_splash_Screen.dart';
import 'package:intern_final/pages/home/home_page.dart';
import 'package:intern_final/pages/home/popular_items_details.dart';
import 'package:intern_final/pages/home/recommanded_items_details.dart';
import 'package:intern_final/pages/logout_spalsh_screen.dart';
import 'package:intern_final/pages/cart/cart_page.dart';


import 'package:intern_final/pages/splash_screen.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splashPage = "/splash-page";
  static const String logoutsplashPage = "/logout-splash-page";

  static const String register = "/register-page";
  static const String login = "/login-page";
  static const String forget = "/forget-password-page";


  static const String popularItems = "/popular-items";
  static const String cartPage = "/cart-page";
  static const String CartSplashpage = "/cart-splash-page";
  static const String CartDeleteSplashpage = "/cart-delete-splash-page";



  static const String recommendedItems = "/recommended-items";
  static const String cartReturn = "/cart-return";



  static String getInitial() => '$initial';
  static String getSplashPage() => '$splashPage';
  static String getLogoutSplashPage() => '$logoutsplashPage';

  static String getRegisterPage() => '$register';
  static String getLoginPage() => '$login';
  static String getForgetPassword()=>'$forget';
  static String getPopularItem(int pageId, String page) =>
      '$popularItems?pageId=$pageId&page=$page';
  static String getRecommendedItem(int pageId, String page) =>
      '$recommendedItems?pageId=$pageId&page=$page';
  static String getCartReturn(int pageId, String page) =>
      '$cartReturn?pageId=$pageId&page=$page';
  static String getCartPage(String email, String name,String phone) => '$cartPage?email=$email&name=$name&phone=$phone';
  static String getCartSplash(String email, String name,String phone) => '$CartSplashpage?email=$email&name=$name&phone=$phone';
  static String getCartDeleteSplash(String email,String name,String phone) => '$CartDeleteSplashpage?email=$email&name=$name&phone=$phone';




  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () {
          return const SplashScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: logoutsplashPage,
        page: () {
          return const LogOutSplashScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: register,
        page: () {
          return const RegisterPage();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: login,
        page: () {
          return const LoginPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: forget,
        page: () {
          return const ForgetPassword();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularItems,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularItemDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedItems,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return RecommandedItemDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartReturn,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return CartReturnDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          var email = Get.parameters['email'];
          var name = Get.parameters['name'];
          var phone = Get.parameters['phone'];


          return CartPage( email: email!, name: name!,phone: phone!,);
        },
        transition: Transition.fadeIn),
    GetPage(
        name:CartSplashpage ,
        page: () {
          var email = Get.parameters['email'];
          var name = Get.parameters['name'];
          var phone = Get.parameters['phone'];

          return CartSplashScreen( email: email!, name: name!,phone: phone!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name:CartDeleteSplashpage ,
        page: () {
          var email = Get.parameters['email'];
          var name = Get.parameters['name'];
          var phone = Get.parameters['phone'];

          return CartDeleteSplashScreen( email: email!, name: name!,phone: phone!);
        },
        transition: Transition.fadeIn),

  ];

}
