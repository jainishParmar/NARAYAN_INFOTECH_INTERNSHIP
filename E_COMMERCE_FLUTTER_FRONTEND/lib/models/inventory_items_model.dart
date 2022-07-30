class Product {
  int? _totalSize;
  int? _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products => _products;

  Product({required totalSize, required offset, required products}) {
    this._totalSize = totalSize;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _offset = json['offset'];
    if (json['items'] != null) {
      _products = <ProductsModel>[];
      json['items'].forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? item_id;
  String? item_name;
  String? description;
  int?  type_id;
  int? price;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? img5;
  String? createdAt;
  String? updatedAt;

  ProductsModel({
    this.item_id,
    this.item_name,
    this.description,
    this.type_id,
    this.price,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.createdAt,
    this.updatedAt,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    item_id = json['item_id'];
    item_name = json['item_name'];
    description = json['description'];
    type_id = json['type_id'];

    price = json['price'];

    img1 = json['img_1'];
    img2 = json['img_2'];
    img3 = json['img_3'];
    img4 = json['img_4'];
    img5 = json['img_5'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "item_id": this.item_id,
      "item_name": this.item_name,
      "description": this.description,
      "type_id":this.type_id,
      "price": this.price,
      "img_1": this.img1,
      "img_2": this.img2,
      "img_3": this.img3,
      "img_4": this.img4,
      "img_5": this.img5,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}
