import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'add_address.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final myAddressController = Get.find<MyAddressController>();
  RxBool showProgress1 = false.obs;
  // final addAddressController = Get.put<AddressController>(AddressController());
  EnumForAddressFillOrNot enumForAddressFillOrNot = Get.arguments;

  int index1 = 0;
  @override
  void initState() {
  
    // if (myAddressController.defaultAddressModel.selectedIndex == null) {
    for (int i = 0; i < myAddressController.addressModel.data!.length; i++) {
      if (myAddressController.addressModel.data![i].id ==
          myAddressController.selectedId) {
        index1 = i;
        myAddressController.defaultAddressModel.selectedIndex = i;
      }
      // }
    }

    super.initState();
  }

  @override
  void dispose() {
    myAddressController.isSelectedAddress.value = false;

    super.dispose();
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
            child: GetBuilder(
                id: "myaddress",
                init: MyAddressController(),
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: getSize(20),
                      ),
                      if (enumForAddressFillOrNot ==
                              EnumForAddressFillOrNot.stepsScreen ||
                          enumForAddressFillOrNot ==
                                  EnumForAddressFillOrNot.myplanScreen &&
                              !isNullEmptyOrFalse(
                                  myAddressController.addressModel.data))
                        Text(
                          AppLocalizations.of(context)!.direction,
                          maxLines: 2,
                          style: const TextStyle()
                              .semibold24
                              .textColor(ColorSchema.blackColor),
                        ),
                      if (enumForAddressFillOrNot ==
                          EnumForAddressFillOrNot.myaddressScreen)
                        CommonHeader(
                          title: AppLocalizations.of(context)!.direction,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      SizedBox(
                        height: getSize(30),
                      ),
                      SizedBox(
                        height: getSize(30),
                      ),
                      (myAddressController.showProgress.value)
                          ? const Expanded(
                              child: Center(child: CircularProgressIndicator()))
                          : isNullEmptyOrFalse(
                                  myAddressController.addressModel.data)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: InkWell(
                                    onTap: () {
                                     
                                      Navigator.push(
                                          Get.context!,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddAddress(
                                                    enumForAddress:
                                                        EnumForAddress
                                                            .addressAdd),
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          AppLocalizations.of(context)!
                                              .addAddress,
                                          style: const TextStyle().medium19,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView(
                                    children: [
                                      ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: myAddressController
                                            .addressModel.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CommonContainer(
                                            onTap: () {
                                              
                                              index1 = index;
                                              myAddressController
                                                  .defaultAddressModel
                                                  .selectedIndex = index;
                                              myAddressController.selectedId =
                                                  myAddressController
                                                      .addressModel
                                                      .data![index]
                                                      .id;
                                             
                                              myAddressController
                                                  .update(["myaddress"]);

                                            },
                                            borderWidth:
                                                borderWidthForSelection(index),
                                            borderColor: borderColor(index),
                                            widget: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
                                                      child: Text(
                                                          myAddressController
                                                                  .addressModel
                                                                  .data?[index]
                                                                  .addressLabel ??
                                                              "",
                                                          style:
                                                              const TextStyle()
                                                                  .medium19),
                                                    ),
                                                    const Spacer(),
                                                    // if (enumForAddressFillOrNot ==
                                                    //     EnumForAddressFillOrNot
                                                    //         .myaddressScreen)
                                                    Center(
                                                      child: CommonButton(
                                                        buttonColor: ColorSchema
                                                            .primaryColor,
                                                        height: getSize(68),
                                                        width: getSize(90),
                                                        borderRadius: 5,
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .edit,
                                                        isIcon: true,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 2,
                                                            color: ColorSchema
                                                                .grey54Color,
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                          ),
                                                        ],
                                                        icon: Icons
                                                            .edit_road_outlined,
                                                        textStyle: const TextStyle()
                                                            .medium12
                                                            .textColor(
                                                                ColorSchema
                                                                    .whiteColor),
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                         
                                                          myAddressController
                                                              .update();
                                                         
                                                          Navigator.push(
                                                              Get.context!,
                                                              MaterialPageRoute(
                                                                builder: (context) => AddAddress(
                                                                    userId: myAddressController
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    index:
                                                                        index,
                                                                    isDefaultAddress: myAddressController
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .isDefaultAddress,
                                                                    enumForAddress:
                                                                        EnumForAddress
                                                                            .addressEdit),
                                                              ));
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: getSize(10),
                                                    ),
                                                    // if (enumForAddressFillOrNot ==
                                                    //     EnumForAddressFillOrNot
                                                    //         .myaddressScreen)
                                                    Center(
                                                      child: CommonButton(
                                                        buttonColor: ColorSchema
                                                            .primaryColor,
                                                        height: getSize(68),
                                                        width: getSize(90),
                                                        borderRadius: 5,
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .eliminate,
                                                        isIcon: true,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 2,
                                                            color: ColorSchema
                                                                .grey54Color,
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                          ),
                                                        ],
                                                        icon: Icons
                                                            .delete_outline_outlined,
                                                        textStyle: const TextStyle()
                                                            .medium12
                                                            .textColor(
                                                                ColorSchema
                                                                    .whiteColor),
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          if (myAddressController
                                                                  .addressModel
                                                                  .data!
                                                                  .length >
                                                              1) {
                                                            _deleteDialogueBox(
                                                                context, index);
                                                          } else {
                                                            _defaultDialogueBox(
                                                                context, index);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: getSize(10),
                                                ),
                                                Text(
                                                    myAddressController
                                                            .addressModel
                                                            .data?[index]
                                                            .location ??
                                                        "",
                                                    style: const TextStyle()
                                                        .normal16
                                                        .textColor(ColorSchema
                                                            .grey54Color)),
                                                SizedBox(
                                                  height: getSize(20),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        myAddressController
                                                                .addressModel
                                                                .data?[index]
                                                                .address ??
                                                            "",
                                                        style: const TextStyle()
                                                            .normal14
                                                            .textColor(ColorSchema
                                                                .grey54Color),
                                                      ),
                                                    ),
                                                    // if (enumForAddressFillOrNot ==
                                                    //     EnumForAddressFillOrNot
                                                    //         .myaddressScreen)
                                                    GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .opaque,
                                                        onTap: () {
                                                          if (myAddressController
                                                                  .addressModel
                                                                  .data?[index]
                                                                  .isDefaultAddress ==
                                                              0) {
                                                            // Pref
                                                            myAddressController
                                                                .addressModel
                                                                .data![index]
                                                                .isDefaultAddress = 1;
                                                         
                                                            myAddressController.editAddressApiCall(
                                                                indexOfModel:
                                                                    index,
                                                                isDefaultAddress:
                                                                    myAddressController
                                                                        .addressModel
                                                                        .data![
                                                                            index]
                                                                        .isDefaultAddress);
                                                            myAddressController
                                                                .update();
                                                          }
                                                        },
                                                        child: myAddressController
                                                                    .addressModel
                                                                    .data?[
                                                                        index]
                                                                    .isDefaultAddress ==
                                                                0
                                                            ? Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .setAsDefault,
                                                                style: const TextStyle()
                                                                    .medium14
                                                                    .textColor(
                                                                        ColorSchema
                                                                            .primaryColor))
                                                            : Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .predetermined,
                                                                style: const TextStyle()
                                                                    .medium14
                                                                    .textColor(
                                                                        ColorSchema
                                                                            .greenColor),
                                                              ))
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        child: InkWell(
                                          onTap: () {
                                           
                                            myAddressController.update();
                                            Navigator.push(
                                                Get.context!,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AddAddress(
                                                          enumForAddress:
                                                              EnumForAddress
                                                                  .addressAdd),
                                                ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                AppLocalizations.of(context)!
                                                    .addAddress,
                                                style:
                                                    const TextStyle().medium19,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      if ((enumForAddressFillOrNot ==
                                  EnumForAddressFillOrNot.stepsScreen &&
                              !isNullEmptyOrFalse(
                                  myAddressController.addressModel.data)) ||
                          enumForAddressFillOrNot ==
                              EnumForAddressFillOrNot.myplanScreen)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: CommonButton(
                            buttonColor: myAddressController.addressModel.data!
                                    .any((element) =>
                                        element.id ==
                                        myAddressController.selectedId)
                                ? ColorSchema.primaryColor
                                : ColorSchema.grey54Color,

                            borderRadius: 5,
                            text: AppLocalizations.of(context)!
                                .continueWithMyOrder,

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

                              if (enumForAddressFillOrNot ==
                                      EnumForAddressFillOrNot.stepsScreen ||
                                  enumForAddressFillOrNot ==
                                      EnumForAddressFillOrNot.myplanScreen) {
                                myAddressController.selectedAddressModel =
                                    myAddressController
                                        .addressModel.data![index1];
                                myAddressController.defaultAddressModel.id =
                                    myAddressController.selectedAddressModel.id;
                                myAddressController
                                        .defaultAddressModel.addressLabel =
                                    myAddressController
                                        .selectedAddressModel.addressLabel;

                                myAddressController
                                        .defaultAddressModel.location =
                                    myAddressController
                                        .selectedAddressModel.location;
                                myAddressController
                                        .defaultAddressModel.address =
                                    myAddressController
                                        .selectedAddressModel.address;
                                print(index1);

                         

                                myAddressController.update(["myaddress"]);


                                Get.back(result:myAddressController
                                          .addressModel.data![index1].id);
                              }
                            },
                          ),
                        ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  double borderWidthForSelection(int index) {
    if (enumForAddressFillOrNot == EnumForAddressFillOrNot.stepsScreen ||
        enumForAddressFillOrNot == EnumForAddressFillOrNot.myplanScreen) {
      if (myAddressController.defaultAddressModel.selectedIndex == index) {
        return 2;
      }
    }
    return 1;
  }

  _deleteDialogueBox(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (_) => Alertdialog(
            isFullButton: false,
            contentText: AppLocalizations.of(context)!.doYouWantDeleteAddress,
            contentTextStyle:
                const TextStyle().medium19.textColor(ColorSchema.grey54Color),
            actionWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    myAddressController.defaultAddressModel.selectedIndex =
                        myAddressController.defaultAddressModel.id;
                    myAddressController.deleteAddressApiCall(
                        userAddressId: myAddressController
                            .addressModel.data![index].id
                            .toString());
                  },
                  child: Text(AppLocalizations.of(context)!.yes,
                      style: const TextStyle().medium19),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(AppLocalizations.of(context)!.no,
                      style: const TextStyle().medium19),
                ),
              ],
            ),
            onTap: () {}));
  }

  _defaultDialogueBox(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (_) => Alertdialog(
            isFullButton: false,
            contentText:
                AppLocalizations.of(context)!.beforeDeletingThisAddress,
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
              ],
            ),
            onTap: () {}));
  }

  Color borderColor(index) {
    if (enumForAddressFillOrNot == EnumForAddressFillOrNot.stepsScreen ||
        enumForAddressFillOrNot == EnumForAddressFillOrNot.myplanScreen) {
      if (myAddressController.defaultAddressModel.selectedIndex == index) {
        return ColorSchema.greenColor;
      } else {
        return ColorSchema.grey54Color;
      }
    } else {
      return ColorSchema.grey54Color;
    }
  }
}
