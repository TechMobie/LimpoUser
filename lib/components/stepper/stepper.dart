// ignore_for_file: constant_identifier_names, unused_element, must_be_immutable, avoid_print

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';

import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/retreat_controller.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/step1_screen.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/step2_screen.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/step3_screen.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/step4_screen.dart';
import 'package:linpo_user/app/modules/bottomBar/bottom_bar_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/modules/plus/payment/payment_controller.dart';
import 'package:linpo_user/app/modules/services/services_controller.dart';

import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';

import 'package:linpo_user/helper/utils/math_utils.dart';

import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double MARGIN_NORMAL = 16;
const double CHIP_BORDER_RADIUS = 30;
const double PADDING_SMALL = 8;
int currentStep = 0;
PageController controller = PageController();

enum HorizontalStepState { SELECTED, UNSELECTED }

enum Type { TOP, BOTTOM }

class HorizontalStep {
  final String title;
  final Widget widget;
  bool? isValid;
  HorizontalStepState state;

  HorizontalStep({
    required this.title,
    required this.widget,
    this.state = HorizontalStepState.UNSELECTED,
    this.isValid,
  });
}

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<StatefulWidget> {
  final Color selectedColor = ColorSchema.greenColor;
  final double? circleRadius = 13;
  final Color? unSelectedColor = ColorSchema.greyColor30;
  final Color? selectedOuterCircleColor = ColorSchema.primaryColor;
  final TextStyle? textStyle = const TextStyle().normal12;
  final myWashingMachineController = Get.find<MyWashingMachineController>();
  final retreatController = Get.put<RetreatController>(RetreatController());

  final myAddressController =
      Get.put<MyAddressController>(MyAddressController());
  final servicesController = Get.find<ServicesController>();
  final globalController = Get.find<GlobalController>();
  final bottomBarScreenController = Get.find<BottomBarController>();
  final paymentController = Get.find<PaymentController>();

  final List<HorizontalStep>? steps = [
    HorizontalStep(
      title: AppLocalizations.of(Get.context!)!.myWashing,
      widget: Step1Screen(),
      state: HorizontalStepState.SELECTED,
      isValid: true,
    ),
    HorizontalStep(
      title: AppLocalizations.of(Get.context!)!.offices,
      widget: const Step2Screen(),
      isValid: true,
    ),
    HorizontalStep(
      title: AppLocalizations.of(Get.context!)!.payment,
      widget: Step3Screen(),
      isValid: true,
    ),
    HorizontalStep(
      title: AppLocalizations.of(Get.context!)!.confirmation,
      widget: Step4Screen(),
      isValid: true,
    )
  ];
  @override
  void initState() {
    controller = PageController();
    controller!.addListener(() {
      if (!steps![currentStep].isValid!) {
        controller!.jumpToPage(currentStep);
      }
    });

    super.initState();
  }

  void _markAsUnselectedToSucceedingSteps() {
    for (int i = steps!.length - 1; i >= currentStep; i--) {
      steps![i].state = HorizontalStepState.UNSELECTED;
    }
  }

  void _markAsCompletedForPrecedingSteps() {
    for (int i = 0; i <= currentStep; i++) {
      steps![i].state = HorizontalStepState.SELECTED;
    }
  }

  void _goToNextPage() {
    FocusScope.of(context).unfocus();

    if (steps!.length - 1 == currentStep) {
      bottomBarScreenController.currentIndex.value = 0;
      myWashingMachineController.getCartApiCall();
      // currentStep = 0;
      print("current step $currentStep");
      // setState(() {});

      // onComplete!.call();
    }
    if (currentStep < steps!.length - 1) {
      print("current step1 $currentStep");
      currentStep++;
      setState(() {});
      controller!.jumpToPage(currentStep);
      if (currentStep == 1) {
        if (isNullEmptyOrFalse(
            globalController.profileModel.data?.mobileNumber)) {
          currentStep--;

          setState(() {});
          controller!.jumpToPage(currentStep);
          addMobileNumberDialogueBox();
        }
      }

      if (currentStep == 2) {
        if (isNullEmptyOrFalse(myAddressController.addressModel.data)) {
          currentStep--;
          setState(() {});
          controller!.jumpToPage(currentStep);

          print(currentStep);
          //  if (isNullEmptyOrFalse(myAddressController
          //                   .defaultAddressModel.address)) {
          addressDialogueBox();
          // }

          // Get.toNamed(Routes.myAddress,
          //     arguments: EnumForAddressFillOrNot.stepsScreen);
          // Get.toNamed(Routes.myAddress,
          //     arguments: EnumForAddressFillOrNot.myaddressScreen);
        }
      }
      // if (currentStep == 2) {
      //   if (isNullEmptyOrFalse(paymentController.getCardModel.data)) {
      //     currentStep--;
      //     setState(() {});
      //     _controller!.jumpToPage(currentStep);

      //     print(currentStep);
      //
      //   }
      // }
      if (currentStep == 3) {
        currentStep--;
        setState(() {});
        controller!.jumpToPage(currentStep);
        if (paymentController.isShowOnePay.value) {
          if (isNullEmptyOrFalse(paymentController.getCardModel.data)) {
            paymentDialogueBox();
          } else {
            FacebookAppEvents().logInitiatedCheckout(
              currency: "USD",
              totalPrice: myWashingMachineController.grandTotalPrice.toDouble(),
              paymentInfoAvailable: true,
            );
            myWashingMachineController
                .checkOutApiCall(
              userAddressId:
                  myAddressController.defaultAddressModel.id.toString(),
              pickUpDate: DateUtilities.convertDateTimeToString(
                  date: retreatController.pickUpSelectedDate.value,
                  dateFormatter: DateUtilities.yyyy_mm_dd),
              pickUpTime:
                  retreatController.selectTimeForPickUp.value == "09:00-13:00"
                      ? "09:00-13:00"
                      : "14:00-18:00",
              deliveryDate: DateUtilities.convertDateTimeToString(
                  date: retreatController.deliverySelectedDate.value,
                  dateFormatter: DateUtilities.yyyy_mm_dd),
              deliveryTime:
                  retreatController.selectTimeForDelivery.value == "09:00-13:00"
                      ? "09:00-13:00"
                      : "14:00-18:00",
              whoWillReceive: myWashingMachineController.checkValue1.value
                  ? "I'll receive"
                  : myWashingMachineController.checkValue2.value
                      ? "drop off at concierge"
                      : myWashingMachineController.personReceiveController.text
                          .trimRight(),
              comments: myWashingMachineController.addCommentsController.text
                  .trimRight(),
            )
                .then((value) {
              FacebookAppEvents().logPurchase(
                currency: "USD",
                amount: myWashingMachineController.grandTotalPrice.toDouble(),
              );
              if ((value['success'] ?? false) == false) {
                showToast(
                  msg: value['message'] ?? "",
                  color: ColorSchema.redColor.withOpacity(0.3),
                );
              } else {
                currentStep++;
                setState(() {});
                controller!.jumpToPage(currentStep);
                servicesController.getProductApiCall();
              }
            });
          }
        } else {
          paymentController.createTransactionApiCall();
        }
      }
      // if (currentStep == 4) {
      //   // currentStep++;
      //   // setState(() {});
      //   // _controller!.jumpToPage(currentStep);
      //   print("sds");
      //   Get.toNamed(Routes.bottomBarScreen);
      // }
      print(
          '&*&*&******************************************************${currentStep}');
    }
  }

  void _goToPreviousPage() {
    if (currentStep > 0) {
      currentStep--;
      controller!.jumpToPage(currentStep);
      setState(() {});
    }
  }

  @override
  void dispose() {
    currentStep = 0;
    myWashingMachineController.checkValue1.value = false;
    myWashingMachineController.checkValue2.value = false;
    myWashingMachineController.checkValue3.value = false;
    myWashingMachineController.addCommentsController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Scaffold(
        // backgroundColor: ColorSchema.whiteColor,
        bottomNavigationBar: GestureDetector(
          onTap: () => steps![currentStep].isValid! ? _goToNextPage() : null,
          child: Container(
            // height: 20,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            margin:
                const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: ColorSchema.primaryColor,
                borderRadius: BorderRadius.circular(5)),
            // height: 40,
            width: double.infinity,
            child: currentStep == 2
                ? Text(
                    AppLocalizations.of(context)!.confirmOrder,
                    style: const TextStyle()
                        .bold16
                        .textColor(ColorSchema.whiteColor),
                    textAlign: TextAlign.center,
                  )
                : currentStep == 3
                    ? Text(
                        AppLocalizations.of(context)!.backToTop,
                        style: const TextStyle()
                            .bold16
                            .textColor(ColorSchema.whiteColor),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        AppLocalizations.of(context)!.following,
                        style: const TextStyle()
                            .bold16
                            .textColor(ColorSchema.whiteColor),
                        textAlign: TextAlign.center,
                      ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: getSize(16), right: getSize(16), top: getSize(60)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: getSize(10),
                    right: getSize(10),
                    top: getSize(10),
                    bottom: getSize(10)),
                // height: getSize(150),
                width: double.infinity,

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorSchema.blackColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  color: ColorSchema.whiteColor,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    _getIndicatorWidgets(width),
                    const SizedBox(
                      height: 8,
                    ),
                    _getTitleWidgets(),
                    // _getButtons()
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _getPageWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  // List<Widget> _getBottomTypeWidget(double width) {
  //   return [
  //     _getPageWidgets(),
  //     _getIndicatorWidgets(width),
  //     SizedBox(
  //       height: MARGIN_SMALL,
  //     ),
  //     _getTitleWidgets(),
  //     // _getButtons()
  //   ];
  // }

  Widget _getPageWidgets() {
    return Expanded(
      child: PageView(
        pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index) => setState(() {
          if (isForward(index)) {
            _markAsCompletedForPrecedingSteps();
          } else {
            _markAsUnselectedToSucceedingSteps();
          }
          setState(() {
            currentStep = index;
            steps![index].state = HorizontalStepState.SELECTED;
          });
        }),
        children: steps!.map((e) => e.widget).toList(),
      ),
    );
  }

  Widget _getTitleWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _getTitles(),
    );
  }

  Widget _getIndicatorWidgets(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: PADDING_SMALL,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: _getStepCircles(),
          )
        ],
      ),
    );
  }

  // List<Widget> _getTopTypeWidget(double width) {
  //   return [

  // }

  // Widget _getButtons() {
  //   return Container(
  //     padding: const EdgeInsets.all(
  //       MARGIN_NORMAL,
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () => _goToPreviousPage(),
  //             child: Container(
  //               padding: const EdgeInsets.all(
  //                 MARGIN_NORMAL,
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   "BACK",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: btnTextColor ?? Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               decoration: BoxDecoration(
  //                 color: leftBtnColor,
  //                 borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(
  //                     CHIP_BORDER_RADIUS,
  //                   ),
  //                   topLeft: Radius.circular(
  //                     CHIP_BORDER_RADIUS,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () => steps![currentStep].isValid! ? goToNextPage() : null,
  //             child: Container(
  //               padding: const EdgeInsets.all(
  //                 MARGIN_NORMAL,
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   "NEXT",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: btnTextColor ?? Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               decoration: BoxDecoration(
  //                 color: steps![currentStep].isValid!
  //                     ? rightBtnColor
  //                     : Colors.grey,
  //                 borderRadius: BorderRadius.only(
  //                   bottomRight: Radius.circular(
  //                     CHIP_BORDER_RADIUS,
  //                   ),
  //                   topRight: Radius.circular(
  //                     CHIP_BORDER_RADIUS,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _getTitles() {
    return steps!
        .map((e) => Flexible(
              child: Text(
                e.title,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ))
        .toList();
  }

  List<Widget> _getStepCircles() {
    List<Widget> widgets = [];
    for (int i = 0; i < steps!.length; i++) {
      widgets.add(_StepCircle(steps![i], circleRadius!, selectedColor,
          unSelectedColor!, selectedOuterCircleColor!, i));
      if (i != steps!.length - 1) {
        widgets.add(_StepLine(
          steps![i + 1],
          selectedColor,
          unSelectedColor!,
        ));
      }
    }
    // steps!.asMap().forEach((key, value) {

    // });
    return widgets;
  }

  bool isForward(int index) {
    return index > currentStep;
  }
}

class _StepLine extends StatelessWidget {
  final HorizontalStep step;
  final Color selectedColor;
  final Color unSelectedColor;

  const _StepLine(
    this.step,
    this.selectedColor,
    this.unSelectedColor,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 2,
      color: step.state == HorizontalStepState.SELECTED
          ? selectedColor
          : unSelectedColor,
    ));
  }
}

class _StepCircle extends StatefulWidget {
  final HorizontalStep step;
  final double circleRadius;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedOuterCircleColor;
  int index;
  _StepCircle(this.step, this.circleRadius, this.selectedColor,
      this.unSelectedColor, this.selectedOuterCircleColor, this.index);

  @override
  State<_StepCircle> createState() => _StepCircleState();
}

class _StepCircleState extends State<_StepCircle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (currentStep > 0) {
          currentStep = widget.index;
          controller!.jumpToPage(widget.index);
          setState(() {});
          print(currentStep);
        }
      },
      child: Container(
        //padding: const EdgeInsets.all(5),
        // height: widget.circleRadius,
        // width: widget.circleRadius,
        height: 17,
        width: 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.circleRadius),
          ),
        ),
        child: Container(

            // padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
          color: widget.step.state == HorizontalStepState.SELECTED
              ? widget.selectedColor
              : widget.unSelectedColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.circleRadius,
            ),
          ),
        )),
      ),
    );
  }

  Color _getColor() {
    if (widget.step.state == HorizontalStepState.SELECTED) {
      // ignore: unnecessary_null_comparison, prefer_if_null_operators
      return widget.selectedOuterCircleColor != null
          ? widget.selectedOuterCircleColor
          : widget.selectedColor;
    }
    return widget.unSelectedColor;
  }
}
