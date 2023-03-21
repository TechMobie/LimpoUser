import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/retreat_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/add_address.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/app/modules/plus/plus_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/date_utils.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Step2Screen extends StatefulWidget {
  const Step2Screen({Key? key}) : super(key: key);

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  final retreatPLan = Get.find<RetreatController>();
  final myWashingMachineController = Get.find<MyWashingMachineController>();

  final myAddressController = Get.find<MyAddressController>();
  final plusController = Get.find<PlusController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retreatPLan.selectTimeForPickUp.value =
        retreatPLan
            .pickUpList[retreatPLan.selectIndex.value];
    retreatPLan.selectTimeForDelivery.value =
        retreatPLan
            .deliveryList[retreatPLan.selectIndex.value];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<MyAddressController>(
                init: myAddressController,
                id: "myaddress",
                builder: (controller) => isNullEmptyOrFalse(
                        myAddressController.addressModel.data)
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorSchema.grey38Color)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: InkWell(
                            onTap: () {
                        
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
                                  style: const TextStyle().medium16,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorSchema.grey38Color)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getSize(10)),
                          child: GestureDetector(
                              onTap: () {
                                myAddressController.selectedId =
                                    myAddressController.defaultAddressModel.id;
                                Get.toNamed(Routes.myAddress,
                                    arguments:
                                        EnumForAddressFillOrNot.stepsScreen);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myAddressController
                                        .defaultAddressModel.addressLabel
                                        .toString(),
                                    style: const TextStyle().medium16,
                                  ),
                                  SizedBox(
                                    height: getSize(10),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          myAddressController
                                              .defaultAddressModel.location
                                              .toString(),
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
                              )),
                        ),
                      ),
              ),
              GetBuilder<RetreatController>(
                  init:retreatPLan,
                  builder: (controller) {
                    return Column(
                      children: [
                        commonRetirementandOffice(
                            title: AppLocalizations.of(context)!.pickup,
                            date: DateUtilities
                                .convertDateTimeForShowPickupAndDelivery(
                                    date: retreatPLan
                                        .pickUpSelectedDate.value,
                                    dateFormatter:
                                        DateUtilities.weekDayDateMonth),
                            time: retreatPLan
                                .selectTimeForPickUp.value,
                            onTap: () {
                              timeSelection(
                                  time: retreatPLan
                                      .selectTimeForPickUp.value);
                              retreatPLan
                                      .selectedRetreatDate.value =
                                  retreatPLan
                                      .pickUpSelectedDate.value;
                              Get.toNamed(Routes.retreatScreen,
                                  arguments: [EnumForRetreat.withdrawal]);
                            }),
                        commonRetirementandOffice(
                            title: AppLocalizations.of(context)!.delivery,
                            date: DateUtilities
                                .convertDateTimeForShowPickupAndDelivery(
                                    date: retreatPLan
                                        .deliverySelectedDate.value,
                                    dateFormatter:
                                        DateUtilities.weekDayDateMonth),
                            time: retreatPLan
                                .selectTimeForDelivery.value,
                            onTap: () {
                              timeSelection(
                                  time: retreatPLan
                                      .selectTimeForDelivery.value);
                              retreatPLan
                                      .selectedRetreatDate.value =
                                  retreatPLan
                                      .deliverySelectedDate.value;
                              Get.toNamed(Routes.retreatScreen,
                                  arguments: [EnumForRetreat.dispatch]);
                            })
                      ],
                    );
                  }),
              SizedBox(
                height: getSize(20),
              ),
              Text(
                AppLocalizations.of(context)!.whoWillReceive,
                style: const TextStyle()
                    .medium14
                    .textColor(ColorSchema.blackColor),
              ),
              Obx(
                () => _commonCheckBoxTile(
                    title: AppLocalizations.of(context)!.iWillReceive,
                    value: myWashingMachineController.checkValue1.value,
                    onTap: () {
                      myWashingMachineController.checkValue1.value =
                          !myWashingMachineController.checkValue1.value;
                      if (kDebugMode) {
                        print(myWashingMachineController.checkValue1.value);
                      }
                      myWashingMachineController.checkValue2.value = false;
                      myWashingMachineController.checkValue3.value = false;
                    },
                    onChanged: (val) {
                      myWashingMachineController.checkValue1.value = val!;
                      if (kDebugMode) {
                        print(myWashingMachineController.checkValue1.value);
                      }
                      myWashingMachineController.checkValue2.value = false;
                      myWashingMachineController.checkValue3.value = false;
                    }),
              ),
              Obx(
                () => _commonCheckBoxTile(
                    title: AppLocalizations.of(context)!.dropOffAtConcierge,
                    value: myWashingMachineController.checkValue2.value,
                    onTap: () {
                      myWashingMachineController.checkValue2.value =
                          !myWashingMachineController.checkValue2.value;
                      myWashingMachineController.checkValue1.value = false;
                      myWashingMachineController.checkValue3.value = false;
                    },
                    onChanged: (val) {
                      myWashingMachineController.checkValue2.value = val!;
                      myWashingMachineController.checkValue1.value = false;
                      myWashingMachineController.checkValue3.value = false;
                    }),
              ),
              Obx(
                () => _commonCheckBoxTile(
                    title: AppLocalizations.of(context)!.anotherPerson,
                    value: myWashingMachineController.checkValue3.value,
                    onTap: () {
                      myWashingMachineController.checkValue3.value =
                          !myWashingMachineController.checkValue3.value;
                      myWashingMachineController.checkValue1.value = false;
                      myWashingMachineController.checkValue2.value = false;
                    },
                    onChanged: (val) {
                      myWashingMachineController.checkValue3.value = val!;
                      myWashingMachineController.checkValue1.value = false;
                      myWashingMachineController.checkValue2.value = false;
                    }),
              ),
              Obx(
                () => (myWashingMachineController.checkValue3.value)
                    ? TextfieldContainer(
                        height: 60,
                        widget: CommonTextField(
                          inputAction: TextInputAction.next,
                          textOption: TextFieldOption(
                              inputController: myWashingMachineController
                                  .personReceiveController,
                              keyboardType: TextInputType.name,
                              maxLine: 4,
                              labelText: AppLocalizations.of(context)!
                                  .specifyWhichPerson,
                              labelStyleText: const TextStyle()
                                  .normal16
                                  .textColor(ColorSchema.grey54Color)),
                          clearIcon: false,
                          validation: (val) {},
                          textCallback: (val) {},
                        ),
                      )
                    : Container(),
              ),
              SizedBox(
                height: getSize(10),
              ),
              TextfieldContainer(
                height: 100,
                widget: TextFormField(
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  minLines: 4,
                  controller: myWashingMachineController.addCommentsController,
                  style: const TextStyle()
                      .normal16
                      .textColor(ColorSchema.blackColor),
                  keyboardType: TextInputType.name,
                  cursorColor: ColorSchema.primaryColor,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: AppLocalizations.of(context)!.addComments,
                    labelStyle: const TextStyle()
                        .normal16
                        .textColor(ColorSchema.grey54Color),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getSize(10), vertical: getSize(10)),
                    errorStyle: const TextStyle(height: 0),
                    errorMaxLines: 3,
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _commonCheckBoxTile(
      {String? title,
      void Function(bool?)? onChanged,
      bool? value,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: getSize(15)),
        padding: EdgeInsets.only(left: getSize(15)),
        decoration:
            BoxDecoration(border: Border.all(color: ColorSchema.grey38Color)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.grey,
              ),
              child: Checkbox(
                  checkColor: ColorSchema.whiteColor,
                  activeColor: ColorSchema.greenColor,
                  value: value,
                  onChanged: onChanged),
            )
          ],
        ),
      ),
    );
  }

  void timeSelection({required String time}) {
    if (time.contains("09:00")) {
      retreatPLan.selectIndex.value = 0;
    } else if (time.contains("14:00")) {
      retreatPLan.selectIndex.value = 1;
    } else {
      retreatPLan.selectIndex.value = 0;
    }
  }
}
