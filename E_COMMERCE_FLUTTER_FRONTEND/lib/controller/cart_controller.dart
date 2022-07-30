import 'package:get/get.dart';
import 'package:intern_final/data/repositary/cart_repo.dart';
import 'package:intern_final/models/cart_model.dart';
import 'package:intern_final/models/inventory_items_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  List<CartModel> _cartListFromDb = [];
  List<CartModel> _orderListFromDb = [];

  List<CartModel> get cartListFromDb => _cartListFromDb;
  List<CartModel> get orderListFromDb => _orderListFromDb;

  int getCartTotalItemsFromdb = 0;
  int getCartTotalAmountFromdb = 0;
  int getCurrentQuantity = 0;
  bool _isloading = true;
  bool get isLoading => _isloading;

  Future<void> storeCartInDB(
      ProductsModel product, int quantity, String email) async {
    _isloading = false;
    update();

    CartModel cartBody = CartModel(
      id: product.item_id!,
      name: product.item_name!,
      price: product.price!,
      img: product.img1,
      email: email,
      quantity: quantity,
      time: DateTime.now().toString(),

    );

    Response response = await cartRepo.saveCartDb(cartBody);
    if (response.statusCode == 200) {
      _isloading = true;
    } else {

    }

    update();
  }

  Future<void> StoreOrderInDB() async {
    for (int i = 0; i < cartListFromDb.length; i++) {
      cartListFromDb[i].time = DateTime.now().toString();
      Response response = await cartRepo.saveOrderDb(cartListFromDb[i]);
      if (response.statusCode == 200) {
        _isloading = true;
      } else {

      }

    }
    update();
  }

  Future<void> getCartList(String email) async {

    Response response = await cartRepo.getCartDb(email);
    if (response.statusCode == 200) {
      _cartListFromDb = [];
      _cartListFromDb.addAll(CartProduct.fromJson(response.body).carts);

      update();
    } else {
    }
  }
  Future<void> getOrderList(String email) async {

  _isloading = false;
  update();
    Response response = await cartRepo.getOrderDb(email);
    if (response.statusCode == 200) {
      _orderListFromDb = [];
      _orderListFromDb.addAll(CartProduct.fromJson(response.body).carts);
_isloading = true;
      update();
    } else {
    }
  }

  Future<void> getCartTotalItems(String email) async {
    _isloading = false;
    Response response = await cartRepo.getCartTotalItems(email);
    if (response.statusCode == 200) {
      getCartTotalItemsFromdb = int.parse(response.body);
      _isloading = true;
      update();
    } else {}
  }

  Future<void> getCartTotalAmount(String email) async {
    _isloading = false;
    Response response = await cartRepo.getCartTotalAmount(email);
    if (response.statusCode == 200) {
      getCartTotalAmountFromdb = int.parse(response.body);
      _isloading = true;
      update();
    } else {}
  }

  Future<void> getCurrentQauntiy(String email, int id) async {
    _isloading = false;
    Response response = await cartRepo.getCurrentQuantity(email, id);
    if (response.statusCode == 200) {
      getCurrentQuantity = int.parse(response.body);
      _isloading = true;
      update();
    } else {}
  }

  void inordec(bool abc) {
    if (abc) {
      ++getCurrentQuantity;
      update();
    } else {
      --getCurrentQuantity;
      update();
    }
  }

  Future<void> deleteCart(String email) async {
    await cartRepo.CartDelete(email);
  }

  Future<void> deleteCartWithZeroQuantity(String email, int id) async {
    print(id);
    Response response = await cartRepo.deleteCartWithZeroQuantity(email, id);
    print(response.body);
    getCurrentQuantity = 0;
    update();

  }
}
