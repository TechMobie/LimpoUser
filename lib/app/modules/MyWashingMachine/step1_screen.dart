import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step1Screen extends StatelessWidget {
  Step1Screen({
    Key? key,
  }) : super(key: key);

  final myWashingMachineController = Get.find<MyWashingMachineController>();
  final servicesController = Get.find<ServicesController>();
  final bottomBarController = Get.find<BottomBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      bottomNavigationBar: GetBuilder<MyWashingMachineController>(
        init: myWashingMachineController,
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: getSize(20),
            ),
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  bottomBarController.currentIndex.value = 1;
                  servicesController.getProductApiCall();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: ColorSchema.greenColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 13,
                          color: ColorSchema.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getSize(10),
                    ),
                    Text(
                      AppLocalizations.of(context)!.addMoreService,
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: ColorSchema.blackColor.withOpacity(0.3),
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.subtotal,
                ),
                Text(
                  formatCurrency.format(double.parse(myWashingMachineController
                      .grandTotalPrice
                      .toStringAsFixed(0))),
                )
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
                        (myWashingMachineController
                                .generalModel
                                .data
                                ?.generalSetting
                                ?.minimumOrderAmountForFreeShipping ??
                            0)
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
                          (myWashingMachineController
                                  .generalModel
                                  .data
                                  ?.generalSetting
                                  ?.minimumOrderAmountForFreeShipping ??
                              0)
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
          ],
        ),
      ),
      body: GetBuilder<MyWashingMachineController>(
          init: myWashingMachineController,
          builder: (controller) {
            return myWashingMachineController.showProgress.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Divider(
                            color: ColorSchema.blackColor.withOpacity(0.3),
                            height: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: myWashingMachineController
                                  .getCartModel.data?.cartDetail?.length ??
                              0,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                myWashingMachineController.getCartModel.data!
                                    .cartDetail![index].product!.name
                                    .toString(),
                                style: const TextStyle()
                                    .normal14
                                    .textColor(ColorSchema.blackColor),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    myWashingMachineController
                                        .getCartModel
                                        .data!
                                        .cartDetail![index]
                                        .product!
                                        .typeOfServiceName
                                        .toString(),
                                    style: const TextStyle()
                                        .normal10
                                        .textColor(ColorSchema.grey54Color),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getSize(10),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (myWashingMachineController
                                              .getCartModel
                                              .data!
                                              .cartDetail![index]
                                              .quantity! >
                                          0) {
                                        myWashingMachineController
                                                .getCartModel
                                                .data!
                                                .cartDetail![index]
                                                .quantity =
                                            (myWashingMachineController
                                                    .getCartModel
                                                    .data!
                                                    .cartDetail![index]
                                                    .quantity! -
                                                1);

                                        myWashingMachineController
                                                .grandTotalPrice =
                                            (myWashingMachineController
                                                    .grandTotalPrice -
                                                myWashingMachineController
                                                    .getCartModel
                                                    .data!
                                                    .cartDetail![index]
                                                    .product!
                                                    .price!);
                                        totalQuentity.value--;

                                        servicesController.addToCartApiCall(
                                          productId: myWashingMachineController
                                              .getCartModel
                                              .data!
                                              .cartDetail![index]
                                              .productId,
                                          typeOfServiceId:
                                              myWashingMachineController
                                                  .getCartModel
                                                  .data!
                                                  .cartDetail![index]
                                                  .typeOfServiceId,
                                          quantity: myWashingMachineController
                                              .getCartModel
                                              .data!
                                              .cartDetail![index]
                                              .quantity!,
                                        );
                                        FacebookAppEvents().logAddToCart(
                                          id: (myWashingMachineController
                                                      .getCartModel
                                                      .data!
                                                      .cartDetail![index]
                                                      .product!
                                                      .id ??
                                                  "")
                                              .toString(),
                                          currency: "USD",
                                          price: myWashingMachineController
                                              .getCartModel
                                              .data!
                                              .cartDetail![index]
                                              .product!
                                              .price!
                                              .toDouble(),
                                          type: myWashingMachineController
                                                  .getCartModel
                                                  .data!
                                                  .cartDetail![index]
                                                  .product!
                                                  .name ??
                                              "",
                                          content: {},
                                        );
                                        if (myWashingMachineController
                                                .getCartModel
                                                .data!
                                                .cartDetail![index]
                                                .quantity ==
                                            0) {
                                          myWashingMachineController
                                              .getCartModel.data!.cartDetail!
                                              .removeAt(index);
                                        }
                                      }

                                      myWashingMachineController.update();
                                    },
                                    child: Container(
                                        height: 22,
                                        width: 22,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: ColorSchema.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 8,
                                            height: 1,
                                            color: ColorSchema.whiteColor,
                                          ),
                                        )),
                                  ),
                                  Text(
                                    myWashingMachineController.getCartModel
                                        .data!.cartDetail![index].quantity
                                        .toString(),
                                    style: const TextStyle().medium16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myWashingMachineController
                                              .getCartModel
                                              .data!
                                              .cartDetail![index]
                                              .quantity =
                                          (myWashingMachineController
                                                  .getCartModel
                                                  .data!
                                                  .cartDetail![index]
                                                  .quantity! +
                                              1);
                                      myWashingMachineController
                                              .grandTotalPrice =
                                          (myWashingMachineController
                                                  .grandTotalPrice +
                                              myWashingMachineController
                                                  .getCartModel
                                                  .data!
                                                  .cartDetail![index]
                                                  .product!
                                                  .price!);
                                      totalQuentity.value++;

                                      servicesController.addToCartApiCall(
                                        productId: myWashingMachineController
                                            .getCartModel
                                            .data!
                                            .cartDetail![index]
                                            .productId,
                                        typeOfServiceId:
                                            myWashingMachineController
                                                .getCartModel
                                                .data!
                                                .cartDetail![index]
                                                .typeOfServiceId,
                                        quantity: myWashingMachineController
                                            .getCartModel
                                            .data!
                                            .cartDetail![index]
                                            .quantity!,
                                      );
                                      myWashingMachineController.update();
                                    },
                                    child: Container(
                                      height: 22,
                                      width: 22,
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: ColorSchema.greenColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 13,
                                          color: ColorSchema.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    formatCurrency.format(
                                        myWashingMachineController
                                            .getCartModel
                                            .data!
                                            .cartDetail![index]
                                            .product!
                                            .price),
                                    // "\$${myWashingMachineController.getCartModel.data!.cartDetail![index].product!.price.toString()}",
                                    style: const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.grey54Color),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getSize(20),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: ColorSchema.blackColor.withOpacity(0.3),
                          height: 10,
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
