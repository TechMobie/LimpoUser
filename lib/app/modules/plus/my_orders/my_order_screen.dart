import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/plus/my_orders/my_order_controller.dart';
import 'package:linpo_user/app/modules/plus/plus_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrderScreen extends StatelessWidget {
  MyOrderScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final plusController = Get.put<PlusController>(PlusController());
  final myOrderController = Get.put<MyOrderController>(MyOrderController());
  final bottomBarScreenController = Get.find<BottomBarController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: getSize(20),
                    ),
                    CommonHeader(
                      title: AppLocalizations.of(context)!.myOrders,
                    ),
                    SizedBox(
                      height: getSize(10),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder(
                              init: MyOrderController(),
                              builder: (controller) {
                                return (myOrderController.showProgress.value)
                                    ? const Expanded(
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : (isNullEmptyOrFalse(myOrderController
                                            .myOrderModel.data))
                                        ? Expanded(
                                            child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: getSize(10),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .youHaveNoOrder,
                                                style: const TextStyle()
                                                    .medium16
                                                    .textColor(
                                                        ColorSchema.blackColor),
                                              ),
                                              SizedBox(
                                                height: getSize(15),
                                              ),
                                              CommonAppButton(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .placeNewOrder,
                                                  onTap: () {
                                                    bottomBarScreenController
                                                        .currentIndex.value = 1;
                                                    bottomBarScreenController
                                                        .update();
                                                    Get.toNamed(
                                                        Routes.bottomBarScreen);
                                                  },
                                                  width: 200, //double.infinity,
                                                  color:
                                                      ColorSchema.primaryColor,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: ColorSchema
                                                          .grey54Color,
                                                      offset: Offset(2.0, 2.0),
                                                    ),
                                                  ],
                                                  style: const TextStyle()
                                                      .medium16
                                                      .textColor(ColorSchema
                                                          .whiteColor),
                                                  borderRadius: 5),
                                              SizedBox(
                                                height: getSize(15),
                                              ),
                                              SvgPicture.asset(
                                                ImageConstants.limpoTrack,
                                                //  color: ColorSchema.primaryColor,
                                              ),
                                            ],
                                          ))
                                        : Expanded(
                                            child: RefreshIndicator(
                                              onRefresh: () async {
                                                await myOrderController
                                                    .apiCallForGetOrderDetails();
                                                myOrderController.update();
                                              },
                                              child: ListView.separated(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                padding: EdgeInsets.only(
                                                    bottom: getSize(10),
                                                    top: getSize(10)),
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    height: getSize(20),
                                                  );
                                                },
                                                itemCount: myOrderController
                                                        .myOrderModel
                                                        .data
                                                        ?.length ??
                                                    0,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 30),
                                                    width: MathUtilities
                                                        .screenWidth(context),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: ColorSchema
                                                                .primaryColor)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .number,
                                                              style:
                                                                  const TextStyle()
                                                                      .medium19,
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .condition,
                                                              style:
                                                                  const TextStyle()
                                                                      .medium19,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: getSize(10),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              myOrderController
                                                                      .myOrderModel
                                                                      .data?[
                                                                          index]
                                                                      .orderStatus?[
                                                                          0]
                                                                      .orderId
                                                                      .toString() ??
                                                                  "",
                                                              style: const TextStyle()
                                                                  .medium19
                                                                  .textColor(
                                                                      ColorSchema
                                                                          .grey54Color),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              myOrderController
                                                                      .myOrderModel
                                                                      .data?[
                                                                          index]
                                                                      .orderStatus!
                                                                      .last
                                                                      .orderStatus ??
                                                                  "",
                                                              style: const TextStyle()
                                                                  .medium19
                                                                  .textColor(
                                                                      ColorSchema
                                                                          .grey54Color),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: getSize(30),
                                                        ),
                                                        AnimatedCrossFade(
                                                            firstChild:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (kDebugMode) {
                                                                  print(
                                                                      [index]);
                                                                }
                                                                myOrderController
                                                                        .myOrderModel
                                                                        .data?[
                                                                            index]
                                                                        .isDetail =
                                                                    !myOrderController
                                                                        .myOrderModel
                                                                        .data![
                                                                            index]
                                                                        .isDetail!;
                                                                myOrderController
                                                                    .update();
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .detail,
                                                                    style: const TextStyle()
                                                                        .medium19,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        getSize(
                                                                            20),
                                                                  ),
                                                                  Icon(
                                                                    !myOrderController
                                                                            .myOrderModel
                                                                            .data![
                                                                                index]
                                                                            .isDetail!
                                                                        ? CupertinoIcons
                                                                            .chevron_up
                                                                        : CupertinoIcons
                                                                            .chevron_down,
                                                                    size:
                                                                        getSize(
                                                                            18),
                                                                    color: ColorSchema
                                                                        .grey54Color,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            secondChild: Column(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      myOrderController
                                                                          .myOrderModel
                                                                          .data?[
                                                                              index]
                                                                          .isDetail = !myOrderController.myOrderModel.data![index].isDetail!;
                                                                      myOrderController
                                                                          .update();
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .detail,
                                                                          style:
                                                                              const TextStyle().medium19,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              getSize(20),
                                                                        ),
                                                                        Icon(
                                                                          !myOrderController.myOrderModel.data![index].isDetail!
                                                                              ? CupertinoIcons.chevron_up
                                                                              : CupertinoIcons.chevron_down,
                                                                          size:
                                                                              getSize(18),
                                                                          color:
                                                                              ColorSchema.grey54Color,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  ListView
                                                                      .builder(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            20),
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount: myOrderController
                                                                            .myOrderModel
                                                                            .data?[index]
                                                                            .finalOrderStatus
                                                                            ?.length ??
                                                                        0,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index1) {
                                                                      return Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                ImageConstants.checked,
                                                                                color: myOrderController.myOrderModel.data![index].finalOrderStatus![index1].isOrderStatus! ? ColorSchema.greenColor : ColorSchema.grey54Color,
                                                                                height: 20,
                                                                                width: 20,
                                                                              ),
                                                                              if (index1 != 4)
                                                                                Container(
                                                                                  height: 30,
                                                                                  width: 2,
                                                                                  color: myOrderController.myOrderModel.data![index].finalOrderStatus![index1].isOrderStatus! ? ColorSchema.greenColor : ColorSchema.grey54Color,
                                                                                ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  myOrderController.myOrderModel.data![index].finalOrderStatus![index1].status.toString(),
                                                                                  style: const TextStyle().medium19,
                                                                                ),
                                                                                if (myOrderController.myOrderModel.data![index].finalOrderStatus![index1].isOrderStatus!)
                                                                                  Text(
                                                                                    DateUtilities.convertDateTimeForShowPickupAndDelivery(
                                                                                      date: DateTime.parse(myOrderController.myOrderModel.data![index].finalOrderStatus![index1].date.toString()),
                                                                                      dateFormatter: DateUtilities.dd_mmm_yyy_h_mm_a,
                                                                                    ),
                                                                                    style: const TextStyle().normal14.textColor(ColorSchema.grey54Color),
                                                                                  )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        getSize(
                                                                            15),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        0.4,
                                                                    color: ColorSchema
                                                                        .blackColor,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        getSize(
                                                                            15),
                                                                  ),
                                                                  ListView
                                                                      .separated(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount: myOrderController
                                                                            .myOrderModel
                                                                            .data?[index]
                                                                            .cartDetails
                                                                            ?.length ??
                                                                        0,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int indexOfCartDetails) {
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                myOrderController.myOrderModel.data?[index].cartDetails?[indexOfCartDetails].productName.toString() ?? "",
                                                                                style: const TextStyle().normal16,
                                                                              ),
                                                                              const Spacer(),
                                                                              Text(
                                                                                'x ${myOrderController.myOrderModel.data?[index].cartDetails?[indexOfCartDetails].quantity.toString()}',
                                                                                style: const TextStyle().normal16,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                getSize(5),
                                                                          ),
                                                                          Text(
                                                                            myOrderController.myOrderModel.data?[index].cartDetails?[indexOfCartDetails].typeOfServiceName.toString() ??
                                                                                "",
                                                                            style:
                                                                                const TextStyle().normal14.textColor(ColorSchema.grey54Color),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return SizedBox(
                                                                        height:
                                                                            getSize(15),
                                                                      );
                                                                    },
                                                                  )
                                                                ]),
                                                            crossFadeState: myOrderController
                                                                    .myOrderModel
                                                                    .data![
                                                                        index]
                                                                    .isDetail!
                                                                ? CrossFadeState
                                                                    .showFirst
                                                                : CrossFadeState
                                                                    .showSecond,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        700)),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
