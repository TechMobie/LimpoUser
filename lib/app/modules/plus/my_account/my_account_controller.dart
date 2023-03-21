import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/data/services/api_service/api_service.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class MyAccountController extends GetxController {
  TextEditingController myNameController = TextEditingController();
  FocusNode myNameFocusNode = FocusNode();

  TextEditingController myLastNameController = TextEditingController();
  FocusNode myLastNameFocusNode = FocusNode();

  TextEditingController myEmailController = TextEditingController();
  FocusNode myEmailFocusNode = FocusNode();

  TextEditingController myPhoneNumberController = TextEditingController();
  FocusNode myPhoneNumberFocusNode = FocusNode();

  TextEditingController myDobController = TextEditingController();
  FocusNode myDobFocusNode = FocusNode();

  TextEditingController myRutController = TextEditingController();
  FocusNode myRutFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();

  RxBool isNameValid = true.obs;
  RxBool isLastNameValid = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPhoneNumberValid = true.obs;
  // RxBool isDobValid = true.obs;
  RxBool isRutValid = true.obs;

  RxBool isNameButtonValid = false.obs;
  RxBool isLastNameButtonValid = false.obs;
  RxBool isEmailButtonValid = false.obs;
  RxBool isPhoneNumberButtonValid = false.obs;
  RxBool isDobButtonValid = false.obs;
  RxBool isRutButtonValid = false.obs;
  RxBool isEdit = false.obs;
  final globalController = Get.find<GlobalController>();
  Future<void> editProfileApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "first_name": myNameController.text.trimRight(),
      "last_name": myLastNameController.text.trimRight(),
      "email": myEmailController.text.trimRight(),
      "mobile_country_code": "+91",
      if (!isNullEmptyOrFalse(myPhoneNumberController.text))
        "mobile_number": myPhoneNumberController.text.trimRight(),
      "date_of_birth": myDobController.text.trimRight(),
      "rut": !isNullEmptyOrFalse(myRutController.text)
          ? myRutController.text.trimRight()
          : "",
    };
    final response = await ApiService.postRequest(
      ApiConstants.editProfileUrl,
      body: reqData,
    );
    CustomDialogs.getInstance.hideProgressDialog();

    if (response['success'] == false) {
      showToast(
        msg: response['error'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );

      globalController.profileModel.data?.firstName =
          response['data']['first_name'];
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.greenColor.withOpacity(0.3),
      );
      isEdit.value = false;
    }
    if (kDebugMode) {
      print(response);
    }
    globalController.update();
    update();
  }



  @override
  void onInit() {
    globalController.profileModel =
        ProfileModel.fromJson(PrefUtils.getInstance.readData(
      PrefUtils.getInstance.profile,
    ));

    myNameController.text =
        globalController.profileModel.data!.firstName.toString();
    myLastNameController.text =
        globalController.profileModel.data!.lastName.toString();
    myEmailController.text = globalController.profileModel.data!.email.toString();
    myPhoneNumberController.text =
        globalController.profileModel.data?.mobileNumber ?? "";
    myDobController.text = globalController.profileModel.data?.dateOfBirth ?? "";
    myRutController.text = globalController.profileModel.data?.rut ?? "";
    isNameButtonValid.value = true;
    isLastNameButtonValid.value = true;
    isEmailButtonValid.value = true;
    isPhoneNumberButtonValid.value = true;
    isDobButtonValid.value = true;
    isNameValid.value = true;
    isLastNameValid.value = true;
    isEmailValid.value = true;
    isPhoneNumberValid.value = true;
    isRutValid.value = true;
    super.onInit();
  }
}
