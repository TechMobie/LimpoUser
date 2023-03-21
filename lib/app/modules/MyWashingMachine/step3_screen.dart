import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step3Screen extends StatelessWidget {
  Step3Screen({Key? key}) : super(key: key);

  final myWashingMachineController = Get.find<MyWashingMachineController>();
  final paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.subtotal,
                  ),
                  Text(formatCurrency.format(double.parse(
                      myWashingMachineController.grandTotalPrice
                          .toStringAsFixed(0))))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      myWashingMachineController.getGeneralSettingApiCall();
                      Get.toNamed(Routes.shipmentScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.shipment,
                        style: const TextStyle()
                            .normal14
                            .textColor(ColorSchema.blackColor),
                        children: const [
                          TextSpan(
                            text: " ",
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.info_outline,
                              color: ColorSchema.greenColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  myWashingMachineController.grandTotalPrice >=
                          myWashingMachineController
                              .generalModel
                              .data!
                              .generalSetting!
                              .minimumOrderAmountForFreeShipping!
                      ? const Text("\$0")
                      : Text(
                          "\$${myWashingMachineController.generalModel.data!.generalSetting!.shippingCost}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    style: const TextStyle()
                        .medium16
                        .textColor(ColorSchema.blackColor),
                  ),
                  Text(
                    myWashingMachineController.grandTotalPrice >=
                            myWashingMachineController
                                .generalModel
                                .data!
                                .generalSetting!
                                .minimumOrderAmountForFreeShipping!
                        ? formatCurrency.format(double.parse(
                            myWashingMachineController.grandTotalPrice
                                .toStringAsFixed(0)))
                        : formatCurrency.format(myWashingMachineController
                                .generalModel
                                .data!
                                .generalSetting!
                                .shippingCost! +
                            int.parse(myWashingMachineController.grandTotalPrice
                                .toStringAsFixed(0))),
                    style: const TextStyle()
                        .medium16
                        .textColor(ColorSchema.blackColor),
                  )
                ],
              ),
              SizedBox(
                height: getSize(20),
              ),
              Text(
                AppLocalizations.of(context)!.paymentMethods,
                style: const TextStyle()
                    .medium16
                    .copyWith(color: ColorSchema.lightBlueColor),
              ),
              Divider(
                color: ColorSchema.lightBlueColor,
                thickness: getSize(2),
              ),
              SizedBox(
                height: getSize(10),
              ),
              GetBuilder<PaymentController>(
                init: paymentController,
                builder: (controller) => Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: paymentController.isShowOnePay.value
                            ? ColorSchema.primaryColor
                            : ColorSchema.greyColor30,
                      )),
                  child: AnimatedCrossFade(
                    firstChild: showFirstChild(context),
                    secondChild: Column(
                      children: [
                        Column(
                          children: [
                            showFirstChild(context),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 0, left: 14, right: 14),
                              child: !isNullEmptyOrFalse(
                                      paymentController.getCardModel.data)
                                  ? CommonContainer(
                                      borderColor: ColorSchema.grey54Color,
                                      widget: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.paymentScreen,
                                              arguments:
                                                  EnumForPayment.stepsScreen);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  cardType(),
                                                  height: 15,
                                                  width: 15,
                                                ),
                                                SizedBox(
                                                  width: getSize(20),
                                                ),
                                                Text(
                                                    paymentController
                                                            .getCardModel
                                                            .data?[0]
                                                            .cardNumber
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle()
                                                        .size(14)
                                                        .bold),
                                                const Spacer(),
                                                Container(
                                                  height: 18,
                                                  width: 18,
                                                  color: ColorSchema.greenColor,
                                                  child: SvgPicture.asset(
                                                    ImageConstants.edit,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getSize(10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.paymentScreen,
                                                arguments:
                                                    EnumForPayment.stepsScreen);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add_box_rounded,
                                                color: ColorSchema.greenColor,
                                                size: getSize(35),
                                              ),
                                              SizedBox(
                                                width: getSize(10),
                                              ),
                                              Flexible(
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .managePaymentMethods,
                                                    style: const TextStyle()
                                                        .medium16),
                                              ),
                                              // const Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ],
                    ),
                    crossFadeState: paymentController.isShowOnePay.value
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 600),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<PaymentController>(
                init: paymentController,
                initState: (_) {},
                builder: (_) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (paymentController.isShowOnePay.value) {
                        paymentController.isShowOnePay.value = false;
                        paymentController.update();
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: !paymentController.isShowOnePay.value
                                ? ColorSchema.primaryColor
                                : ColorSchema.greyColor30,
                          ),
                        ),
                        child: Row(children: [
                          Image.asset(
                            ImageConstants.card,
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.cards,
                                  style: const TextStyle().bold16),
                              Text(
                                AppLocalizations.of(context)!.cardsDescription,
                                style: const TextStyle()
                                    .medium12
                                    .copyWith(color: ColorSchema.grey54Color),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          // Checkbox(
                          //   value: paymentController.isShowOnePay.value,
                          //   onChanged: (value) {
                          //     if (!paymentController.isShowOnePay.value) {
                          //       paymentController.isShowOnePay.value = true;
                          //       paymentController.update();
                          //     }
                          //   },
                          // )
                        ])),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showFirstChild(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!paymentController.isShowOnePay.value) {
          paymentController.isShowOnePay.value = true;
          paymentController.update();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Image.asset(
              ImageConstants.qrCode,
              height: 22,
              width: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.onepay,
                    style: const TextStyle(height: 1).bold16),
                // Text('transbank',
                //     style: const TextStyle().medium10),
                Text(
                  AppLocalizations.of(context)!.onepayDescription,
                  style: const TextStyle()
                      .medium12
                      .copyWith(color: ColorSchema.grey54Color),
                ),
              ],
            ),
            // const Spacer(),
            // Checkbox(
            //   value: !paymentController.isShowOnePay.value,
            //   onChanged: (value) {

            //   },
            // ),
          ],
        ),
      ),
    );
  }

  String cardType() {
    if (paymentController.getCardModel.data?[0].cardType.toString() == "Visa") {
      return ImageConstants.visaCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "AmericanExpress") {
      return ImageConstants.americanExpressCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Diners") {
      return ImageConstants.americanExpressCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Magna") {
      return ImageConstants.americanExpressCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Redcompra") {
      return ImageConstants.americanExpressCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Prepaid") {
      return ImageConstants.americanExpressCard;
    } else {
      return ImageConstants.masterCard;
    }
  }
}
