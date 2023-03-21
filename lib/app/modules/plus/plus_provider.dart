import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';


class PlusProvider extends GetxService {
  logoutUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.logoutUrl,
      body: reqData,
    );
    return response;
  }
  deleteAccount(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.deleteAccountUrl,
      body: reqData,
    );
    return response;
  }

  editProfileUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.editProfileUrl,
      body: reqData,
    );
    return response;
  }

  changePassword(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.changePasswordUrl,
      body: reqData,
    );
    return response;
  }

  contactUs(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.contactUsUrl,
      body: reqData,
    );
    return response;
  }

  lastLogin(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.lastLoginUrl,
      body: reqData,
    );
    return response;
  }

  resendOtpUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.resendOtpUrl,
      body: reqData,
    );
    return response;
  }
  verifyOtpUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.verifyOtpUrl,
      body: reqData,
    );
    return response;
  }
}
