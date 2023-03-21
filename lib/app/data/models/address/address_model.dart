class AddressModel {
  bool? success;
  String? message;
  List<Data>? data;

  AddressModel({this.success, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
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
  String? addressLabel;
  String? location;
  String? address;
  String? serviceAreaName;
  String? latitude;
  String? longitude;
  int? isDefaultAddress;
  String? createdAt;
  String? updatedAt;
  int? selectedIndexForBorder;

  Data({
    this.id,
    this.userId,
    this.addressLabel,
    this.location,
    this.address,
    this.serviceAreaName,
    this.latitude,
    this.longitude,
    this.isDefaultAddress,
    this.createdAt,
    this.updatedAt,
    this.selectedIndexForBorder,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressLabel = json['address_label'];
    location = json['location'];
    address = json['address'];
    serviceAreaName = json['service_area_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefaultAddress = json['is_default_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_label'] = addressLabel;
    data['location'] = location;
    data['address'] = address;
    data['service_area_name'] = serviceAreaName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default_address'] = isDefaultAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class DefaultAddressModel {
  int? id;
  String? addressLabel;
  String? address;
  String? location;
  int? selectedIndex;
  DefaultAddressModel(
      {this.id, this.addressLabel, this.address, this.selectedIndex});

  DefaultAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressLabel = json['address_label'];
    location = json['location'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_label'] = addressLabel;
    data['location'] = location;
    data['address'] = address;
    return data;
  }
}

// class AddressModel {
//   bool? success;
//   String? message;
//   List<Data>? data;
//
//   AddressModel({this.success, this.message, this.data});
//
//   AddressModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   String? addressLabel;
//   String? location;
//   String? address;
//   String? latitude;
//   String? longitude;
//   int? isDefaultAddress;
//   String? createdAt;
//   String? updatedAt;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.addressLabel,
//         this.location,
//         this.address,
//         this.latitude,
//         this.longitude,
//         this.isDefaultAddress,
//         this.createdAt,
//         this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     addressLabel = json['address_label'];
//     location = json['location'];
//     address = json['address'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     isDefaultAddress = json['is_default_address'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['address_label'] = addressLabel;
//     data['location'] = location;
//     data['address'] = address;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['is_default_address'] = isDefaultAddress;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
