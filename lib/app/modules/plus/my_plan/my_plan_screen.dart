import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'my_plan_controller.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({Key? key}) : super(key: key);

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  final formKey = GlobalKey<FormState>();

  final myPlanController = Get.put<MyPlanController>(MyPlanController());

  final myAddressController = Get.find<MyAddressController>();

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
                        title: AppLocalizations.of(context)!.myPlan,
                      ),
                      SizedBox(
                        height: getSize(40),
                      ),
                      GetBuilder(
                          init: MyPlanController(),
                          builder: (controller) {
                            return (myPlanController.showProgress1.value)
                                ? const Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : isNullEmptyOrFalse(
                                        myPlanController.getPlanModel.data)
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: getSize(10),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .youHaveNoPlan,
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
                                                    .contractPlan,
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes.ourPlanScreen);
                                                },
                                                width: double.infinity,
                                                color: ColorSchema.primaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 2,
                                                    color:
                                                        ColorSchema.grey54Color,
                                                    offset: Offset(2.0, 2.0),
                                                  ),
                                                ],
                                                style: const TextStyle()
                                                    .medium16
                                                    .textColor(
                                                        ColorSchema.whiteColor),
                                                borderRadius: 5),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              height: getSize(20),
                                            );
                                          },
                                          shrinkWrap: true,
                                          itemCount: myPlanController
                                                  .getPlanModel.data?.length ??
                                              0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CommonContainer(
                                              borderColor:
                                                  ColorSchema.grey54Color,
                                              widget: SingleChildScrollView(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.network(
                                                              myPlanController
                                                                  .getPlanModel
                                                                  .data![index]
                                                                  .plan!
                                                                  .image
                                                                  .toString()),
                                                          SizedBox(
                                                            width: getSize(20),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .plan!
                                                                          .name
                                                                          .toString() ??
                                                                      "",
                                                                  style: const TextStyle()
                                                                      .medium19,
                                                                ),
                                                                Text(
                                                                  "${formatCurrency.format(myPlanController.getPlanModel.data?[index].plan!.price)} / ${AppLocalizations.of(context)!.month}",
                                                                  style: const TextStyle()
                                                                      .medium19
                                                                      .textColor(
                                                                          ColorSchema
                                                                              .blackColor),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: getSize(20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .monthlyServiceOf,
                                                        style: const TextStyle()
                                                            .normal18
                                                            .textColor(
                                                                ColorSchema
                                                                    .blackColor),
                                                      ),
                                                    ),
                                                    Html(
                                                      data: myPlanController
                                                          .getPlanModel
                                                          .data?[index]
                                                          .plan!
                                                          .monthlyServiceOf
                                                          .toString(),
                                                      style: {
                                                        "p": Style(
                                                          margin: Margins.zero,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          fontSize:
                                                              FontSize.xLarge,
                                                          letterSpacing: 0.0,
                                                        )
                                                      },
                                                    ),
                                                    Html(
                                                      data: myPlanController
                                                          .getPlanModel
                                                          .data?[index]
                                                          .plan!
                                                          .description
                                                          .toString(),
                                                      style: {
                                                        "p": Style(
                                                          fontSize:
                                                              FontSize.medium,
                                                          letterSpacing: 0.0,
                                                        )
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    AnimatedCrossFade(
                                                        firstChild:
                                                            GestureDetector(
                                                          onTap: () {
                                                            myPlanController
                                                                    .getPlanModel
                                                                    .data![index]
                                                                    .isMyDetail =
                                                                !myPlanController
                                                                    .getPlanModel
                                                                    .data![
                                                                        index]
                                                                    .isMyDetail!;
                                                            myPlanController
                                                                .update();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10),
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
                                                                  myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .isMyDetail!
                                                                      ? CupertinoIcons
                                                                          .chevron_up
                                                                      : CupertinoIcons
                                                                          .chevron_down,
                                                                  size: getSize(
                                                                      18),
                                                                  color: ColorSchema
                                                                      .grey54Color,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        secondChild: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10,
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .isMyDetail =
                                                                      !myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .isMyDetail!;
                                                                  myPlanController
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
                                                                      myPlanController
                                                                              .getPlanModel
                                                                              .data![
                                                                                  index]
                                                                              .isMyDetail!
                                                                          ? CupertinoIcons
                                                                              .chevron_up
                                                                          : CupertinoIcons
                                                                              .chevron_down,
                                                                      size: getSize(
                                                                          18),
                                                                      color: ColorSchema
                                                                          .grey54Color,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(20),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .startQ,
                                                                    style: const TextStyle()
                                                                        .medium16,
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                      DateUtilities
                                                                          .convertDateTimeForShowPickupAndDelivery(
                                                                        date: DateTime.parse(myPlanController
                                                                            .getPlanModel
                                                                            .data![index]
                                                                            .startDate
                                                                            .toString()),
                                                                        dateFormatter:
                                                                            DateUtilities.ddmmyyyy,
                                                                      ),
                                                                      style: const TextStyle()
                                                                          .medium16
                                                                          .textColor(
                                                                              ColorSchema.primaryColor)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(7),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .expiration,
                                                                    style: const TextStyle()
                                                                        .medium16,
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                      DateUtilities
                                                                          .convertDateTimeForShowPickupAndDelivery(
                                                                        date: DateTime.parse(myPlanController
                                                                            .getPlanModel
                                                                            .data![index]
                                                                            .endDate
                                                                            .toString()),
                                                                        dateFormatter:
                                                                            DateUtilities.ddmmyyyy,
                                                                      ),
                                                                      style: const TextStyle()
                                                                          .medium16
                                                                          .textColor(
                                                                              ColorSchema.primaryColor)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(7),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .renewal,
                                                                    style: const TextStyle()
                                                                        .medium16,
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                      DateUtilities
                                                                          .convertDateTimeForShowPickupAndDelivery(
                                                                        date: DateTime.parse(myPlanController
                                                                            .getPlanModel
                                                                            .data![index]
                                                                            .renewalDate
                                                                            .toString()),
                                                                        dateFormatter:
                                                                            DateUtilities.ddmmyyyy,
                                                                      ),
                                                                      style: const TextStyle()
                                                                          .medium16
                                                                          .textColor(
                                                                              ColorSchema.primaryColor)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(20),
                                                              ),
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    myPlanController
                                                                            .userPlanId =
                                                                        myPlanController
                                                                            .getPlanModel
                                                                            .data![index]
                                                                            .id;
                                                                    myAddressController.selectedId = myPlanController
                                                                        .getPlanModel
                                                                        .data![
                                                                            index]
                                                                        .userAddressId;
                                                                    await Get.toNamed(
                                                                            Routes
                                                                                .myAddress,
                                                                            arguments: EnumForAddressFillOrNot
                                                                                .myplanScreen)!
                                                                        .then(
                                                                            (value) {
                                                                      print(
                                                                          value);
                                                                      myPlanController.editPlanAddressApiCall(
                                                                          userPlanId: myPlanController
                                                                              .userPlanId,
                                                                          userAddressId:
                                                                              value
                                                                          // .userAddressId,
                                                                          );
                                                                    });
                                                                  },
                                                                  child: GetBuilder<
                                                                      MyAddressController>(
                                                                    init:
                                                                        MyAddressController(),
                                                                    id: "myaddress",
                                                                    builder: (controller) => myPlanController
                                                                            .showProgress
                                                                            .value
                                                                        ? const Expanded(
                                                                            child:
                                                                                Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 50),
                                                                            child:
                                                                                Center(child: CircularProgressIndicator()),
                                                                          ))
                                                                        : !isNullEmptyOrFalse(myPlanController.getPlanModel.data?[index].address)
                                                                            ? CommonContainer(
                                                                                borderColor: ColorSchema.grey54Color,
                                                                                widget: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      myPlanController.getPlanModel.data![index].address!.addressLabel.toString(),
                                                                                      style: const TextStyle().medium16,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: getSize(10),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Text(
                                                                                            myPlanController.getPlanModel.data![index].address!.location.toString(),
                                                                                            style: const TextStyle().normal16.textColor(ColorSchema.grey54Color),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          height: 18,
                                                                                          width: 18,
                                                                                          color: ColorSchema.greenColor,
                                                                                          child: SvgPicture.asset(
                                                                                            ImageConstants.edit,
                                                                                            height: 20,
                                                                                            width: 20,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: getSize(10),
                                                                                    ),
                                                                                    Text(
                                                                                      myPlanController.getPlanModel.data?[index].address?.address ?? "",
                                                                                      style: const TextStyle().normal12.textColor(ColorSchema.blackColor),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : CommonContainer(
                                                                                borderColor: ColorSchema.grey54Color,
                                                                                widget: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(AppLocalizations.of(context)!.noAddressFound),
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
                                                                                  ],
                                                                                )),
                                                                  )),
                                                              SizedBox(
                                                                height:
                                                                    getSize(15),
                                                              ),
                                                              _commonContainer(
                                                                borderColor: compareCurrentToFutureDate(
                                                                            index:
                                                                                0,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? ColorSchema
                                                                        .grey54Color
                                                                    : ColorSchema
                                                                        .grey38Color,
                                                                style: compareCurrentToFutureDate(
                                                                            index:
                                                                                0,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .normal14
                                                                        .textColor(ColorSchema
                                                                            .primaryColor)
                                                                    : const TextStyle()
                                                                        .normal14
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                onTap: () {
                                                                  timeSelection(
                                                                      time: myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              0]
                                                                          .pickupTime
                                                                          .toString());
                                                                  myPlanController
                                                                      .selectedDate1
                                                                      .value = DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              0]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      '');
                                                                  myPlanController
                                                                          .selectedTime1
                                                                          .value =
                                                                      myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              0]
                                                                          .pickupTime!;
                                                                  if (compareCurrentToFutureDate(
                                                                          index:
                                                                              0,
                                                                          indexOfGetPlan:
                                                                              index) ==
                                                                      -1) {
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .retreatMyPlanScreen,
                                                                        arguments: [
                                                                          EnumForMyPlanRetreat
                                                                              .withdrawal1,
                                                                          index
                                                                        ]);
                                                                  }
                                                                },
                                                                index: index,
                                                                headerText:
                                                                    '${AppLocalizations.of(context)!.dispath} 1',
                                                                headerStyle: compareCurrentToFutureDate(
                                                                            index:
                                                                                0,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .medium16
                                                                        .textColor(ColorSchema
                                                                            .grey54Color)
                                                                    : const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                date: DateUtilities
                                                                    .convertDateTimeForShowPickupAndDelivery(
                                                                  date: DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              0]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      ''),
                                                                  dateFormatter:
                                                                      DateUtilities
                                                                          .eee_ddmmmyyyy,
                                                                ),
                                                                time: myPlanController
                                                                    .getPlanModel
                                                                    .data?[
                                                                        index]
                                                                    .orders?[0]
                                                                    .pickupTime,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(15),
                                                              ),
                                                              _commonContainer(
                                                                borderColor: compareCurrentToFutureDate(
                                                                            index:
                                                                                1,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? ColorSchema
                                                                        .grey54Color
                                                                    : ColorSchema
                                                                        .grey38Color,
                                                                style: compareCurrentToFutureDate(
                                                                            index:
                                                                                1,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .normal14
                                                                        .textColor(ColorSchema
                                                                            .primaryColor)
                                                                    : const TextStyle()
                                                                        .normal14
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                index: index,
                                                                onTap: () {
                                                                  timeSelection(
                                                                      time: myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              1]
                                                                          .pickupTime
                                                                          .toString());

                                                                  myPlanController
                                                                      .selectedDate2
                                                                      .value = DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              1]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      '');
                                                                  myPlanController
                                                                          .selectedTime2
                                                                          .value =
                                                                      myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              1]
                                                                          .pickupTime!;
                                                                  myPlanController
                                                                      .update();
                                                                  if (compareCurrentToFutureDate(
                                                                          index:
                                                                              1,
                                                                          indexOfGetPlan:
                                                                              index) ==
                                                                      -1) {
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .retreatMyPlanScreen,
                                                                        arguments: [
                                                                          EnumForMyPlanRetreat
                                                                              .withdrawal2,
                                                                          index
                                                                        ]);
                                                                  }
                                                                },
                                                                headerText:
                                                                    '${AppLocalizations.of(context)!.dispath} 2',
                                                                headerStyle: compareCurrentToFutureDate(
                                                                            index:
                                                                                1,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .medium16
                                                                        .textColor(ColorSchema
                                                                            .grey54Color)
                                                                    : const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                date: DateUtilities
                                                                    .convertDateTimeForShowPickupAndDelivery(
                                                                  date: DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              1]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      ''),
                                                                  dateFormatter:
                                                                      DateUtilities
                                                                          .eee_ddmmmyyyy,
                                                                ),
                                                                time: myPlanController
                                                                    .getPlanModel
                                                                    .data?[
                                                                        index]
                                                                    .orders?[1]
                                                                    .pickupTime,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(15),
                                                              ),
                                                              _commonContainer(
                                                                borderColor: compareCurrentToFutureDate(
                                                                            index:
                                                                                2,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? ColorSchema
                                                                        .grey54Color
                                                                    : ColorSchema
                                                                        .grey38Color,
                                                                style: compareCurrentToFutureDate(
                                                                            index:
                                                                                2,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .normal14
                                                                        .textColor(ColorSchema
                                                                            .primaryColor)
                                                                    : const TextStyle()
                                                                        .normal14
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                onTap: () {
                                                                  timeSelection(
                                                                      time: myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              2]
                                                                          .pickupTime
                                                                          .toString());

                                                                  myPlanController
                                                                      .selectedDate3
                                                                      .value = DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              2]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      '');
                                                                  myPlanController
                                                                          .selectedTime3
                                                                          .value =
                                                                      myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              2]
                                                                          .pickupTime!;
                                                                  myPlanController
                                                                      .update();
                                                                  if (compareCurrentToFutureDate(
                                                                          index:
                                                                              2,
                                                                          indexOfGetPlan:
                                                                              index) ==
                                                                      -1) {
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .retreatMyPlanScreen,
                                                                        arguments: [
                                                                          EnumForMyPlanRetreat
                                                                              .withdrawal3,
                                                                          index
                                                                        ]);
                                                                  }
                                                                },
                                                                index: index,
                                                                headerText:
                                                                    '${AppLocalizations.of(context)!.dispath} 3',
                                                                headerStyle: compareCurrentToFutureDate(
                                                                            index:
                                                                                2,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .medium16
                                                                        .textColor(ColorSchema
                                                                            .grey54Color)
                                                                    : const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                date: DateUtilities
                                                                    .convertDateTimeForShowPickupAndDelivery(
                                                                  date: DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              2]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      ''),
                                                                  dateFormatter:
                                                                      DateUtilities
                                                                          .eee_ddmmmyyyy,
                                                                ),
                                                                time: myPlanController
                                                                    .getPlanModel
                                                                    .data?[
                                                                        index]
                                                                    .orders?[2]
                                                                    .pickupTime,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(15),
                                                              ),
                                                              _commonContainer(
                                                                borderColor: compareCurrentToFutureDate(
                                                                            index:
                                                                                3,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? ColorSchema
                                                                        .grey54Color
                                                                    : ColorSchema
                                                                        .grey38Color,
                                                                style: compareCurrentToFutureDate(
                                                                            index:
                                                                                3,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .normal14
                                                                        .textColor(ColorSchema
                                                                            .primaryColor)
                                                                    : const TextStyle()
                                                                        .normal14
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                onTap: () {
                                                                  timeSelection(
                                                                      time: myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              3]
                                                                          .pickupTime
                                                                          .toString());

                                                                  myPlanController
                                                                      .selectedDate4
                                                                      .value = DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              3]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      '');
                                                                  myPlanController
                                                                          .selectedTime4
                                                                          .value =
                                                                      myPlanController
                                                                          .getPlanModel
                                                                          .data![
                                                                              index]
                                                                          .orders![
                                                                              3]
                                                                          .pickupTime!;
                                                                  myPlanController
                                                                      .update();
                                                                  if (compareCurrentToFutureDate(
                                                                          index:
                                                                              3,
                                                                          indexOfGetPlan:
                                                                              index) ==
                                                                      -1) {
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .retreatMyPlanScreen,
                                                                        arguments: [
                                                                          EnumForMyPlanRetreat
                                                                              .withdrawal4,
                                                                          index
                                                                        ]);
                                                                  }
                                                                },
                                                                index: index,
                                                                headerText:
                                                                    '${AppLocalizations.of(context)!.dispath} 4',
                                                                headerStyle: compareCurrentToFutureDate(
                                                                            index:
                                                                                3,
                                                                            indexOfGetPlan:
                                                                                index) ==
                                                                        -1
                                                                    ? const TextStyle()
                                                                        .medium16
                                                                        .textColor(ColorSchema
                                                                            .grey54Color)
                                                                    : const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.grey38Color),
                                                                date: DateUtilities
                                                                    .convertDateTimeForShowPickupAndDelivery(
                                                                  date: DateTime.parse(myPlanController
                                                                          .getPlanModel
                                                                          .data?[
                                                                              index]
                                                                          .orders?[
                                                                              3]
                                                                          .pickupDate
                                                                          .toString() ??
                                                                      ''),
                                                                  dateFormatter:
                                                                      DateUtilities
                                                                          .eee_ddmmmyyyy,
                                                                ),
                                                                time: myPlanController
                                                                    .getPlanModel
                                                                    .data?[
                                                                        index]
                                                                    .orders?[3]
                                                                    .pickupTime,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getSize(30),
                                                              ),
                                                              Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .rememberThatToCancelEndDate,
                                                                  style: const TextStyle()
                                                                      .medium16
                                                                      .textColor(
                                                                          ColorSchema
                                                                              .grey54Color)),
                                                              SizedBox(
                                                                height:
                                                                    getSize(30),
                                                              ),
                                                              myPlanController.getPlanModel.data![index].isCancel == 1 ||
                                                                      myPlanController.getPlanModel.data![index].isRenewal ==
                                                                          1
                                                                  ? CommonAppButton(
                                                                      text: myPlanController.getPlanModel.data![index].isRenewal == 1
                                                                          ? AppLocalizations.of(context)!
                                                                              .cancelPlan
                                                                          : AppLocalizations.of(context)!
                                                                              .planCancelled,
                                                                      onTap:
                                                                          () {},
                                                                      width: MathUtilities.screenWidth(
                                                                          context),
                                                                      color: ColorSchema
                                                                          .grey38Color,
                                                                      style: const TextStyle()
                                                                          .normal16
                                                                          .textColor(ColorSchema
                                                                              .whiteColor),
                                                                      borderRadius:
                                                                          5)
                                                                  : CommonAppButton(
                                                                      text: AppLocalizations.of(context)!
                                                                          .cancelPlan,
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (_) => Alertdialog(
                                                                                fullButtonWidth: MathUtilities.screenWidth(context),
                                                                                isFullButton: true,
                                                                                titleWidget: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                        onTap: () {
                                                                                          Get.back();
                                                                                        },
                                                                                        child: const Icon(Icons.close)),
                                                                                    SvgPicture.asset(
                                                                                      ImageConstants.cancelPlan,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                contentText: AppLocalizations.of(context)!.cancelTheSubscription,
                                                                                actionWidget: Text(
                                                                                  AppLocalizations.of(context)!.confirmCancellation,
                                                                                  style: const TextStyle().medium16,
                                                                                ),
                                                                                onTap: () {
                                                                                  myPlanController.cancelPlanApiCall(planId: myPlanController.getPlanModel.data?[index].id.toString());
                                                                                  myPlanController.update();
                                                                                }));
                                                                      },
                                                                      width: MathUtilities.screenWidth(
                                                                          context),
                                                                      color: ColorSchema
                                                                          .primaryColor,
                                                                      style: const TextStyle()
                                                                          .normal16
                                                                          .textColor(ColorSchema.whiteColor),
                                                                      borderRadius: 5)
                                                            ],
                                                          ),
                                                        ),
                                                        crossFadeState:
                                                            !myPlanController
                                                                    .getPlanModel
                                                                    .data![
                                                                        index]
                                                                    .isMyDetail!
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
                                              ),
                                            );
                                          },
                                        ),
                                      );
                          }),
                      SizedBox(
                        height: getSize(20),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  InkWell _commonContainer(
      {String? headerText,
      String? date,
      String? time,
      int? index,
      TextStyle? style,
      Color? svgColor,
      Color? borderColor,
      TextStyle? headerStyle,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CommonContainer(
        borderColor: borderColor,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headerText!, style: headerStyle),
            SizedBox(
              height: getSize(10),
            ),
            Row(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(date!,
                            style: style ??
                                const TextStyle()
                                    .normal14
                                    .textColor(ColorSchema.primaryColor)),
                        SizedBox(
                          width: getSize(10),
                        ),
                        SvgPicture.asset(
                          ImageConstants.edit,
                          height: 20,
                          width: 20,
                          color: svgColor,
                        ),
                      ],
                    ),
                    Text(
                      time ?? '09:00-12:00',
                      style: style ??
                          const TextStyle()
                              .normal14
                              .textColor(ColorSchema.grey54Color),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int compareCurrentToFutureDate({
    int indexOfGetPlan = 0,
    int index = 0,
  }) {
    return DateTime.now().compareTo(
      DateTime.parse(
        myPlanController
            .getPlanModel.data![indexOfGetPlan].orders![index].pickupDate
            .toString(),
      ),
    );
  }

  void timeSelection({required String time}) {
    if (time.contains("09:00")) {
      myPlanController.selectIndex.value = 0;
    } else if (time.contains("14:00")) {
      myPlanController.selectIndex.value = 1;
    } else {
      myPlanController.selectIndex.value = 0;
    }
  }
}
