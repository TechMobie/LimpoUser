import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class MyWashingMachineProvider extends GetxService {
  getCart(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.getCart, body: reqData);
    return response;
  }
 
checkOut(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.checkOut, body: reqData);
    return response;
  }
generalSetting(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.generalSetting, body: reqData);
    return response;
  }
}
