import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class ServicesProvider extends GetxService {
  getProduct(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.getProduct, body: reqData);
    return response;
  }

  getTypeOfProductServices(reqData) async {
    final response = await ApiService.postRequest(
        ApiConstants.getTypeOfServices,
        body: reqData);
    return response;
  }

  addToCartOfServices(reqData) async {
    final response = await ApiService.postRequest(
        ApiConstants.addToCartServices,
        body: reqData);
    return response;
  }
}
