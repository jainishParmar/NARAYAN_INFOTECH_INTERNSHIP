import 'package:get/get.dart';
import 'package:intern_final/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class InventoryRecommendedRepo extends GetxService{
  final ApiClient apiClient;

  InventoryRecommendedRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    Response response =  await apiClient.getData(Appconstants.RECOMMENDED_PRODUCT_URI);
    return response;
  }
}