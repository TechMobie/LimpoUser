import 'package:linpo_user/helper/utils/common_functions.dart';
class GetCartModel {
  bool? success;
  String? message;
  Data? data;

  GetCartModel({this.success, this.message, this.data});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? totalAmount;
  int? shippingAmount;
  int? finalAmount;
  int? isCheckout;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<CartDetail>? cartDetail;

  Data(
      {this.id,
        this.userId,
        this.totalAmount,
        this.shippingAmount,
        this.finalAmount,
        this.isCheckout,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.cartDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalAmount = !isNullEmptyOrFalse(json['total_amount'])
        ? int.parse(json['total_amount'].toString())
        : null;
    shippingAmount = json['shipping_amount'];
    finalAmount = json['final_amount'];
    isCheckout = json['is_checkout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['cart_detail'] != null) {
      cartDetail = <CartDetail>[];
      json['cart_detail'].forEach((v) {
        cartDetail!.add(CartDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_amount'] = totalAmount;
    data['shipping_amount'] = shippingAmount;
    data['final_amount'] = finalAmount;
    data['is_checkout'] = isCheckout;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (cartDetail != null) {
      data['cart_detail'] = cartDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDetail {
  int? id;
  int? cartId;
  int? typeOfServiceId;
  int? productId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Product? product;

  CartDetail(
      {this.id,
        this.cartId,
        this.typeOfServiceId,
        this.productId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.product});

  CartDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    typeOfServiceId = json['type_of_service_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = int.parse(json['price'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['type_of_service_id'] = typeOfServiceId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? typeOfServiceId;
  String? name;
  String? description;
  int? price;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? typeOfServiceName;

  Product(
      {this.id,
        this.typeOfServiceId,
        this.name,
        this.description,
        this.price,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.typeOfServiceName});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfServiceId = json['type_of_service_id'];
    name = json['name'];
    description = json['description'];
    price = int.parse(json['price'].toString());
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    typeOfServiceName = json['type_of_service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_of_service_id'] = typeOfServiceId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['type_of_service_name'] = typeOfServiceName;
    return data;
  }
}


//
// class GetCartModel {
//   bool? success;
//   String? message;
//   Data? data;
//
//   GetCartModel({this.success, this.message, this.data});
//
//   GetCartModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   double? totalAmount;
//   int? isCheckout;
//   String? createdAt;
//   String? updatedAt;
//   List<CartDetail>? cartDetail;
//
//   Data(
//       {this.id,
//       this.userId,
//       this.totalAmount,
//       this.isCheckout,
//       this.createdAt,
//       this.updatedAt,
//       this.cartDetail});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     totalAmount = !isNullEmptyOrFalse(json['total_amount'])
//         ? double.parse(json['total_amount'].toString())
//         : null;
//     isCheckout = json['is_checkout'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['cart_detail'] != null) {
//       cartDetail = <CartDetail>[];
//       json['cart_detail'].forEach((v) {
//         cartDetail!.add(CartDetail.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['total_amount'] = totalAmount;
//     data['is_checkout'] = isCheckout;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (cartDetail != null) {
//       data['cart_detail'] = cartDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CartDetail {
//   int? id;
//   int? cartId;
//   int? typeOfServiceId;
//   int? productId;
//   int? quantity;
//   double? price;
//   String? createdAt;
//   String? updatedAt;
//   Product? product;
//
//   CartDetail(
//       {this.id,
//       this.cartId,
//       this.typeOfServiceId,
//       this.productId,
//       this.quantity,
//       this.price,
//       this.createdAt,
//       this.updatedAt,
//       this.product});
//
//   CartDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cartId = json['cart_id'];
//     typeOfServiceId = json['type_of_service_id'];
//     productId = json['product_id'];
//     quantity = json['quantity'];
//     price = double.parse(json['price'].toString());
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     product =
//         json['product'] != null ? Product.fromJson(json['product']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['cart_id'] = cartId;
//     data['type_of_service_id'] = typeOfServiceId;
//     data['product_id'] = productId;
//     data['quantity'] = quantity;
//     data['price'] = price;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (product != null) {
//       data['product'] = product!.toJson();
//     }
//     return data;
//   }
// }
//
// class Product {
//   int? id;
//   int? typeOfServiceId;
//   String? name;
//   String? description;
//   int? price;
//   String? image;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//   String? typeOfServiceName;
//
//   Product(
//       {this.id,
//       this.typeOfServiceId,
//       this.name,
//       this.description,
//       this.price,
//       this.image,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.typeOfServiceName});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     typeOfServiceId = json['type_of_service_id'];
//     name = json['name'];
//     description = json['description'];
//     price = int.parse(json['price'].toString());
//     image = json['image'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     typeOfServiceName = json['type_of_service_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type_of_service_id'] = typeOfServiceId;
//     data['name'] = name;
//     data['description'] = description;
//     data['price'] = price;
//     data['image'] = image;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['type_of_service_name'] = typeOfServiceName;
//     return data;
//   }
// }
