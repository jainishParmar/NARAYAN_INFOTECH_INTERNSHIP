import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/pages/home/home_page.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';



class PaymentPage extends StatefulWidget {
  final String email;
  final String phone;
  final String name;
  final int total_amount;
  const PaymentPage({Key? key, required this.email, required this.phone, required this.name, required this.total_amount}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay razorpay = new Razorpay();
  @override
  void initState() {
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleErrorfailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_etDNuQ5nZ62QdL",
      "amount": widget.total_amount*100,
      "name": widget.name,
      "description": "payment for your order",
      "prefill": {"contact": widget.phone, "email": widget.email},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try{
      razorpay.open(options);
    }catch(e){
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
   Get.snackbar("Order Confimed","Your Order Is Confirmed",colorText: Colors.white,backgroundColor: Colors.pink);
    Get.toNamed(RouteHelper.getCartDeleteSplash(widget.email, widget.name, widget.phone));

  }

  void handleErrorfailure(PaymentFailureResponse response) {

    Get.snackbar("payment Failure","Payment Unsuccessfull,Try It Again");
  }
  void handlerExternalWallet(ExternalWalletResponse response) {

  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    print(widget.phone);
    print(widget.name);

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.pink,
      ),
      body: Container(

        child:  Center(

          child: Column(

            children: [
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
              Container(

                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                  color: Colors.white30,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(widget.name,style: TextStyle(
                        fontSize: Dimensions.font16*1.2
                    ),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                    color: Colors.white30,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(widget.email,style: TextStyle(
                        fontSize: Dimensions.font16*1.2
                    ),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                    color: Colors.white30,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(widget.phone,style: TextStyle(
                        fontSize: Dimensions.font16*1.2
                    ),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30/2),
                    color: Colors.white30,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Amount : ",style: TextStyle(
                        fontSize: Dimensions.font16*1.2
                    ),),
                    Text('₹ ',style: TextStyle(fontSize: Dimensions.font16*1.2,fontWeight: FontWeight.bold),),

                    Text(widget.total_amount.toString(),style: TextStyle(
                        fontSize: Dimensions.font16*1.2
                    ),)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),

              GestureDetector(
                onTap: () {
                  openCheckOut();
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
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font16 *1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
