class GetCardModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetCardModel({this.success, this.message, this.data});

  GetCardModel.fromJson(Map<String, dynamic> json) {
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
  String? tbkUser;
  String? authorizationCode;
  String? cardType;
  String? cardNumber;
  int? isDefaultCard;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.tbkUser,
      this.authorizationCode,
      this.cardType,
      this.cardNumber,
      this.isDefaultCard,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tbkUser = json['tbk_user'];
    authorizationCode = json['authorization_code'];
    cardType = json['card_type'];
    cardNumber = json['card_number'];
    isDefaultCard = json['is_default_card'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['tbk_user'] = tbkUser;
    data['authorization_code'] = authorizationCode;
    data['card_type'] = cardType;
    data['card_number'] = cardNumber;
    data['is_default_card'] = isDefaultCard;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
