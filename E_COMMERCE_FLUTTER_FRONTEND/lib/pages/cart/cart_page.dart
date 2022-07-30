import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_final/base/no_data_page.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/utils/dimension.dart';

import '../../Route/route_helper.dart';
import '../../utils/app_constants.dart';
import '../payment/payment.dart';


class CartPage extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  const CartPage({Key? key, required this.email, required this.name, required this.phone}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int reload = 0;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(

    backgroundColor: Colors.pink,
    automaticallyImplyLeading: false,
    title: Text("Your Cart ",style: TextStyle(fontSize: Dimensions.font16*1.5),),
    actions: <Widget>[

         GestureDetector(
           onTap: (){
             Get.toNamed(RouteHelper.getInitial());
           },
          child: Icon(Icons.home_outlined,color: Colors.white,size: 40,),
        ),
      SizedBox(width: Dimensions.width10,)

    ],

  ),
    body:Stack(
      children: [GetBuilder<CartController>(
        builder: (_cartController) {
          return _cartController.cartListFromDb.length > 0
              ? Positioned(
            top: Dimensions.height20 *1,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(

              margin: EdgeInsets.only(top: 10),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.cartListFromDb;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(

                           margin: EdgeInsets.only(top: Dimensions.height15),
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  int pageIndex = _cartList[index].id!;
                                  if(pageIndex > 0 && pageIndex <11){
                                    print("page Index :: --------" + pageIndex.toString());
                                      Get.toNamed(RouteHelper.getCartReturn(pageIndex,"cartpage"));
                                  }


                                },
                                child: Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: const  [
                                        BoxShadow(
                                          color: Color(0xFFe8e8e8),
                                          blurRadius: 5.0,
                                          offset: Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        ),],
                                    borderRadius:
                                    BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            "${Appconstants.BASE_URL}/api/${_cartList[index].img!}"

                                                ),

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensions.height20 * 5,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    boxShadow:  [
                                    BoxShadow(
                                      color: Color(0xFFe8e8e8),
                                      blurRadius: 5.0,
                                      offset: Offset(0, 5),
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(5, 0),
                                    ),]
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                         _cartList[index].name!,
                                        style: TextStyle(color: Colors.black,fontSize: Dimensions.font16*1.2),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text('₹',style: TextStyle(fontSize: Dimensions.font16*1.3,fontWeight: FontWeight.bold,color: Colors.pink),),
                                              Text(

                                                " ${_cartList[index].price!}",
                                                style: TextStyle( color: Colors.pink,fontSize: Dimensions.font16*1.2),
                                              ),
                                            ],
                                          ),

                                          Container(
                                            padding: EdgeInsets.all(
                                                Dimensions.height10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions
                                                      .radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                            Text(
                                            "quantity :",style: TextStyle(fontSize: Dimensions.font16*1.2),),
                                                SizedBox(
                                                  width: Dimensions
                                                      .width10 /
                                                      2,
                                                ),
                                                Text(
                                                    _cartList[index].quantity.toString(),style: TextStyle(fontSize: Dimensions.font16*1.2),

                                                  // popularProduct.inCartItems.toString()
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                      .width10 /
                                                      2,
                                                ),


                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
              : NoDataPage(text: "Your Cart Is Empty!");
        },
      ),]
    ),
    bottomNavigationBar: GetBuilder<CartController>(
      builder: (cartController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              )),
          child: cartController.cartListFromDb.length > 0
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0),
                      ),
                    ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    Text('₹',style: TextStyle(fontSize: Dimensions.font16*1.2,fontWeight: FontWeight.bold),),
                    Text(

                        ' ${cartController.getCartTotalAmountFromdb.toString()}',style: TextStyle(fontSize: Dimensions.font16*1.2,fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                   Get.to(()=>PaymentPage(name:widget.name ,email: widget.email,phone:widget.phone ,total_amount:cartController.getCartTotalAmountFromdb ,));



                  setState((){
                    reload=1;
                  });

                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius20),
                    color: Colors.pink,
                  ),
                  child: Text(
                     "Check Out",
                    style:TextStyle(color: Colors.white,fontSize: Dimensions.font16)
                  ),
                ),
              )
            ],
          )
              : Container(),
        );
      },
    ),
  );
  }
}
