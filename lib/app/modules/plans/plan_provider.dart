import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class PlanProvider extends GetxService {
  getPlans(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.getPlans, body: reqData);
    return response;
  }

  getTypeOfPlans(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.getTypeOfPlans,
        body: reqData);
    return response;
  }

  checkoutPlan(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.checkoutPlan, body: reqData);
    return response;
  }

  getPlan(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.getPlan, body: reqData);
    return response;
  }

  cancelPlan(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.cancelPlan, body: reqData);
    return response;
  }

  editPlan(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.editPlan, body: reqData);
    return response;
  }
  editOrder(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.editOrder, body: reqData);
    return response;
  }
}
