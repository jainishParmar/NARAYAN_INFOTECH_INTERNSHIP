import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_final/controller/cart_controller.dart';
import 'package:intern_final/data/repositary/inventory_popular_repo.dart';
import 'package:intern_final/models/cart_model.dart';
import 'package:intern_final/models/inventory_items_model.dart';

class InventoryPopularController extends GetxController {
  final InventoryPopularRepo inventoryPopularRepo;

  InventoryPopularController({required this.inventoryPopularRepo});
  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;

  List<ProductsModel> _allProducts = [];
  List<ProductsModel> get allProducts => _allProducts;

  late List<ProductsModel> _searchProductList = [];
  List<ProductsModel> get searchProductList => _searchProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await inventoryPopularRepo.getItemList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  Future<void> getAllItems() async {
    Response response = await inventoryPopularRepo.getalllist();
    if (response.statusCode == 200) {
      _allProducts = [];
      _allProducts.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  Future<void> search(String word) async {
    Response response = await inventoryPopularRepo.searchList(word);
    if (response.statusCode == 200) {
      _searchProductList = [];
      _searchProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
