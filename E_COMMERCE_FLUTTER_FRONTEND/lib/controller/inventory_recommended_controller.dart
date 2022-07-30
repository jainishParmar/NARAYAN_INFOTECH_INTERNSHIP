import 'package:get/get.dart';
import 'package:intern_final/data/repositary/inventory_recommended_repo.dart';
import 'package:intern_final/models/inventory_items_model.dart';


class InventoryRecommendedController extends GetxController {
  final InventoryRecommendedRepo inventoryRecommendedRepo;

  InventoryRecommendedController({required this.inventoryRecommendedRepo});
  List<ProductsModel> _recommendedProductList = [];
  List<ProductsModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
    await inventoryRecommendedRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
