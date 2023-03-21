import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class AddressProvider extends GetxService {
  getAddress(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.getAddress, body: reqData);
    return response;
  }

  deleteAddress(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.deleteAddress, body: reqData);
    return response;
  }

  addAddress(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.addAddress, body: reqData);
    return response;
  }

  editAddress(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.editAddress, body: reqData);
    return response;
  }
}
