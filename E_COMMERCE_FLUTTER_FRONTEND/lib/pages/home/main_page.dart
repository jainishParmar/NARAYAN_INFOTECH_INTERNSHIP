import 'package:flutter/material.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/base/custom_loader.dart';
import 'package:intern_final/base/show_custom_bar.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/controller/user_controller.dart';
import 'package:intern_final/pages/account/account_page.dart';
import 'package:intern_final/pages/home/item_page_body.dart';
import 'package:intern_final/pages/home/seach_result_page.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool search = false;
  bool pagechange = false;
  Future<void> _loadResources() async {
    await Get.find<InventoryPopularController>().getPopularProductList();
    await Get.find<InventoryRecommendedController>().getRecommendedProductList();
   }


  @override
  Widget build(BuildContext context) {
    bool _userhasLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if (_userhasLoggedIn) {
      Get.find<UserController>().getUserInfo();

    }
    var searchController = TextEditingController();
    void _searchword(InventoryPopularController controller){
      String word = searchController.text.trim();
      if(word.isEmpty){
        showCustomSnackBar("Please Type Something To Search",title: "Warning");
      }else{
        setState((){
          pagechange=true;
        });
        controller.search(word);
      }


    }


    return RefreshIndicator(
         onRefresh: _loadResources,

        child: Column(
          children: [
            //header

               Container(
                child: GetBuilder<UserController>(builder: (userControlller) {
                  return _userhasLoggedIn?userControlller.isLoading ?
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height45,
                        bottom: Dimensions.height15),
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: !search? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){                      Get.to(()=>const AccountPage());
                              },
                              child: Container(
                                width: Dimensions.height45,
                                height: Dimensions.height45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  color: Colors.pink,
                                ),
                                child: Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Text(_userhasLoggedIn?userControlller.userModel.name:"User", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font16 * 1.3),)
                          ],
                        )
                        ,
                        Center(
                          child: Container(
                            width: Dimensions.height45,
                            height: Dimensions.height45,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                                color: Colors.pink),
                            child: GestureDetector(onTap:(){
                              setState((){
                                search= true;
                              });
                  },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: Dimensions.iconSize24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ):Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: Dimensions.height20/3, right: Dimensions.height20/3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2),
                            )
                          ]),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: GestureDetector(
                            onTap: (){
                              setState((){
                                search= false;
                                pagechange=false;

                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.pink,

                            ),
                          ),
                          suffixIcon:GetBuilder<InventoryPopularController>(
                            builder: (SearchingController) {
                              return GestureDetector(onTap:(){_searchword(SearchingController);},child: Icon(Icons.search,color: Colors.pink,));
                            }
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                          ),
                        ),
                      ),
                    ),
                  ):const CircularProgressIndicator(color: Colors.pink,):Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height45,
                        bottom: Dimensions.height15),
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: !search?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(onTap:(){
                  Get.to(()=>const AccountPage());

                  },
                              child: Container(
                                width: Dimensions.height45,
                                height: Dimensions.height45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  color: Colors.pink,
                                ),
                                child: Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Text("User", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font16 * 1.3),)
                          ],
                        )
                        ,
                        Center(
                          child: Container(
                            width: Dimensions.height45,
                            height: Dimensions.height45,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                                color: Colors.pink),
                            child: GestureDetector(
                              onTap:(){ setState((){
                                search= true;
                              });},
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: Dimensions.iconSize24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ) : Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: Dimensions.height20/3, right: Dimensions.height20/3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2),
                            )
                          ]),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: GestureDetector(
                            onTap: (){
                              setState((){
                                search= false;
                                pagechange=false;

                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.pink,
                            ),
                          ),
                          suffixIcon:GetBuilder<InventoryPopularController>(
                              builder: (SearchingController) {
                                return GestureDetector(onTap:(){_searchword(SearchingController);},child: Icon(Icons.search,color: Colors.pink,));
                              }
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                          ),
                        ),
                      ),
                    ),
                  );

                },)
                ),




            //food img,dotiindicator
             Expanded(
              child: SingleChildScrollView(
                child:  !pagechange?ItemPageBody():SearchResult(),
              ),
            )
          ],
        ),
    );
  }
}
