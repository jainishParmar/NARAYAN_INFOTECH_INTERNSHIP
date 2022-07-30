import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/base/show_custom_bar.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/pages/auth/register_page.dart';
import 'package:intern_final/pages/auth/set_new_password_page.dart';
import 'package:intern_final/pages/home/home_page.dart';

import '../../utils/dimension.dart';
import '../../widgets/app_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var otpController = TextEditingController();
    late String  user_email;
    bool hide = true;
    void _login(AuthController authController) {
      String email = emailController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("type in your Email address",
            title: 'Email address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("type in a valid Email",
            title: 'valid Email address');
      } else {
        authController.forget(email).then((status) {
          if (status.isSucess) {
            user_email = status.message;
            hide= false;
            Get.snackbar("One Time Verification Code", "OTP Has Been Sent On Your Email Address",colorText: Colors.white,backgroundColor: Colors.pink);
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    void _compareOtp(AuthController authController){
      String OTP = otpController.text.trim();

      if (OTP.isEmpty) {
        showCustomSnackBar("type in your Otp which Has Been Sent On Your Email",
            title: 'One Time Verification Code');
      } else if (OTP.length<6||OTP.length>6) {
        showCustomSnackBar("Otp Must Be Of Six Character",
            title: 'One Time Verification Code');
      } else {
        authController.compare(OTP,user_email).then((status) {
          if (status.isSucess) {
            Get.snackbar('One Time Verification Code',"OTP Verifies SuccessFully",colorText: Colors.white,backgroundColor: Colors.pink);
            Get.to(()=>SetNewPassWord(message:user_email ));
          } else {
            showCustomSnackBar(status.message);
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
                              'Forget Password',
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
                      //phone
                      AppTextField(
                        textController: emailController,
                        icon: Icons.email,
                        hintText: 'Email',
                      ),
                      !hide?SizedBox(
                        height: Dimensions.height20 * 1,
                      ):Container(),
                      !hide?AppTextField(
                        textController: otpController,
                        icon: Icons.password,
                        hintText: 'OTP',
                        pass: true,
                      ):Container(),
                      SizedBox(
                        height: Dimensions.height20 * 1.5,
                      ),

                      //sign up
                    Column(children: [
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: hide?Container(
                          width: Dimensions.screenWidth / 3,
                          height: Dimensions.screenHeight / 16,

                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                              color: Colors.pink),
                          child: Center(
                            child: Text(
                              'Send OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16/1.3,
                                  height: 1
                              ),
                            ),
                          ),
                        ):Container(),
                      ),
                      SizedBox(height: Dimensions.height10*1.5,),
                      !hide?GestureDetector(
                        onTap: () {
                          _compareOtp(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 16,

                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                              color: Colors.pink),
                          child: Center(
                            child: Text(
                              'Forget Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16,
                                  height: 1
                              ),
                            ),
                          ),
                        ),
                      ):Container()
                    ],),
                      !hide?SizedBox(
                        height: Dimensions.height20 * 7.5,
                      ):SizedBox(
                        height: Dimensions.height20 * 12,
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
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => const HomePage()),
                            text: "Skip For Now",
                            style: const TextStyle(
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
