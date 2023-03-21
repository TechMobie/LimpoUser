import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/app/modules/plus/plus_provider.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

class ContactUsController extends GetxController {
final plusProvider = Get.put(PlusProvider());
 RxString? dropDownValue = "".obs;
   RxBool isCommentValid = true.obs;
  RxBool isCommentButtonValid = false.obs;
  RxBool isCategoryValid = true.obs;

TextEditingController addCommentsController = TextEditingController();
FocusNode addCommentsFocusNode = FocusNode();

  Future<void> contactUsApiCall(BuildContext context) async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "category": dropDownValue!.value,
      "comment": addCommentsController.text.trimRight()
    };
    if (kDebugMode) {
      print(reqData);
    }
    final response = await plusProvider.contactUs(reqData);

    if (response['success'] == false) {
      CustomDialogs.getInstance.hideProgressDialog();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
      showDialog(
          context: context,
          builder: (_) => Alertdialog(
              isFullButton: true,
              titleWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    ImageConstants.successPlan,
                    height: 200,
                  ),
                  Text(
                    AppLocalizations.of(context)!.messageSent,
                    style: const TextStyle().normal16,
                  )
                ],
              ),
              contentText: AppLocalizations.of(context)!.weWillContact,
              actionWidget: Text(
                AppLocalizations.of(context)!.returnCaps,
                style: const TextStyle()
                    .size(16)
                    .bold
                    .textColor(ColorSchema.whiteColor),
              ),
              onTap: () {
                Get.back();
                Get.back();
              }));
    }
    if (kDebugMode) {
      print(response);
    }
  }
  
}