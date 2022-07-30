import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/base/show_custom_bar.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/pages/auth/register_page.dart';
import 'package:intern_final/pages/home/home_page.dart';

import '../../utils/dimension.dart';
import '../../widgets/app_text_field.dart';

class SetNewPassWord extends StatelessWidget {
  final String message;
  const SetNewPassWord( {Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController1 = TextEditingController();
    var passwordController2 = TextEditingController();

    void _login(AuthController authController) {
      String pwd1 = passwordController1.text.trim();
      String pwd2 = passwordController2.text.trim();

      if (pwd1.isEmpty) {
        showCustomSnackBar("Please Enter Your New Password",
            title: 'New Password');
      } else if (pwd2.isEmpty) {
        showCustomSnackBar("Please Re-enter Your New Password",
            title: 'Re-enter new password');
      } else if (pwd1.length < 6) {
        showCustomSnackBar("Password Must be More Than Six Chracters",
            title: 'Password too Short');
      } else if (pwd1 != pwd2) {
        showCustomSnackBar(
            "Your New Password And Re-enter Password Are Not Same",
            title: 'Password MisMatch');
      } else {
        authController.resetPassword(message,pwd1 ).then((status) {
          if (status.isSucess) {
            Get.snackbar("PassWord Reset Successfully,Now Try To Login With New PassWord", "PassWord Reset",backgroundColor: Colors.pink,colorText: Colors.white);
            Get.toNamed(RouteHelper.getLoginPage());
          } else {
            showCustomSnackBar(status.message,title: "Password Reset");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //applogo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      //bigtext
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: Dimensions.font26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),



                      AppTextField(
                        textController: passwordController1,
                        icon: Icons.password,
                        hintText: 'New Password',
                        pass: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: passwordController2,
                        icon: Icons.password,
                        hintText: 'Re-enter Password',
                        pass: true,
                      ),

                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),

                      //sign up
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: Colors.pink),
                          child: Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 9.5,
                      ),
                      //text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Don't Have An Account ?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20)),
                          ),
                          RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                      () => const RegisterPage(),
                                      transition:
                                          Transition.leftToRightWithFade,
                                    ),
                              text: " Create",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => const HomePage()),
                            text: "Skip For Now",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
