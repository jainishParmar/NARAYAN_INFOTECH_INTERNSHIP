import 'dart:convert';
import 'package:intern_final/data/api/api_client.dart';

import '../../models/cart_model.dart';

import 'package:intern_final/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';


class CartRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  CartRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> saveCartDb(CartModel cartbody) async {

    Response response =  await apiClient.postData(Appconstants.DB_STORE_CART,cartbody.toJson());
    return response;
  }
  Future<Response> saveOrderDb(CartModel cartbody) async {

    Response response =  await apiClient.postData(Appconstants.DB_STORE_ORDER,cartbody.toJson());
    return response;
  }
  Future<Response> getCartDb(String email) async {
    Response response =  await apiClient.getData(Appconstants.DB_STORE_CART + "/${email}");

    return response;
  }
  Future<Response> getOrderDb(String email) async {
    Response response =  await apiClient.getData(Appconstants.DB_STORE_ORDER + "/${email}");

    return response;
  }

  Future<Response> getCartTotalItems(String email) async{
     Response response =await apiClient.getData(Appconstants.GET_CART_TOTAL_ITEMS + "/${email}");
     return response;

  }

  Future<Response> getCartTotalAmount(String email) async{
    Response response =await apiClient.getData(Appconstants.GET_CART_TOTAL_AMOUNT + "/${email}");
    return response;

  }

  Future<Response> getCurrentQuantity(String email,int id) async{
    Response response =await apiClient.getData(Appconstants.GET_CURRENT_QUANTITY_IN_CART_OF_PARTICULAR_ITEM + "/${email}/${id}");
    return response;

  }

  Future<Response> CartDelete(String email) async{
    Response response =await apiClient.getData(Appconstants.DELETE_CART_LIST + "/${email}");

    return response;

  }

  Future<Response>deleteCartWithZeroQuantity(String email,int id) async {
    Response response = await  apiClient.getData(Appconstants.DELETE_ZERO_QAUNTITY_CART +"/${email}/${id}");
    return response;

  }











}
