import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/inventory_recommended_controller.dart';
import 'package:intern_final/models/inventory_items_model.dart';
import 'package:intern_final/utils/app_constants.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:intern_final/widgets/app_column.dart';
import 'package:get/get.dart';



class ItemPageBody extends StatefulWidget {
  const ItemPageBody({Key? key}) : super(key: key);

  @override
  State<ItemPageBody> createState() => _ItemPageBodyState();
}

class _ItemPageBodyState extends State<ItemPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Popular Products',style: TextStyle(fontSize: Dimensions.font16*1.2,color: Colors.pink,fontWeight: FontWeight.bold
              ),),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child:  Text('.',style: TextStyle(color:Colors.black26,fontSize: Dimensions.font16*1.5 ),)
              ),
              SizedBox(
                width: Dimensions.width10,
              ),

            ],
          ),
        ),
        SizedBox(height: Dimensions.height20,),
        GetBuilder<InventoryPopularController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position,
                    popularProducts.popularProductList[position]);
              },
            ),
          )
              : CircularProgressIndicator(
            color: Colors.pink,
          );
        }),


        //dotindicator

        GetBuilder<InventoryPopularController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: Colors.pink,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height15,
        ),
        //popular text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(' Products',style: TextStyle(fontSize: Dimensions.font16*1.2,color: Colors.pink,fontWeight: FontWeight.bold),),


            ],
          ),
        ),
        //recommended food list
        //list of food and images
        GetBuilder<InventoryRecommendedController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                   Get.toNamed(RouteHelper.getRecommendedItem(index,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width: Dimensions.listviewImgsize,
                        height: Dimensions.listviewImgsize,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                              image: NetworkImage(Appconstants.BASE_URL+"/api/"+recommendedProduct.recommendedProductList[index].img1!),

                          ),
                        ),
                      ),
                      //text container
                      Expanded(
                        child: Container(
                          height: Dimensions.listviewTextsize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      Dimensions.radius20),
                                  bottomRight: Radius.circular(
                                      Dimensions.radius20)),
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
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10/2),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(recommendedProduct
                                        .recommendedProductList[index]
                                        .item_name!,style: TextStyle(fontSize:
                                 Dimensions.font16*1.5),softWrap: true,maxLines: 1,),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  children: [
                                    Text('₹',style: TextStyle(fontSize: Dimensions.font16*1.2,fontWeight: FontWeight.bold),),
                                    Text(" ${recommendedProduct
                                        .recommendedProductList[index]
                                        .price!.toString()}",style: TextStyle(fontSize:
                                    Dimensions.font16*1.2),softWrap: true,maxLines: 1,),
                                  ],
                                )



                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
              : CircularProgressIndicator(
            color: Colors.pink,
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index,ProductsModel  popularProduct ) {
    Matrix4 matrix =  Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){Get.toNamed(RouteHelper.getPopularItem(index, "home"));},

        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.black54,
                image: DecorationImage(

                  fit: BoxFit.cover,
                  image: NetworkImage(Appconstants.BASE_URL+"/api/"+popularProduct.img1!),


                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  child: AppColumn(text: popularProduct.item_name!,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
