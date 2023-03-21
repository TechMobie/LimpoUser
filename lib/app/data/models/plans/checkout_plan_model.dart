class CheckOutPlanModel {
  bool? success;
  String? message;
  Data? data;

  CheckOutPlanModel({this.success, this.message, this.data});

  CheckOutPlanModel.fromJson(Map<String, dynamic> json) {
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
  int? planId;
  String? cardNumber;

  Data({this.planId, this.cardNumber});

  Data.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    cardNumber = json['card_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_id'] = planId;
    data['card_number'] = cardNumber;
    return data;
  }
}
