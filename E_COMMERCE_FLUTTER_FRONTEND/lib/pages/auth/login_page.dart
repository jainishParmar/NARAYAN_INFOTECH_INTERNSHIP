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

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("type in your Email address",
            title: 'Email address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("type in a valid Email",
            title: 'valid Email address');
      } else if (password.isEmpty) {
        showCustomSnackBar("type in your password", title: 'password');
      } else if (password.length < 6) {
        showCustomSnackBar("password can not be less than six character",
            title: 'Password');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSucess) {
            Get.snackbar("login","user Login SuccessFully",colorText: Colors.white,backgroundColor: Colors.pink);
            Get.toNamed(RouteHelper.getInitial());
          } else {
            Get.snackbar("UnAuthorised","Credential Does Not Match",colorText: Colors.white,backgroundColor: Colors.redAccent);

          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? SingleChildScrollView(
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
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              //bigtext
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: Dimensions.font26 * 2.5,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sign Into Your Account',
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
              SizedBox(
                height: Dimensions.height20,
              ),
              //password
              AppTextField(
                textController: passwordController,
                icon: Icons.password_sharp,
                hintText: 'Password',
                isObscure: true,
                pass: true,
              ),
              SizedBox(
                height: Dimensions.height10 * 1.5,
              ),
              // Container(
              //   margin: EdgeInsets.only(right: Dimensions.width10 * 2.5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text(
              //         'Sign Into Your Account',
              //         style: TextStyle(
              //           color: Colors.grey[500],
              //           fontSize: Dimensions.font20,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: Dimensions.height20 * 1,
              ),
              Center(
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: (){Get.toNamed(RouteHelper.getForgetPassword());},
                            child: Text(
                              'Forget Password',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height20 * 1,
              ),

              //sign up
              GestureDetector(
                onTap: () {
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight / 13,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Colors.pink),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font16 *1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10 * 7,
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
                          transition: Transition.leftToRightWithFade,
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
              SizedBox(height: 5,),
              RichText(text:  TextSpan(recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const HomePage()), text: "Skip For Now",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),),
            ],
          ),
        ):const CustomLoader();
      },),
    );
  }
}
