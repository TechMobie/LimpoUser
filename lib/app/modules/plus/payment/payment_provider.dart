import 'package:get/get.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/constants.dart';

class PaymentProvider extends GetxService {
  getCard(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.getCard, body: reqData);
    return response;
  }

  deleteCard(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.deleteCard, body: reqData);
    return response;
  }

  editCard(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.editCard, body: reqData);
    return response;
  }

  addCard(reqData) async {
    final response =
        await ApiService.postRequest(ApiConstants.addCard, body: reqData);
    return response;
  }

  createEnrollment(reqData) async {
    final response = await ApiService.postRequest(ApiConstants.createEnrollment,
        body: reqData);
    return response;
  }

  confirmEnrollment(reqData) async {
    final response = await ApiService.postRequest(
        ApiConstants.confirmEnrollment,
        body: reqData);
    return response;
  }

  createTransaction(reqData) async {
    final response = await ApiService.postRequest(
        ApiConstants.createTransaction,
        body: reqData);
    return response;
  }

  confirmTransaction(reqData) async {
    final response = await ApiService.postRequest(
        ApiConstants.confirmTransaction,
        body: reqData);
    return response;
  }
}
