import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/stepper/stepper.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ServiceScreen extends StatelessWidget {
  ServiceScreen({Key? key}) : super(key: key);

  final servicesController = Get.find<ServicesController>();
  final bottomBarScreenController = Get.find<BottomBarController>();
  final washingMachineController = Get.find<MyWashingMachineController>();
  int index1 = 0;

  @override
  Widget build(BuildContext context) {
    // sum();
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (PrefUtils.getInstance.isUserLogin()) {
            CustomDialogs.getInstance.showProgressDialog();
            if (controller.hasClients) {
              currentStep = 0;

              controller.jumpToPage(currentStep);
            }

            await washingMachineController.getCartApiCall();
            bottomBarScreenController.currentIndex.value = 2;
            CustomDialogs.getInstance.hideProgressDialog();
          } else {
            commonGuestDialogue(context);
          }
        },
        child: GetBuilder<ServicesController>(
          init: servicesController,
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: ColorSchema.primaryColor,
                borderRadius: BorderRadius.circular(5)),
            // height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.goToMyWashingMachine,
                    style: const TextStyle()
                        .size(16)
                        .bold
                        .textColor(ColorSchema.whiteColor),
                  ),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                // Text(totalQuantity.value.toString()),
                // const Spacer(),
                Text(
                  formatCurrency.format(double.parse(servicesController
                      .totalPrice
                      .toStringAsFixed(0)
                      .toString())),
                  style: const TextStyle()
                      .bold16
                      .textColor(ColorSchema.whiteColor),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: getSize(16), right: getSize(16), top: getSize(60)),
        child: GetBuilder<ServicesController>(
          init: servicesController,
          builder: (controller) => Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorSchema.blackColor.withOpacity(0.1),
                        offset: const Offset(1, 1))
                  ],
                  color: ColorSchema.whiteColor,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      servicesController.productsServicesModel.data?.length ??
                          0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // behavior: HitTestBehavior.opaque,
                      onTap: () {
                        index1 = index;
                        servicesController.selectedCategories.value = index;
                        servicesController.update();
                      },
                      child: SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                margin: const EdgeInsets.only(bottom: 5),
                                child: SvgPicture.network(
                                  servicesController
                                      .productsServicesModel.data![index].icon
                                      .toString(),
                                  color: servicesController
                                              .selectedCategories.value ==
                                          index
                                      ? ColorSchema.primaryColor
                                      : ColorSchema.blackColor,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text(
                                    servicesController
                                        .productsServicesModel.data![index].name
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: const TextStyle().normal14.textColor(
                                        servicesController
                                                    .selectedCategories.value ==
                                                index
                                            ? ColorSchema.primaryColor
                                            : ColorSchema.blackColor),
                                    // overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              servicesController.showProgress.value
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(
                          color: ColorSchema.blackColor.withOpacity(0.3),
                          height: 10,
                        ),
                        itemCount: servicesController.productsServicesModel
                                .data?[index1].products?.length ??
                            0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            // height: 101,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: SvgPicture.network(servicesController
                                      .productsServicesModel
                                      .data![index1]
                                      .products![index]
                                      .image
                                      .toString()),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          FacebookAppEvents().logViewContent(
                                              id: servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]
                                                  .id
                                                  .toString(),
                                              type: servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .name,
                                              currency: "USD",
                                              content: {
                                                "Description": servicesController
                                                        .productsServicesModel
                                                        .data![index1]
                                                        .products![index]
                                                        .description ??
                                                    ""
                                              },
                                              price: servicesController
                                                      .productsServicesModel
                                                      .data?[index1]
                                                      .products?[index]
                                                      .price
                                                      ?.toDouble() ??
                                                  0.0);

                                          Get.toNamed(Routes.productDetails,
                                              arguments: servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]);
                                        },
                                        child: Text.rich(
                                          TextSpan(
                                            style: const TextStyle()
                                                .medium14
                                                .textColor(
                                                    ColorSchema.blackColor),
                                            children: [
                                              TextSpan(
                                                text: servicesController
                                                        .productsServicesModel
                                                        .data![index1]
                                                        .products![index]
                                                        .name
                                                        .toString() +
                                                    "",
                                              ),
                                              WidgetSpan(
                                                  child: Container(
                                                height: 30,
                                                width: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                //color:Colors.red,
                                                child: const Icon(
                                                  Icons.info_outline,
                                                  color: ColorSchema.greenColor,
                                                  // size: getSize(23),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        formatCurrency.format(servicesController
                                            .productsServicesModel
                                            .data![index1]
                                            .products![index]
                                            .price),
                                        // "\$${}",
                                        style: const TextStyle()
                                            .normal14
                                            .textColor(ColorSchema.greyColor1),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                // const Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (PrefUtils.getInstance
                                            .isUserLogin()) {
                                          if (servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]
                                                  .quantity! >
                                              0) {
                                            servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .quantity = (servicesController
                                                    .productsServicesModel
                                                    .data![index1]
                                                    .products![index]
                                                    .quantity! -
                                                1);
                                            servicesController.totalPrice =
                                                servicesController.totalPrice -
                                                    servicesController
                                                        .productsServicesModel
                                                        .data![index1]
                                                        .products![index]
                                                        .price!;
                                            totalQuentity.value--;
                                            servicesController.addToCartApiCall(
                                              productId: servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]
                                                  .id,
                                              typeOfServiceId:
                                                  servicesController
                                                      .productsServicesModel
                                                      .data![index1]
                                                      .products![index]
                                                      .typeOfServiceId,
                                              quantity: servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]
                                                  .quantity!,
                                            );
                                          }
                                          servicesController.update();
                                        } else {
                                          commonGuestDialogue(context);
                                        }
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
                                      servicesController
                                          .productsServicesModel
                                          .data![index1]
                                          .products![index]
                                          .quantity
                                          .toString(),
                                      style: const TextStyle().medium16,
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (PrefUtils.getInstance
                                            .isUserLogin()) {
                                          servicesController
                                              .productsServicesModel
                                              .data![index1]
                                              .products![index]
                                              .quantity = (servicesController
                                                  .productsServicesModel
                                                  .data![index1]
                                                  .products![index]
                                                  .quantity! +
                                              1);

                                          servicesController.totalPrice =
                                              servicesController.totalPrice +
                                                  servicesController
                                                      .productsServicesModel
                                                      .data![index1]
                                                      .products![index]
                                                      .price!;
                                          totalQuentity.value++;
                                          servicesController.addToCartApiCall(
                                            productId: servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .id,
                                            typeOfServiceId: servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .typeOfServiceId,
                                            quantity: servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .quantity!,
                                          );
                                          if (kDebugMode) {
                                            print(
                                                servicesController.totalPrice);
                                          }

                                          servicesController.update();
                                          FacebookAppEvents().logAddToCart(
                                            id: servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .id
                                                .toString(),
                                            currency: "USD",
                                            price: servicesController
                                                .productsServicesModel
                                                .data![index1]
                                                .products![index]
                                                .price!
                                                .toDouble(),
                                            type: servicesController
                                                    .productsServicesModel
                                                    .data?[index1]
                                                    .name ??
                                                "",
                                            content: {},
                                          );
                                        } else {
                                          commonGuestDialogue(context);
                                        }
                                      },
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        margin: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          color: ColorSchema.greenColor,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
