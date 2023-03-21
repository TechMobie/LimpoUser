import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';


class AuthProvider extends GetxService {
  loginUser(reqData) async {
        final response = await ApiService.postRequest(
          ApiConstants.loginUrl,
          body: reqData,
        );
      return response;
  }

  signUpUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.registerUrl,
      body: reqData,
    );
    return response;
  }

  forgotPasswordUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.forgotPasswordUrl,
      body: reqData,
    );
    return response;
  }

  resetPasswordUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.resetPasswordUrl,
      body: reqData,
    );
    return response;
  }
}
