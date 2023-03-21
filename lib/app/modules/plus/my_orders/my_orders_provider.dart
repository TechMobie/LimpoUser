import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class MyOrdersProvider extends GetxService {
  orderDetailsApiCall() async {
    final response =
        await ApiService.postRequest(ApiConstants.getOrderDetails, body: {});
    return response;
  }
}
