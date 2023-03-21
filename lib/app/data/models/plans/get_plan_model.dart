class GetPlanModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetPlanModel({this.success, this.message, this.data});

  GetPlanModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userPlanId;
  int? userId;
  int? planId;
  int? typeOfPlanId;
  int? userAddressId;
  int? userCardId;
  String? comments;
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
  String? startDate;
  String? endDate;
  int? isRenewal;
  String? renewalDate;
  int? isCancel;
  String? cancelAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Plan? plan;
  Address? address;
  List<Orders>? orders;
  bool? isMyDetail = false;

  Data(
      {this.id,
      this.userPlanId,
      this.userId,
      this.planId,
      this.typeOfPlanId,
      this.userAddressId,
      this.userCardId,
      this.comments,
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
      this.startDate,
      this.endDate,
      this.isRenewal,
      this.renewalDate,
      this.isCancel,
      this.cancelAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.plan,
      this.address,
      this.orders,
      this.isMyDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userPlanId = json['user_plan_id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    typeOfPlanId = json['type_of_plan_id'];
    userAddressId = json['user_address_id'];
    userCardId = json['user_card_id'];
    comments = json['comments'];
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
    startDate = json['start_date'];
    endDate = json['end_date'];
    isRenewal = json['is_renewal'];
    renewalDate = json['renewal_date'];
    isCancel = json['is_cancel'];
    cancelAt = json['cancel_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_plan_id'] = this.userPlanId;
    data['user_id'] = this.userId;
    data['plan_id'] = this.planId;
    data['type_of_plan_id'] = this.typeOfPlanId;
    data['user_address_id'] = this.userAddressId;
    data['user_card_id'] = this.userCardId;
    data['comments'] = this.comments;
    data['buyOrder'] = this.buyOrder;
    data['cardNumber'] = this.cardNumber;
    data['accountingDate'] = this.accountingDate;
    data['transactionDate'] = this.transactionDate;
    data['amount'] = this.amount;
    data['payment_status'] = this.paymentStatus;
    data['authorizationCode'] = this.authorizationCode;
    data['paymentTypeCode'] = this.paymentTypeCode;
    data['commerceCode'] = this.commerceCode;
    data['response'] = this.response;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_real'] = this.isRenewal;
    data['renewal_date'] = this.renewalDate;
    data['is_cancel'] = this.isCancel;
    data['cancel_at'] = this.cancelAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  int? id;
  int? typeOfPlanId;
  String? name;
  String? description;
  int? price;
  String? image;
  String? monthlyServiceOf;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Plan(
      {this.id,
      this.typeOfPlanId,
      this.name,
      this.description,
      this.price,
      this.image,
      this.monthlyServiceOf,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfPlanId = json['type_of_plan_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    monthlyServiceOf = json['monthly_service_of'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type_of_plan_id'] = this.typeOfPlanId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['monthly_service_of'] = this.monthlyServiceOf;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  String? addressLabel;
  String? location;
  String? address;
  String? latitude;
  String? longitude;
  String? serviceAreaName;
  int? isDefaultAddress;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Address(
      {this.id,
      this.userId,
      this.addressLabel,
      this.location,
      this.address,
      this.latitude,
      this.longitude,
      this.serviceAreaName,
      this.isDefaultAddress,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressLabel = json['address_label'];
    location = json['location'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceAreaName = json['service_area_name'];
    isDefaultAddress = json['is_default_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address_label'] = this.addressLabel;
    data['location'] = this.location;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['service_area_name'] = this.serviceAreaName;
    data['is_default_address'] = this.isDefaultAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Orders {
  int? id;
  int? userId;
  int? userPlanId;
  int? pickUpDriverId;
  String? pickUpDriverAssignDate;
  int? deliverDriverId;
  String? deliverDriverAssignDate;
  int? cartId;
  int? userAddressId;
  int? userCardId;
  String? pickupDate;
  String? pickupTime;
  String? deliveryDate;
  String? deliveryTime;
  String? whoWillReceive;
  String? comments;
  int? orderStatusId;
  int? isPickUp;
  int? isDeliver;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Orders(
      {this.id,
      this.userId,
      this.userPlanId,
      this.pickUpDriverId,
      this.pickUpDriverAssignDate,
      this.deliverDriverId,
      this.deliverDriverAssignDate,
      this.cartId,
      this.userAddressId,
      this.userCardId,
      this.pickupDate,
      this.pickupTime,
      this.deliveryDate,
      this.deliveryTime,
      this.whoWillReceive,
      this.comments,
      this.orderStatusId,
      this.isPickUp,
      this.isDeliver,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userPlanId = json['user_plan_id'];
    pickUpDriverId = json['pick_up_driver_id'];
    pickUpDriverAssignDate = json['pick_up_driver_assign_date'];
    deliverDriverId = json['deliver_driver_id'];
    deliverDriverAssignDate = json['deliver_driver_assign_date'];
    cartId = json['cart_id'];
    userAddressId = json['user_address_id'];
    userCardId = json['user_card_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    whoWillReceive = json['who_will_receive'];
    comments = json['comments'];
    orderStatusId = json['order_status_id'];
    isPickUp = json['is_pick_up'];
    isDeliver = json['is_deliver'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_plan_id'] = this.userPlanId;
    data['pick_up_driver_id'] = this.pickUpDriverId;
    data['pick_up_driver_assign_date'] = this.pickUpDriverAssignDate;
    data['deliver_driver_id'] = this.deliverDriverId;
    data['deliver_driver_assign_date'] = this.deliverDriverAssignDate;
    data['cart_id'] = this.cartId;
    data['user_address_id'] = this.userAddressId;
    data['user_card_id'] = this.userCardId;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    data['who_will_receive'] = this.whoWillReceive;
    data['comments'] = this.comments;
    data['order_status_id'] = this.orderStatusId;
    data['is_pick_up'] = this.isPickUp;
    data['is_deliver'] = this.isDeliver;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
