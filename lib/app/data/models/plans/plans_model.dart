// class PlansModel {
//   bool? success;
//   String? message;
//   List<Data>? data;

//   PlansModel({this.success, this.message, this.data});

//   PlansModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }

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

// class Data {
//   int? id;
//   int? typeOfPlanId;
//   String? name;
//   String? description;
//   int? price;
//   String? image;
//   String? monthlyServiceOf;
//   int? status;
//   String? createdAt;
//   String? updatedAt;

//   Data(
//       {this.id,
//       this.typeOfPlanId,
//       this.name,
//       this.description,
//       this.price,
//       this.image,
//       this.monthlyServiceOf,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     typeOfPlanId = json['type_of_plan_id'];
//     name = json['name'];
//     description = json['description'];
//     price = json['price'];
//     image = json['image'];
//     monthlyServiceOf = json['monthly_service_of'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type_of_plan_id'] = typeOfPlanId;
//     data['name'] = name;
//     data['description'] = description;
//     data['price'] = price;
//     data['image'] = image;
//     data['monthly_service_of'] = monthlyServiceOf;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
class PlansModel {
  bool? success;
  String? message;
  Data? data;

  PlansModel({this.success, this.message, this.data});

  PlansModel.fromJson(Map<String, dynamic> json) {
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
  int? isPurchased;
  List<PlanLits>? planLits;

  Data({this.isPurchased, this.planLits});

  Data.fromJson(Map<String, dynamic> json) {
    isPurchased = json['is_purchased'];
    if (json['plan_lits'] != null) {
      planLits = <PlanLits>[];
      json['plan_lits'].forEach((v) {
        planLits!.add(PlanLits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_purchased'] = isPurchased;
    if (planLits != null) {
      data['plan_lits'] = planLits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanLits {
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

  PlanLits(
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

  PlanLits.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_of_plan_id'] = typeOfPlanId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['monthly_service_of'] = monthlyServiceOf;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

