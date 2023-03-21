class CheckOutModel {
  bool? success;
  String? message;
  Data? data;

  CheckOutModel({this.success, this.message, this.data});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
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
  int? orderId;
  String? cardNumber;

  Data({this.orderId, this.cardNumber});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    cardNumber = json['card_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['card_number'] = cardNumber;
    return data;
  }
}
