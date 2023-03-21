class ProductsServicesModel {
  bool? success;
  String? message;
  List<Data>? data;

  ProductsServicesModel({this.success, this.message, this.data});

  ProductsServicesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  Data(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? typeOfServiceId;
  String? name;
  String? description;
  int? price;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? quantity;

  Products(
      {this.id,
      this.typeOfServiceId,
      this.name,
      this.description,
      this.price,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfServiceId = json['type_of_service_id'];
    name = json['name'];
    description = json['description'];
    price = int.parse(json['price'].toString());
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
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
    data['quantity'] = quantity;
    return data;
  }
}
