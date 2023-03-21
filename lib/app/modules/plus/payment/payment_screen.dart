import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentController = Get.put<PaymentController>(PaymentController());
  EnumForPayment enumForPayment = Get.arguments;
  @override
  void initState() {
    paymentController.getCardApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: getSize(10), right: getSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(20),
              ),
              if (enumForPayment == EnumForPayment.stepsScreen)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
                  child: Text(
                    AppLocalizations.of(context)!.meansOfPayment,
                    maxLines: 2,
                    style: const TextStyle()
                        .semibold24
                        .textColor(ColorSchema.blackColor),
                  ),
                ),
              if (enumForPayment == EnumForPayment.myPaymentScreen)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
                  child: CommonHeader(
                    title: AppLocalizations.of(context)!.meansOfPayment,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              SizedBox(
                height: getSize(30),
              ),
              GetBuilder(
                init: PaymentController(),
                builder: (controller) => (paymentController.isNoCardFound)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(10), vertical: getSize(20)),
                        child: CommonAppButton(
                            text: AppLocalizations.of(context)!.add_card,
                            onTap: () {
                              paymentController.createEnrollmentApiCall();
                            },
                            width: double.infinity,
                            color: ColorSchema.primaryColor,
                            style: const TextStyle()
                                .normal16
                                .textColor(ColorSchema.whiteColor),
                            borderRadius: 5),
                      )
                    : isNullEmptyOrFalse(
                            paymentController.getCardModel.data ?? "")
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : Expanded(
                            child: ListView(
                              children: [
                                ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: paymentController
                                          .getCardModel.data?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CommonContainer(
                                      borderWidth: enumForPayment ==
                                              EnumForPayment.stepsScreen
                                          ? 2
                                          : 1,
                                      borderColor: enumForPayment ==
                                              EnumForPayment.stepsScreen
                                          ? ColorSchema.greenColor
                                          : ColorSchema.grey54Color,
                                      widget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                cardTypeShowImage(),
                                                height: 15,
                                                width: 15,
                                              ),
                                              SizedBox(
                                                width: getSize(10),
                                              ),
                                              Text(
                                                  paymentController
                                                          .getCardModel
                                                          .data?[index]
                                                          .cardNumber
                                                          .toString() ??
                                                      "",
                                                  style: const TextStyle()
                                                      .medium16),
                                              const Spacer(),
                                              CommonButton(
                                                buttonColor:
                                                    ColorSchema.primaryColor,
                                                height: getSize(55),
                                                width: getSize(89),
                                                borderRadius: 5,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .remove,
                                                isIcon: true,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 2,
                                                    color:
                                                        ColorSchema.grey54Color,
                                                    offset: Offset(2.0, 2.0),
                                                  ),
                                                ],
                                                icon: Icons.delete,
                                                textStyle: const TextStyle()
                                                    .medium12
                                                    .textColor(
                                                        ColorSchema.whiteColor),
                                                onTap: () async {
                                                  await paymentController
                                                      .deleteCardApiCall(
                                                          userCardId:
                                                              paymentController
                                                                  .getCardModel
                                                                  .data![index]
                                                                  .id
                                                                  .toString());
                                                  paymentController
                                                      .getCardModel.data!
                                                      .removeAt(index);
                                                  paymentController.update();
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: getSize(10),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  paymentController
                                                      .getCardModel
                                                      .data![index]
                                                      .isDefaultCard = 1;

                                                  await paymentController
                                                      .editCardApiCall(
                                                          userCardId:
                                                              paymentController
                                                                  .getCardModel
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                          isDefaultCard:
                                                              paymentController
                                                                  .getCardModel
                                                                  .data![index]
                                                                  .isDefaultCard);
                                                  paymentController.update();
                                                },
                                                child:
                                                    defaultAndPredeterminedAddress(
                                                        index),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: getSize(10),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getSize(10),
                                      vertical: getSize(20)),
                                  child: CommonAppButton(
                                      text: AppLocalizations.of(context)!
                                          .add_card,
                                      onTap: () {
                                        paymentController
                                            .createEnrollmentApiCall();
                                      },
                                      width: double.infinity,
                                      color: ColorSchema.primaryColor,
                                      style: const TextStyle()
                                          .normal16
                                          .textColor(ColorSchema.whiteColor),
                                      borderRadius: 5),
                                ),
                              ],
                            ),
                          ),
              ),
              GetBuilder(
                init: PaymentController(),
                builder: (controller) {
                  if (enumForPayment == EnumForPayment.stepsScreen &&
                      !isNullEmptyOrFalse(
                          paymentController.getCardModel.data)) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CommonButton(
                        buttonColor: ColorSchema.primaryColor,

                        borderRadius: 5,
                        text: AppLocalizations.of(context)!.continueWithMyOrder,

                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            color: ColorSchema.grey54Color,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                        // icon: Icons.edit_road_outlined,
                        textStyle: const TextStyle()
                            .medium16
                            .textColor(ColorSchema.whiteColor),
                        onTap: () {
                          // if (enumForPayment == EnumForPayment.stepsScreen) {
                          Get.back();
                          // }
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultAndPredeterminedAddress(int index) {
    if (paymentController.getCardModel.data![index].isDefaultCard == 0) {
      return Text(AppLocalizations.of(context)!.setAsDefault,
          style:
              const TextStyle().medium14.textColor(ColorSchema.primaryColor));
    } else {
      return Text(
        AppLocalizations.of(context)!.predetermined,
        style: const TextStyle().medium14.textColor(ColorSchema.greenColor),
      );
    }
  }

  String cardTypeShowImage() {
    if (paymentController.getCardModel.data?[0].cardType.toString() == "Visa") {
      return ImageConstants.visaCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "AmericanExpress") {
      return ImageConstants.americanExpressCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Master card") {
      return ImageConstants.masterCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Diners") {
      return ImageConstants.dinersCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Magna") {
      return ImageConstants.magnaCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "RedCompra") {
      return ImageConstants.redCompraCard;
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "Prepago") {
      return ImageConstants.commonCard;
    }
    return ImageConstants.commonCard;
  }
}
