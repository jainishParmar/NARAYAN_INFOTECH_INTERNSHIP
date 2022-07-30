import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/auth_controller.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/controller/user_controller.dart';
import 'package:intern_final/models/inventory_items_model.dart';
import 'package:intern_final/utils/app_constants.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:intern_final/widgets/app_icon.dart';
import 'package:get/get.dart';

import 'package:intern_final/widgets/expandable_text.dart';

class CartReturnDetails extends StatefulWidget {
  final int pageId;
  final String page;
  const CartReturnDetails({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  State<CartReturnDetails> createState() => _CartReturnDetailsState();
}

class _CartReturnDetailsState extends State<CartReturnDetails> {
  PageController pageController = PageController(viewportFraction: 0.85);
  int reload = 0;
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
    var product =
         Get.find<InventoryPopularController>().allProducts[widget.pageId-1];
    print(Get.find<InventoryPopularController>().allProducts);


    bool _userhasLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if (_userhasLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<CartController>()
          .getCartTotalItems(Get.find<UserController>().userModel.email);
      Get.find<CartController>().getCurrentQauntiy(
          Get.find<UserController>().userModel.email, product.item_id!);
    }

    return GetBuilder<CartController>(builder: (cartController1) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Container(
                height: 240,
                width: double.maxFinite,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 5,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, product);
                  },
                ),
              ),
            ),
            Positioned(
              top: Dimensions.height45 * 6.5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: DotsIndicator(
                dotsCount: 5,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: Colors.pink,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Positioned(
              top: Dimensions.height45 * 1.35,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<CartController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (_userhasLoggedIn) {
                            if (controller.getCartTotalItemsFromdb >= 1) {
                              Get.toNamed(RouteHelper.getCartSplash(
                                  Get.find<UserController>().userModel.email,
                                  Get.find<UserController>().userModel.name,
                                  Get.find<UserController>().userModel.phone));
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.getCartTotalItemsFromdb >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: Colors.pink,
                                    ))
                                : Container(),
                            controller.getCartTotalItemsFromdb >= 1
                                ? Positioned(
                                    right: 5,
                                    top: 3,
                                    child: Text(
                                      controller.getCartTotalItemsFromdb
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          color: Colors.white),
                                    ))
                                : Container()
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.item_name!,
                          style: TextStyle(fontSize: Dimensions.font26),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                5,
                                (index) => const Icon(
                                  Icons.star,
                                  color: Colors.pink,
                                  size: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('4.5'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('1287'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Comments'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),
                    Text(
                      "Introduce",
                      style: TextStyle(fontSize: Dimensions.font16 * 2),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<UserController>(
          builder: (controller) {
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
              child: GetBuilder<InventoryPopularController>(
                builder: (popularProduct) {
                  child:
                  return Row(
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
                            ]),
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (cartController.getCurrentQuantity ==
                                        0) {
                                    } else if (cartController
                                            .getCurrentQuantity ==
                                        1) {
                                      cartController.inordec(false);
                                      cartController.deleteCartWithZeroQuantity(
                                          Get.find<UserController>()
                                              .userModel
                                              .email,
                                          widget.pageId);
                                      setState(() {
                                        reload = 1;
                                      });
                                    } else {
                                      cartController.inordec(false);

                                      if (_userhasLoggedIn) {
                                        cartController.storeCartInDB(
                                            product,
                                            cartController.getCurrentQuantity,
                                            Get.find<UserController>()
                                                .userModel
                                                .email);

                                        setState(() {
                                          reload = 1;
                                        });
                                      } else {
                                        Get.toNamed(RouteHelper.getLoginPage());
                                      }
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                GetBuilder<CartController>(
                                    builder: (cartController) {
                                  return Text(
                                    cartController.getCurrentQuantity
                                        .toString(),
                                    style:
                                        TextStyle(fontSize: Dimensions.font16),
                                  );
                                }),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartController.inordec(true);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.pink,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      GetBuilder<CartController>(
                        builder: (cartController) {
                          return GestureDetector(
                            onTap: () {
                              if (_userhasLoggedIn) {
                                if (cartController.getCurrentQuantity == 0) {
                                  Get.snackbar("Zero Quantity",
                                      "You Cant't Add Product In Cart With Zero Quantity",
                                      backgroundColor: Colors.pink,
                                      colorText: Colors.white);
                                  setState(() {
                                    reload = 1;
                                  });
                                } else {
                                  cartController.storeCartInDB(
                                      product,
                                      cartController.getCurrentQuantity,
                                      Get.find<UserController>()
                                          .userModel
                                          .email);
                                  Get.snackbar("Cart", "Product Added In Cart",
                                      backgroundColor: Colors.pink,
                                      colorText: Colors.white);
                                  setState(() {
                                    reload = 1;
                                  });
                                }
                              } else {
                                Get.toNamed(RouteHelper.getLoginPage());
                              }
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
                                " INR ${product.price}  | Add to Cart",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildPageItem(int index, ProductsModel product) {
    Matrix4 matrix = Matrix4.identity();
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

    var images = [
      product.img1!,
      product.img2!,
      product.img3!,
      product.img4!,
      product.img5!,
    ];

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            width: double.maxFinite,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                    Appconstants.BASE_URL + "/api/" + images[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
