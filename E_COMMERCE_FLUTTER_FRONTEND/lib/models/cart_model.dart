



import 'package:intern_final/models/inventory_items_model.dart';
class CartProduct {
  int? _totalSize;
  int? _offset;
  late List<CartModel> _carts;
  List<CartModel> get carts => _carts;

  CartProduct({required totalSize, required offset, required carts}) {
    this._totalSize = totalSize;
    this._offset = offset;
    this._carts = carts;
  }

  CartProduct.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _offset = json['offset'];
    if (json['items'] != null) {
      _carts = <CartModel>[];
      json['items'].forEach((v) {
        _carts.add(CartModel.fromJson(v));
      });
    }
  }
}


class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? email;
  int? quantity;
  String? time;


  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.email,

    this.quantity,
    this.time,

  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['cart_product_id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    email=json['email'];
    quantity = json['quantity'];
    time = json['time'];

  }

  Map<String,dynamic> toJson(){
    return{
      "cart_product_id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "email":this.email,
      "quantity":this.quantity,
      "time":this.time,

    };
  }
}
