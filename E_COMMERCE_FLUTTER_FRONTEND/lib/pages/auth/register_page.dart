import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/base/show_custom_bar.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/models/sign_up_body.dart';
import 'package:intern_final/pages/auth/login_page.dart';
import 'package:intern_final/pages/home/home_page.dart';

import '../../utils/dimension.dart';
import '../../widgets/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("type in your name", title: 'name');
      } else if (phone.isEmpty) {
        showCustomSnackBar("type in your phone number", title: 'phone number');
      } else if (phone.length < 10 || phone.length >10 ) {
        showCustomSnackBar(" phone number must be of 10 digit", title: 'phone number');}else if (email.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(name: name, phone: phone, email: email, password: password);

        authController.registration(signUpBody).then((status) {
          if (status.isSucess) {
            Get.snackbar('user Registration Successfully','Register',colorText: Colors.white,backgroundColor: Colors.pink);
            Get.offNamed(RouteHelper.getLoginPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body:GetBuilder<AuthController>(builder: (_authController){
          return !_authController.isLoading ?  SingleChildScrollView(
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
                AppTextField(
                  textController: nameController,
                  icon: Icons.person,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //email
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
                  height: Dimensions.height20,
                ),


                //phone
                AppTextField(
                  textController: phoneController,
                  icon: Icons.phone,
                  hintText: 'Phone',
                ),
                SizedBox(
                  height: Dimensions.height10*3,
                ),
                //sign up
                GestureDetector(
                  onTap: () {
                    _registration(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight / 14,
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.pink),
                    child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimensions.font26),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20*5,
                ),
                //text
                RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const LoginPage(),
                            transition: Transition.rightToLeftWithFade),
                      text: "Have an Account Already?",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20,fontWeight: FontWeight.bold)),
                ),

                SizedBox(
                  height: Dimensions.screenHeight * 0.02,
                ),
                //sign up option,
                // RichText(
                //   text: TextSpan(
                //       text: "Sign Up Using One Of The Following Methods",
                //       style: TextStyle(
                //           color: Colors.grey[500],
                //           fontSize: Dimensions.font16,
                //           fontWeight: FontWeight.bold)),
                // ),
                // Wrap(
                //
                //   children: List.generate(
                //     3,
                //         (index) => Container(
                //       padding: const EdgeInsets.all(8.0),
                //       margin: const EdgeInsets.all(5.0),
                //
                //       child: CircleAvatar(
                //         radius: Dimensions.radius20 * 1.25,
                //         backgroundImage:
                //         AssetImage("assets/images/${signUpImages[index]}"),
                //       ),
                //     ),
                //   ),
                // ),
                RichText(text:  TextSpan(recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const HomePage()), text: "Skip For Now",style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),),

              ],
            ),
          ):const CustomLoader();
        },),
    );
  }
}
