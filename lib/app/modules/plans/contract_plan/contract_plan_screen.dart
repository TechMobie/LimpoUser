import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';
import 'package:linpo_user/app/data/models/plans/plans_model.dart';
import 'package:linpo_user/app/data/models/profile/profile_model.dart';
import 'package:linpo_user/app/modules/plans/contract_plan/contract_plan_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/add_address.dart';

import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:get/get.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/constants.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/helper/utils/pref_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContractPlanScreen extends StatefulWidget {
  // final String? planId;
  // final int? amount;
  const ContractPlanScreen({
    Key? key,
    // this.typeOfPlanId,
    // this.typesOfPlansModel,
    // this.planId,
    // this.amount,
  }) : super(key: key);

  @override
  State<ContractPlanScreen> createState() => _ContractPlanScreenState();
}

class _ContractPlanScreenState extends State<ContractPlanScreen> {
  final contractPlanController =
      Get.put<ContractPlanController>(ContractPlanController());
  final myAddressController = Get.find<MyAddressController>();
  final paymentController = Get.find<PaymentController>();
  final formKey = GlobalKey<FormState>();
  final globalController = Get.find<GlobalController>();
  final String typeOfPlanId = Get.arguments[1];
  PlanLits? typesOfPlansModel = Get.arguments[0];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      globalController.profileModel =
          ProfileModel.fromJson(PrefUtils.getInstance.readData(
        PrefUtils.getInstance.profile,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(20),
                    ),
                    CommonHeader(
                      title: "",
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.planDetails,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.primaryColor),
                    ),
                    const Divider(
                      color: ColorSchema.primaryColor,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: getSize(30)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: ColorSchema.grey38Color)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getSize(30),
                              right: getSize(30),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.network(
                                  typesOfPlansModel?.image.toString() ?? "",
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        typesOfPlansModel?.name.toString() ??
                                            "",
                                        style: const TextStyle()
                                            .size(22)
                                            .weight(FontWeight.w600)
                                            .textColor(
                                                ColorSchema.primaryColor),
                                      ),
                                      SizedBox(
                                        height: getSize(5),
                                      ),
                                      Text(
                                        "${formatCurrency.format(typesOfPlansModel?.price)} / ${AppLocalizations.of(context)!.month}",
                                        style: const TextStyle()
                                            .medium19
                                            .textColor(ColorSchema.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getSize(20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getSize(25),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getSize(30),
                              right: getSize(30),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.monthlyServiceOf,
                              style: const TextStyle()
                                  .normal18
                                  .textColor(ColorSchema.blackColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getSize(20),
                              right: getSize(20),
                            ),
                            child: Html(
                              data: typesOfPlansModel?.monthlyServiceOf
                                  .toString(),
                              style: {
                                "p": Style(
                                  fontSize: FontSize.xLarge,
                                  letterSpacing: 0.0,
                                )
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getSize(20),
                              right: getSize(20),
                            ),
                            child: Html(
                              data: typesOfPlansModel?.description.toString(),
                              style: {
                                "p": Style(
                                  fontSize: FontSize.medium,
                                  letterSpacing: 0.0,
                                )
                              },
                            ),
                          ),
                          SizedBox(
                            height: getSize(30),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.myAddress,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.primaryColor),
                    ),
                    const Divider(
                      color: ColorSchema.primaryColor,
                      thickness: 2,
                    ),
                    GetBuilder<MyAddressController>(
                      init: myAddressController,
                      id: "myaddress",
                      builder: (controller) => isNullEmptyOrFalse(
                              myAddressController.addressModel.data)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: InkWell(
                                onTap: () {
                                  // myAddressController.addressLabelController
                                  //     .clear();
                                  // myAddressController.myDirectionController
                                  //     .clear();
                                  // myAddressController.detailAddressController
                                  //     .clear();
                                  // myAddressController
                                  //     .isAddressLabelButtonValid.value = false;
                                  // myAddressController
                                  //     .isDetailAddressButtonValid.value = false;
                                  // myAddressController
                                  //     .isDirectionButtonValid.value = false;
                                  myAddressController.update();
                                  Navigator.push(
                                      Get.context!,
                                      MaterialPageRoute(
                                        builder: (context) => const AddAddress(
                                            enumForAddress:
                                                EnumForAddress.addressAdd),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_box_rounded,
                                      color: ColorSchema.greenColor,
                                      size: getSize(40),
                                    ),
                                    SizedBox(
                                      width: getSize(10),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.addAddress,
                                      style: const TextStyle().medium19,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: GestureDetector(
                                onTap: () {
                                  myAddressController.selectedId =
                                      myAddressController
                                          .defaultAddressModel.id;
                                  Get.toNamed(Routes.myAddress,
                                      arguments:
                                          EnumForAddressFillOrNot.stepsScreen);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(getSize(20)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorSchema.grey38Color)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myAddressController.defaultAddressModel
                                                .addressLabel ??
                                            "",
                                        style: const TextStyle().medium16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              myAddressController
                                                      .defaultAddressModel
                                                      .location ??
                                                  "",
                                              style: const TextStyle()
                                                  .normal16
                                                  .textColor(
                                                      ColorSchema.grey54Color),
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
                                        myAddressController
                                                .defaultAddressModel.address ??
                                            "",
                                        style: const TextStyle()
                                            .normal12
                                            .textColor(ColorSchema.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Obx(
                      () => TextfieldContainer(
                        height: 100,
                        widget: TextFormField(
                          maxLines: 5,
                          textInputAction: TextInputAction.done,
                          minLines: 4,
                          controller:
                              contractPlanController.addCommentsController,
                          style: const TextStyle()
                              .normal16
                              .textColor(ColorSchema.blackColor),
                          keyboardType: TextInputType.name,
                          cursorColor: ColorSchema.primaryColor,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText:
                                AppLocalizations.of(context)!.addComments,
                            labelStyle:
                                contractPlanController.isCommentValid.value
                                    ? const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.grey54Color)
                                    : const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.redColor),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: getSize(10), vertical: getSize(10)),
                            errorStyle: const TextStyle(height: 0),
                            errorMaxLines: 3,
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            if (val.isEmpty) {
                              contractPlanController.isCommentValid.value =
                                  false;
                              contractPlanController.update();
                            } else {
                              contractPlanController.isCommentValid.value =
                                  true;
                            }
                            contractPlanController.update();
                            formKey.currentState!.validate();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              contractPlanController.isCommentValid.value =
                                  false;
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.iCalender,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.primaryColor),
                    ),
                    const Divider(
                      color: ColorSchema.primaryColor,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.rememberYou,
                    ),
                    GetBuilder(
                        init: ContractPlanController(),
                        builder: (controller) {
                          return Column(
                            children: [
                              commonRetirementandOffice(
                                  title:
                                      "${AppLocalizations.of(context)!.dispath} 1",
                                  date: DateUtilities
                                      .convertDateTimeForShowPickupAndDelivery(
                                          date: contractPlanController
                                              .selectedDate1.value,
                                          dateFormatter:
                                              DateUtilities.weekDayDateMonth),
                                  time: contractPlanController
                                      .selectedTime1.value,
                                  onTap: () {
                                    timeSelection(
                                        time: contractPlanController
                                            .selectedTime1.value);
                                    Get.toNamed(Routes.retreatPlan, arguments: [
                                      EnumForPlanRetreat.withdrawal1,
                                    ]);
                                  }),
                              commonRetirementandOffice(
                                  title:
                                      "${AppLocalizations.of(context)!.dispath} 2",
                                  date: DateUtilities
                                      .convertDateTimeForShowPickupAndDelivery(
                                          date: contractPlanController
                                              .selectedDate2.value,
                                          dateFormatter:
                                              DateUtilities.weekDayDateMonth),
                                  time: contractPlanController
                                      .selectedTime2.value,
                                  onTap: () {
                                    timeSelection(
                                        time: contractPlanController
                                            .selectedTime2.value);

                                    Get.toNamed(Routes.retreatPlan, arguments: [
                                      EnumForPlanRetreat.withdrawal2,
                                    ]);
                                  }),
                              commonRetirementandOffice(
                                  title:
                                      "${AppLocalizations.of(context)!.dispath} 3",
                                  date: DateUtilities
                                      .convertDateTimeForShowPickupAndDelivery(
                                          date: contractPlanController
                                              .selectedDate3.value,
                                          dateFormatter:
                                              DateUtilities.weekDayDateMonth),
                                  time: contractPlanController
                                      .selectedTime3.value,
                                  onTap: () {
                                    timeSelection(
                                        time: contractPlanController
                                            .selectedTime3.value);

                                    Get.toNamed(Routes.retreatPlan, arguments: [
                                      EnumForPlanRetreat.withdrawal3,
                                    ]);
                                  }),
                              commonRetirementandOffice(
                                  title:
                                      "${AppLocalizations.of(context)!.dispath} 4",
                                  date: DateUtilities
                                      .convertDateTimeForShowPickupAndDelivery(
                                          date: contractPlanController
                                              .selectedDate4.value,
                                          dateFormatter:
                                              DateUtilities.weekDayDateMonth),
                                  time: contractPlanController
                                      .selectedTime4.value,
                                  onTap: () {
                                    timeSelection(
                                        time: contractPlanController
                                            .selectedTime4.value);

                                    Get.toNamed(Routes.retreatPlan, arguments: [
                                      EnumForPlanRetreat.withdrawal4,
                                    ]);
                                  })
                            ],
                          );
                        }),
                    SizedBox(
                      height: getSize(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.checkout,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.primaryColor),
                    ),
                    const Divider(
                      color: ColorSchema.primaryColor,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: getSize(6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.subtotal,
                          style: const TextStyle().normal18,
                        ),
                        Text(
                          formatCurrency.format(typesOfPlansModel!.price),
                          // '\$${widget.amount}',
                          style: const TextStyle().normal18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSize(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.total,
                          style: const TextStyle().medium19.bold20,
                        ),
                        Text(
                          formatCurrency.format(typesOfPlansModel!.price),
                          style: const TextStyle().medium19.bold20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSize(40),
                    ),
                    Text(
                      AppLocalizations.of(context)!.paymentMethods,
                      style: const TextStyle()
                          .medium16
                          .textColor(ColorSchema.primaryColor),
                    ),
                    const Divider(
                      color: ColorSchema.primaryColor,
                      thickness: 2,
                    ),
                    GetBuilder<PaymentController>(
                      init: paymentController,
                      builder: (controller) => !isNullEmptyOrFalse(
                              paymentController.getCardModel.data)
                          ? CommonContainer(
                              borderColor: ColorSchema.grey54Color,
                              widget: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.paymentScreen,
                                      arguments: EnumForPayment.stepsScreen);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        cardType(),
                                        SizedBox(
                                          width: getSize(20),
                                        ),
                                        Text(
                                            paymentController.getCardModel
                                                    .data?[0].cardNumber
                                                    .toString() ??
                                                "",
                                            style: const TextStyle()
                                                .size(15)
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.paymentScreen,
                                        arguments: EnumForPayment.stepsScreen);
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
                                      Text(
                                          AppLocalizations.of(context)!
                                              .managePaymentMethods,
                                          style: const TextStyle().medium16),
                                      // const Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: getSize(40),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          contractPlanController.isCheckBox.value =
                              !contractPlanController.isCheckBox.value;
                          contractPlanController.update();
                        },
                        child: Row(
                          children: [
                            Container(
                              child: contractPlanController.isCheckBox.value
                                  ? const Icon(
                                      Icons.check_box,
                                      size: 25.0,
                                      color: ColorSchema.greenColor,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank,
                                      size: 25.0,
                                      color: ColorSchema.grey54Color,
                                    ),
                            ),
                            SizedBox(
                              width: getSize(7),
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.iHaveRead} ",
                                  style: const TextStyle()
                                      .medium16
                                      .textColor(ColorSchema.blackColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .termsAndConditions,
                                      style: const TextStyle()
                                          .normal16
                                          .textColor(ColorSchema.greenColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(Routes.termsCondition);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(35),
                    ),
                    CommonAppButton(
                        text: AppLocalizations.of(context)!.confirmPurchase,
                        onTap: () async {
                          if (isNullEmptyOrFalse(
                              myAddressController.defaultAddressModel)) {
                            addressDialogueBox();
                          } else if (!formKey.currentState!.validate()) {
                            commentDialogueBox();
                          } else if (isNullEmptyOrFalse(
                              paymentController.getCardModel.data)) {
                            paymentDialogueBox();
                          } else if (!contractPlanController.isCheckBox.value) {
                            termsAndConditionDialogueBox();
                          } else if (isNullEmptyOrFalse(globalController
                              .profileModel.data?.mobileNumber)) {
                            addMobileNumberDialogueBox();
                          } else {
                            await contractPlanController.checkoutPlanApiCall(
                              userAddressId: myAddressController
                                  .defaultAddressModel.id
                                  .toString(),
                              typeOfPlanId: typeOfPlanId,
                              planId: typesOfPlansModel!.id.toString(),
                              amount: typesOfPlansModel!.price,
                              pickUpDate1:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController
                                          .selectedDate1.value,
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime1:
                                  contractPlanController.selectedTime1.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              deliveryDate1:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController.selectedDate1
                                                      .value.weekday ==
                                                  5 ||
                                              contractPlanController
                                                      .selectedDate1
                                                      .value
                                                      .weekday ==
                                                  6
                                          ? contractPlanController
                                              .selectedDate1.value
                                              .add(const Duration(days: 3))
                                          : contractPlanController
                                              .selectedDate1.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime1:
                                  contractPlanController.selectedTime1.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate2:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController
                                          .selectedDate2.value,
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime2:
                                  contractPlanController.selectedTime2.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              deliveryDate2:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController.selectedDate2
                                                      .value.weekday ==
                                                  5 ||
                                              contractPlanController
                                                      .selectedDate2
                                                      .value
                                                      .weekday ==
                                                  6
                                          ? contractPlanController
                                              .selectedDate2.value
                                              .add(const Duration(days: 3))
                                          : contractPlanController
                                              .selectedDate2.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime2:
                                  contractPlanController.selectedTime2.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate3:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController
                                          .selectedDate3.value,
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime3:
                                  contractPlanController.selectedTime3.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              deliveryDate3:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController.selectedDate3
                                                      .value.weekday ==
                                                  5 ||
                                              contractPlanController
                                                      .selectedDate3
                                                      .value
                                                      .weekday ==
                                                  6
                                          ? contractPlanController
                                              .selectedDate3.value
                                              .add(const Duration(days: 3))
                                          : contractPlanController
                                              .selectedDate3.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime3:
                                  contractPlanController.selectedTime3.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              pickUpDate4:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController
                                          .selectedDate4.value,
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              pickUpTime4:
                                  contractPlanController.selectedTime4.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                              deliveryDate4:
                                  DateUtilities.convertDateTimeToString(
                                      date: contractPlanController.selectedDate4
                                                      .value.weekday ==
                                                  5 ||
                                              contractPlanController
                                                      .selectedDate4
                                                      .value
                                                      .weekday ==
                                                  6
                                          ? contractPlanController
                                              .selectedDate4.value
                                              .add(const Duration(days: 3))
                                          : contractPlanController
                                              .selectedDate4.value
                                              .add(const Duration(days: 2)),
                                      dateFormatter: DateUtilities.yyyy_mm_dd),
                              deliveryTime4:
                                  contractPlanController.selectedTime4.value ==
                                          "09:00-13:00"
                                      ? "09:00-13:00"
                                      : "14:00-18:00",
                            );
                          }
                        },
                        width: double.infinity,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            color: ColorSchema.grey54Color,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                        color: ColorSchema.primaryColor,
                        style: const TextStyle()
                            .medium16
                            .textColor(ColorSchema.whiteColor),
                        borderRadius: 5),
                    SizedBox(
                      height: getSize(15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void timeSelection({required String time}) {
    if (time.contains("09:00")) {
      contractPlanController.selectIndex.value = 0;
    } else if (time.contains("14:00")) {
      contractPlanController.selectIndex.value = 1;
    } else {
      contractPlanController.selectIndex.value = 0;
    }
  }

  Widget cardType() {
    if (paymentController.getCardModel.data?[0].cardType.toString() == "Visa") {
      return SvgPicture.asset(
        ImageConstants.visaCard,
        height: 10,
      );
    } else if (paymentController.getCardModel.data?[0].cardType.toString() ==
        "AmericanExpress") {
      return SvgPicture.asset(
        ImageConstants.americanExpressCard,
        height: 10,
      );
    } else {
      return SvgPicture.asset(
        ImageConstants.masterCard,
        height: 10,
      );
    }
  }
}
