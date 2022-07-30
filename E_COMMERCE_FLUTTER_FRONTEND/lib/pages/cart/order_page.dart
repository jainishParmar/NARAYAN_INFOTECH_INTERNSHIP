import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/no_data_page.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/models/cart_model.dart';
import 'package:intern_final/utils/app_constants.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:intern_final/widgets/app_icon.dart';
import 'package:intl/intl.dart';

import '../../controller/user_controller.dart';
import '../home/home_page.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userhasLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if (_userhasLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<CartController>().getOrderList(Get.find<UserController>().userModel.email);
    }
    List<CartModel> orderList = Get
        .find<CartController>()
        .orderListFromDb
        .reversed
        .toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < orderList.length; i++) {
      if (cartItemsPerOrder.containsKey(orderList[i].time)) {
        cartItemsPerOrder.update(
            orderList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(orderList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < orderList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(orderList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return Text(outputDate, style: TextStyle(fontSize: Dimensions.font16*1.3,fontWeight: FontWeight.bold),);
    }


    return Scaffold(
      body:  Column(
            children: [
              Container(
                height: Dimensions.height20 * 5,
                color: Colors.pink,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width10),
                child: Row(

                  children: [
                    GestureDetector(
                      onTap:(){
                       Get.toNamed(RouteHelper.getInitial()) ;
                      },
                      child:  Icon(Icons.arrow_back,color: Colors.white,)
                    ),
                    SizedBox(width: 10,),
                    Text(
                      " Your Orders",
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimensions.font16 * 1.5),
                    ),

                  ],
                ),
              ),

              _userhasLoggedIn? orderList.length > 0
                  ? Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for (int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height20 * 7,
                            margin:
                            EdgeInsets.only(bottom: Dimensions.height20/4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          itemsPerOrder[i], (index) {
                                        if (listCounter <orderList.length) {
                                          listCounter++;
                                        }
                                        return  Container(
                                          height:
                                          Dimensions.height20 * 5,
                                          width:
                                          Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              right:
                                              Dimensions.width10 /
                                                  2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimensions.width15 /
                                                    2),
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                Appconstants.BASE_URL + "/api/" +
                                                    orderList[ listCounter - 1]
                                                        .img!,
                                              ),
                                            ),
                                          ),
                                        );

                                      }),
                                    ),
                                    SizedBox(width:Dimensions.width20 ,),
                                    Container(
                                      height: Dimensions.height20 * 4,
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderList[ listCounter - 1]
                                                .name! , style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Dimensions.font16*1.2,


                                          ),
                                            maxLines: 1,
                                            softWrap: true,



                                          ),
                                          Text(
                                            orderList[ listCounter - 1]
                                                .quantity!.toString() + " Items",
                                            style: TextStyle(color: Colors.black,
                                              fontSize: Dimensions.font16*1.3,fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
                  : Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                child: const Center(
                  child: NoDataPage(
                    text: "You Didn't Buy Anything So Far ",
                    imgPath: "assets/images/empty_box.png",
                  ),
                ),
              ):Container(
                margin:EdgeInsets.all(50),
                child: Center(child: Column(
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
                  SizedBox(height: Dimensions.height20*8.9,),

                  RichText(text:  TextSpan(recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>const HomePage()), text: "Skip For Now",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),),

                ],
              ), ), )

            ],

      ),
    );
  }
}
