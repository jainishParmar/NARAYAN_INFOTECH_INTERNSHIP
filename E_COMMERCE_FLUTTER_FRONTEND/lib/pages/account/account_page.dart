import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/user_controller.dart';
import 'package:intern_final/pages/home/home_page.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:intern_final/widgets/account_widvget.dart';
import 'package:intern_final/widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userhasLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if (_userhasLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userhasLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          //profile
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: Colors.pink,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height15 * 5,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //name
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: Colors.pink,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigtext: Text(
                                      userController.userModel.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  //phone
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: Colors.pink,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigtext: Text(
                                      userController.userModel.phone,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  //email
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: Colors.pink,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigtext: Text(
                                      userController.userModel.email,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      if (_userhasLoggedIn) {
                                         Get.find<AuthController>()
                                            .clearSharedData();
Get.snackbar('user logged out successfully','Logout',backgroundColor: Colors.pink,colorText: Colors.white);
                                        Get.toNamed(RouteHelper.getLogoutSplashPage());
                                        // }
                                      } else {
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: Colors.pink,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigtext: const Text(
                                        'LogOut',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Container(

                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 14,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/login.png"))),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getLoginPage());
                          },
                          child: Container(
                            width: Dimensions.width20*7,
                            height: Dimensions.height20 * 3,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.pink,
                            ),
                            child: const  Center(
                                child: Text(
                              "Sign In",
                              style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            ),

                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        Text('You Have To Login First',style: TextStyle(color: Colors.black26,fontSize: Dimensions.font16),),
                        SizedBox(height: Dimensions.height20*8,),

                        RichText(text:  TextSpan(recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const HomePage()), text: "Skip For Now",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),),

                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
