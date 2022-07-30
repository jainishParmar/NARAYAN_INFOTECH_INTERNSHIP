
import 'package:get/get.dart';
import 'package:intern_final/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class InventoryPopularRepo extends GetxService{
  final ApiClient apiClient;

  InventoryPopularRepo({required this.apiClient});

  Future<Response> getItemList() async{
    Response response =   await apiClient.getData(Appconstants.GET_ITEMS);

    return response;


  }

  Future<Response> searchList(String word) async {
    return  await apiClient.getData(Appconstants.GET_ITEMS+"/${word}");
  }

  Future<Response> getalllist() async{
    Response response =   await apiClient.getData(Appconstants.ALL_PRODUCT_URI);

    return response;


  }
}