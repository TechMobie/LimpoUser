class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? mobileCountryCode;
  String? mobileNumber;
  String? dateOfBirth;
  String? profilePicture;
  String? rut;
  String? userSessionToken;
  String? deviceToken;
  String? deviceOs;
  String? deviceOsVersion;
  String? deviceModel;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? lastLoginAt;

  Data(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.mobileCountryCode,
      this.mobileNumber,
      this.dateOfBirth,
      this.profilePicture,
      this.rut,
      this.userSessionToken,
      this.deviceToken,
      this.deviceOs,
      this.deviceOsVersion,
      this.deviceModel,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.lastLoginAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobileCountryCode = json['mobile_country_code'];
    mobileNumber = json['mobile_number'];
    dateOfBirth = json['date_of_birth'];
    profilePicture = json['profile_picture'];
    rut = json['rut'];
    userSessionToken = json['user_session_token'];
    deviceToken = json['device_token'];
    deviceOs = json['device_os'];
    deviceOsVersion = json['device_os_version'];
    deviceModel = json['device_model'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLoginAt = json['last_login_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile_country_code'] = mobileCountryCode;
    data['mobile_number'] = mobileNumber;
    data['date_of_birth'] = dateOfBirth;
    data['profile_picture'] = profilePicture;
    data['rut'] = rut;
    data['user_session_token'] = userSessionToken;
    data['device_token'] = deviceToken;
    data['device_os'] = deviceOs;
    data['device_os_version'] = deviceOsVersion;
    data['device_model'] = deviceModel;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_login_at'] = lastLoginAt;
    return data;
  }
}

// class ProfileModel {
//   bool? success;
//   String? message;
//   Data? data;
//
//   ProfileModel({this.success, this.message, this.data});
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
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
//   String? name;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? emailVerifiedAt;
//   String? mobileCountryCode;
//   String? mobileNumber;
//   String? dateOfBirth;
//   String? profilePicture;
//   String? rut;
//   String? userSessionToken;
//   String? deviceToken;
//   String? deviceOs;
//   String? deviceOsVersion;
//   String? deviceModel;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//   String? lastLoginAt;
//
//   Data(
//       {this.id,
//         this.name,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.emailVerifiedAt,
//         this.mobileCountryCode,
//         this.mobileNumber,
//         this.dateOfBirth,
//         this.profilePicture,
//         this.rut,
//         this.userSessionToken,
//         this.deviceToken,
//         this.deviceOs,
//         this.deviceOsVersion,
//         this.deviceModel,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.lastLoginAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     mobileCountryCode = json['mobile_country_code'];
//     mobileNumber = json['mobile_number'];
//     dateOfBirth = json['date_of_birth'];
//     profilePicture = json['profile_picture'];
//     rut = json['rut'];
//     userSessionToken = json['user_session_token'];
//     deviceToken = json['device_token'];
//     deviceOs = json['device_os'];
//     deviceOsVersion = json['device_os_version'];
//     deviceModel = json['device_model'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     lastLoginAt = json['last_login_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['mobile_country_code'] = this.mobileCountryCode;
//     data['mobile_number'] = this.mobileNumber;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['profile_picture'] = this.profilePicture;
//     data['rut'] = this.rut;
//     data['user_session_token'] = this.userSessionToken;
//     data['device_token'] = this.deviceToken;
//     data['device_os'] = this.deviceOs;
//     data['device_os_version'] = this.deviceOsVersion;
//     data['device_model'] = this.deviceModel;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['last_login_at'] = this.lastLoginAt;
//     return data;
//   }
// }
