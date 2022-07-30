import 'package:flutter/material.dart';
import 'package:intern_final/Route/route_helper.dart';
import 'package:intern_final/controller/inventory_popular_controller.dart';
import 'package:intern_final/utils/app_constants.dart';
import 'package:intern_final/utils/dimension.dart';
import 'package:get/get.dart';



class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {


  @override
  void initState() {
    super.initState();
    Get.find<InventoryPopularController>().getAllItems();


  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        GetBuilder<InventoryPopularController>(builder: (searchController){
          return   Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('${searchController.searchProductList.length} Products Found',style: TextStyle(fontSize: Dimensions.font16*1.2,color: Colors.pink,fontWeight: FontWeight.bold),),
          SizedBox(
          width: Dimensions.width10,
          ),
          Container(
          margin: const EdgeInsets.only(bottom: 3),
          child:  Text('. . . .',style: TextStyle(color:Colors.pink,fontSize: Dimensions.font16*1.5 ),)
          ),
          SizedBox(
          width: Dimensions.width10,
          ),

          ],
          );
        },

        ),
        //recommended food list
        //list of food and images
        GetBuilder<InventoryPopularController>(builder: (searchController) {
          return searchController.isLoaded
              ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchController.searchProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                  Get.toNamed(RouteHelper.getCartReturn(searchController.searchProductList[index].item_id!, "Search Page"));

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
                            image: NetworkImage("${Appconstants.BASE_URL}/api/${searchController.searchProductList[index].img1!}"),

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
                                Text(searchController
                                    .searchProductList[index]
                                    .item_name!,style: TextStyle(fontSize:
                                Dimensions.font16*1.5),softWrap: true,maxLines: 1,),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  children: [
                                    Text('₹',style: TextStyle(fontSize: Dimensions.font16*1.2,fontWeight: FontWeight.bold),),
                                    Text(" ${searchController
                                        .searchProductList[index]
                                        .price!.toString()}",style: TextStyle(fontSize:
                                    Dimensions.font16*1),softWrap: true,maxLines: 1,)

                                  ],
                                ),



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
              : const CircularProgressIndicator(
            color: Colors.pink,
          );
        })
      ],
    );
  }

}
