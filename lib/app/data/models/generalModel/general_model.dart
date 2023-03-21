class GeneralModel {
  String? message;
  Data? data;

  GeneralModel({this.message, this.data});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  GeneralSetting? generalSetting;
  List<Page>? page;
  List<BannerImage>? bannerImage;

  Data({this.generalSetting, this.page, this.bannerImage});

  Data.fromJson(Map<String, dynamic> json) {
    generalSetting = json['general_setting'] != null
        ? new GeneralSetting.fromJson(json['general_setting'])
        : null;
    if (json['page'] != null) {
      page = <Page>[];
      json['page'].forEach((v) {
        page!.add(new Page.fromJson(v));
      });
    }
    if (json['banner_image'] != null) {
      bannerImage = <BannerImage>[];
      json['banner_image'].forEach((v) {
        bannerImage!.add(new BannerImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalSetting != null) {
      data['general_setting'] = this.generalSetting!.toJson();
    }
    if (this.page != null) {
      data['page'] = this.page!.map((v) => v.toJson()).toList();
    }
    if (this.bannerImage != null) {
      data['banner_image'] = this.bannerImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralSetting {
  int? id;
  int? minimumOrderAmountForFreeShipping;
  int? shippingCost;
  String? facebookLink;
  String? instagramLink;
  String? email;
  String? phoneNumber;
  String? googlePlayLink;
  String? appleStoreLink;
  Null? createdAt;
  String? updatedAt;

  GeneralSetting(
      {this.id,
      this.minimumOrderAmountForFreeShipping,
      this.shippingCost,
      this.facebookLink,
      this.instagramLink,
      this.email,
      this.phoneNumber,
      this.googlePlayLink,
      this.appleStoreLink,
      this.createdAt,
      this.updatedAt});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minimumOrderAmountForFreeShipping =
        json['minimum_order_amount_for_free_shipping'];
    shippingCost = json['shipping_cost'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    googlePlayLink = json['google_play_link'];
    appleStoreLink = json['apple_store_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['minimum_order_amount_for_free_shipping'] =
        this.minimumOrderAmountForFreeShipping;
    data['shipping_cost'] = this.shippingCost;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['google_play_link'] = this.googlePlayLink;
    data['apple_store_link'] = this.appleStoreLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Page {
  int? id;
  String? pageName;
  String? pageDescription;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Page(
      {this.id,
      this.pageName,
      this.pageDescription,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    pageDescription = json['page_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_name'] = this.pageName;
    data['page_description'] = this.pageDescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class BannerImage {
  int? id;
  String? bannerImage;
  int? status;
  int? order;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  BannerImage(
      {this.id,
      this.bannerImage,
      this.status,
      this.order,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  BannerImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImage = json['banner_image'];
    status = json['status'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_image'] = this.bannerImage;
    data['status'] = this.status;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
