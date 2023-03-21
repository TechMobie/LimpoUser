import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'math_utils.dart';

final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
bool hideReturn = false;
//check null, empty or false.
bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

// use to capitalize string
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
showToast({String? msg = "", Color? color}) {
  return Get.snackbar(
    "Limpo",
    msg!,
    backgroundColor: color ?? ColorSchema.blackColor.withOpacity(0.2),
    snackPosition: SnackPosition.TOP,
  );
  // return Fluttertoast.showToast(
  //     msg: msg!,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: ColorConstants.buttonColor.withOpacity(0.4),
  //     textColor: ColorConstants.whiteColor,
  //     fontSize: 16.0);
}

Future<dynamic> commonGuestDialogue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => Alertdialog(
          isFullButton: false,
          contentText: AppLocalizations.of(context)!.youNeedFeature,
          actionWidget: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(AppLocalizations.of(context)!.cancelCaps,
                    style: const TextStyle().medium19),
              ),
              TextButton(
                onPressed: () {
                  hideReturn = true;
                  Get.offAllNamed(Routes.signIn);
                },
                child: Text(AppLocalizations.of(context)!.logInText,
                    style: const TextStyle().medium19),
              ),
            ],
          ),
          onTap: () {}));
}

class ProgressDialog2 {
  static Future<void> showLoadingDialog(
      {bool isBarrierDismissible = false}) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return isBarrierDismissible;
            },
            child: const Center(
                // child:  Image(image: AssetImage("assets/loader.gif",),height: 50,width: 50,),
                child: CircularProgressIndicator(
              color: ColorSchema.primaryColor,
            )));
        // ));
      },
    );
  }
}

// class ProgressDialog2 {
//   static Future<void> showLoadingDialog(BuildContext context,
//       {bool isCancellable = true}) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: isCancellable,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           content: Builder(builder: (context) {
//             return WillPopScope(
//               onWillPop: () async {
//                 return isCancellable;
//               },
//               // child: SpinKitThreeBounce(
//               //   color: ColorConstants.whiteColor,
//               //   size: 50.0,
//               // ),
//               child: SizedBox(
//                 height: 40.0,
//                 width: 40.0,
//                 child: Image.asset(
//                   "assets/loader.gif",
//                   height: 40.0,
//                   width: 40.0,
//                 ),
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }

class CustomDialogs {
  static CustomDialogs? _shared;

  CustomDialogs._();

  static CustomDialogs get getInstance =>
      _shared = _shared ?? CustomDialogs._();

  showCircularIndicator(
    BuildContext context, {
    double size = 40.0,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/loader.gif",
          height: size,
          width: size,
        ),
      ],
    );
  }

  void showProgressDialog() {
    ProgressDialog2.showLoadingDialog(isBarrierDismissible: false);
  }

  void hideProgressDialog() {
    Get.back();
  }
}

// showToast({
//   String? msg,
//   ToastGravity? gravity,
//   int timer = 2000,
// }) {
//   if (kDebugMode) {
//     FToast().init(Get.overlayContext!);
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           40,
//         ),
//         color: ColorSchema.primaryColor.withOpacity(0.5),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             msg ?? "",
//             style: const TextStyle(
//               color: ColorSchema.whiteColor,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );

//     FToast().showToast(
//       child: toast,
//       gravity: gravity ?? ToastGravity.BOTTOM,
//       toastDuration: Duration(
//         milliseconds: timer,
//       ),
//     );
//   }
// }

commonDivider() {
  return const Divider(
    color: ColorSchema.blackColor,
    thickness: 1,
    height: 0,
  );
}

String getUserRole() {
  return GetStorage().read("userDetails")['role'];
}

Container commonRetirementandOffice(
    {String? title, String? date, String? time, void Function()? onTap}) {
  return Container(
    margin: EdgeInsets.only(top: getSize(15)),
    width: double.infinity,
    // height: getSize(100),
    decoration:
        BoxDecoration(border: Border.all(color: ColorSchema.grey38Color)),
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: const TextStyle().medium16,
            ),
            SizedBox(
              height: getSize(5),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          date!,
                          style: const TextStyle()
                              .medium16
                              .textColor(ColorSchema.primaryColor),
                        ),
                        SizedBox(
                          width: getSize(5),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: getSize(5)),
                          height: 18,
                          width: 18,
                          color: ColorSchema.greenColor,
                          child: Icon(
                            Icons.edit,
                            color: ColorSchema.whiteColor,
                            size: getSize(12),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      time!,
                      style: const TextStyle()
                          .normal16
                          .textColor(ColorSchema.grey54Color),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

paymentDialogueBox() {
  return showDialog(
      context: Get.context!,
      builder: (_) => Alertdialog(
          isFullButton: true,
          titleWidget: Text(
            AppLocalizations.of(Get.context!)!.noRegisterCard,
            style: const TextStyle().normal18,
          ),
          contentText:
              AppLocalizations.of(Get.context!)!.youMustRegisterPurchase,
          contentTextStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          actionWidget: Text(
            AppLocalizations.of(Get.context!)!.closeCaps,
            style: const TextStyle().medium16.textColor(ColorSchema.whiteColor),
          ),
          onTap: () {
            Get.back();
            //Get.back();
          }));
}

addressDialogueBox() {
  return showDialog(
      context: Get.context!,
      builder: (_) => Alertdialog(
          isFullButton: true,
          titleWidget: Text(
            AppLocalizations.of(Get.context!)!.noAddressFound,
            style: const TextStyle().normal18,
          ),
          contentText: AppLocalizations.of(Get.context!)!.youMustAdd,
          contentTextStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          actionWidget: Text(
            AppLocalizations.of(Get.context!)!.closeCaps,
            style: const TextStyle().medium16.textColor(ColorSchema.whiteColor),
          ),
          onTap: () {
            Get.back();
            //Get.back();
          }));
}

addMobileNumberDialogueBox() {
  return showDialog(
      context: Get.context!,
      builder: (_) => Alertdialog(
          isFullButton: true,
          titleWidget: Text(
            AppLocalizations.of(Get.context!)!.noMobileNumberFound,
            style: const TextStyle().normal18,
          ),
          contentText:
              AppLocalizations.of(Get.context!)!.noMobileNumberFoundContain,
          contentTextStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          actionWidget: Text(
            AppLocalizations.of(Get.context!)!.closeCaps,
            style: const TextStyle().medium16.textColor(ColorSchema.whiteColor),
          ),
          onTap: () {
            Get.back();
            //Get.back();
          }));
}

commentDialogueBox() {
  return showDialog(
      context: Get.context!,
      builder: (_) => Alertdialog(
          isFullButton: true,
          titleWidget: Text(
            "No Comment Found",
            //AppLocalizations.of(Get.context!)!.noRegisterCard,
            style: const TextStyle().normal18,
          ),
          contentText: "You must add a comment to continue with your purchase.",
          //  AppLocalizations.of(Get.context!)!.youMustRegisterPurchase,
          contentTextStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          actionWidget: Text(
            AppLocalizations.of(Get.context!)!.closeCaps,
            style: const TextStyle().medium16.textColor(ColorSchema.whiteColor),
          ),
          onTap: () {
            Get.back();
            //Get.back();
          }));
}

termsAndConditionDialogueBox() {
  return showToast(
      msg: AppLocalizations.of(Get.context!)!.pleaseConditions,
      color: ColorSchema.redColor.withOpacity(0.5));
}
