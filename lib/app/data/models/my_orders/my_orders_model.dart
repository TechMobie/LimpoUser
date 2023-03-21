class MyOrderModel {
  bool? success;
  String? message;
  List<Data>? data;

  MyOrderModel({this.success, this.message, this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? pickUpDriverId;
  int? deliverDriverId;
  int? cartId;
  int? userAddressId;
  String? pickupDate;
  String? pickupTime;
  String? deliveryDate;
  String? deliveryTime;
  String? whoWillReceive;
  String? comments;
  int? orderStatusId;
  String? buyOrder;
  String? cardNumber;
  String? accountingDate;
  String? transactionDate;
  int? amount;
  String? paymentStatus;
  String? authorizationCode;
  String? paymentTypeCode;
  String? commerceCode;
  String? response;
  int? isPickUp;
  int? isDeliver;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  List<OrderStatus>? orderStatus;
  List<CustomOrderStatus>? finalOrderStatus = [];
  Cart? cart;
  List<CartDetails>? cartDetails;
  bool? isDetail = true;

  Data(
      {this.id,
      this.userId,
      this.pickUpDriverId,
      this.deliverDriverId,
      this.cartId,
      this.userAddressId,
      this.pickupDate,
      this.pickupTime,
      this.deliveryDate,
      this.deliveryTime,
      this.whoWillReceive,
      this.comments,
      this.orderStatusId,
      this.buyOrder,
      this.cardNumber,
      this.accountingDate,
      this.transactionDate,
      this.amount,
      this.paymentStatus,
      this.authorizationCode,
      this.paymentTypeCode,
      this.commerceCode,
      this.response,
      this.isPickUp,
      this.isDeliver,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.orderStatus,
      this.finalOrderStatus,
      this.cart,
      this.cartDetails,
      this.isDetail = true});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    pickUpDriverId = json['pick_up_driver_id'];
    deliverDriverId = json['deliver_driver_id'];
    cartId = json['cart_id'];
    userAddressId = json['user_address_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    whoWillReceive = json['who_will_receive'];
    comments = json['comments'];
    orderStatusId = json['order_status_id'];
    buyOrder = json['buyOrder'];
    cardNumber = json['cardNumber'];
    accountingDate = json['accountingDate'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
    authorizationCode = json['authorizationCode'];
    paymentTypeCode = json['paymentTypeCode'];
    commerceCode = json['commerceCode'];
    response = json['response'];
    isPickUp = json['is_pick_up'];
    isDeliver = json['is_deliver'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_status'] != null) {
      orderStatus = <OrderStatus>[];
      json['order_status'].forEach((v) {
        orderStatus!.add(OrderStatus.fromJson(v));
      });
    }
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['cart_details'] != null) {
      cartDetails = <CartDetails>[];
      json['cart_details'].forEach((v) {
        cartDetails!.add(CartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['pick_up_driver_id'] = pickUpDriverId;
    data['deliver_driver_id'] = deliverDriverId;
    data['cart_id'] = cartId;
    data['user_address_id'] = userAddressId;
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    data['delivery_date'] = deliveryDate;
    data['delivery_time'] = deliveryTime;
    data['who_will_receive'] = whoWillReceive;
    data['comments'] = comments;
    data['order_status_id'] = orderStatusId;
    data['buyOrder'] = buyOrder;
    data['cardNumber'] = cardNumber;
    data['accountingDate'] = accountingDate;
    data['transactionDate'] = transactionDate;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    data['authorizationCode'] = authorizationCode;
    data['paymentTypeCode'] = paymentTypeCode;
    data['commerceCode'] = commerceCode;
    data['response'] = response;
    data['is_pick_up'] = isPickUp;
    data['is_deliver'] = isDeliver;
    data['is_delete'] = isDelete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.map((v) => v.toJson()).toList();
    }
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (cartDetails != null) {
      data['cart_details'] = cartDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderStatus {
  int? id;
  int? orderId;
  int? orderStatusId;
  String? comment;
  int? adminId;
  int? driverId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? orderStatus;

  OrderStatus(
      {this.id,
      this.orderId,
      this.orderStatusId,
      this.comment,
      this.adminId,
      this.driverId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.orderStatus});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderStatusId = json['order_status_id'];
    comment = json['comment'];
    adminId = json['admin_id'];
    driverId = json['driver_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['order_status_id'] = orderStatusId;
    data['comment'] = comment;
    data['admin_id'] = adminId;
    data['driver_id'] = driverId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order_status'] = orderStatus;
    return data;
  }
}

class CustomOrderStatus {
  String? status;
  int? statusId;
  String? date;
  bool? isOrderStatus;

  CustomOrderStatus(
      {this.date, this.status, this.isOrderStatus, this.statusId});
}

class Cart {
  int? id;
  int? userId;
  double? totalAmount;
  int? isCheckout;
  String? createdAt;
  String? updatedAt;

  Cart(
      {this.id,
      this.userId,
      this.totalAmount,
      this.isCheckout,
      this.createdAt,
      this.updatedAt});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalAmount = double.parse(json['total_amount'].toString());
    isCheckout = json['is_checkout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_amount'] = totalAmount;
    data['is_checkout'] = isCheckout;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CartDetails {
  int? id;
  int? cartId;
  int? typeOfServiceId;
  int? productId;
  int? quantity;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? productName;
  String? typeOfServiceName;

  CartDetails(
      {this.id,
      this.cartId,
      this.typeOfServiceId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.productName,
      this.typeOfServiceName});

  CartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    typeOfServiceId = json['type_of_service_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = double.parse(json['price'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    typeOfServiceName = json['type_of_service_name'];
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
    data['product_name'] = productName;
    data['type_of_service_name'] = typeOfServiceName;
    return data;
  }
}
