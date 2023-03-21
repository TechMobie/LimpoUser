import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/plus/my_address/add_address_controller.dart';
import 'package:linpo_user/app/modules/plus/my_address/my_address_controller.dart';
import 'package:linpo_user/components/button/button.dart';
import 'package:linpo_user/components/common_class.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/components/common_text_field.dart';
import 'package:linpo_user/helper/utils/enum.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:linpo_user/app/modules/address/service_area_check_controller.dart';

class AddAddress extends StatefulWidget {
  final dynamic userId;
  final int? isDefaultAddress;
  final EnumForAddress? enumForAddress;
  final int? index;

  const AddAddress(
      {Key? key,
      this.userId,
      this.enumForAddress,
      this.isDefaultAddress,
      this.index})
      : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final formKey = GlobalKey<FormState>();
  final addAddressController =
      Get.put<AddAddressController>(AddAddressController());
  final myAddressController = Get.find<MyAddressController>();

  // final afr = Get.arguments;
  @override
  void initState() {
    addAddressController.searchAddressList.clear();
    if (widget.enumForAddress == EnumForAddress.addressEdit) {
      addAddressController.isAddressLabelButtonValid.value = true;
      addAddressController.isDetailAddressButtonValid.value = true;
      addAddressController.isDirectionButtonValid.value = true;
      addAddressController.addressLabelController.text = myAddressController
          .addressModel.data![widget.index!].addressLabel
          .toString();

      addAddressController.myDirectionController.text = myAddressController
          .addressModel.data![widget.index!].location
          .toString();

      addAddressController.detailAddressController.text =
          myAddressController.addressModel.data![widget.index!].address ?? "";
      addAddressController.lat =
          myAddressController.addressModel.data![widget.index!].latitude.toString();
             addAddressController.long =
          myAddressController.addressModel.data![widget.index!].longitude.toString();
      if (kDebugMode) {
        print(addAddressController.detailAddressController.text);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    addAddressController.addressLabelController.clear();
    addAddressController.myDirectionController.clear();
    addAddressController.detailAddressController.clear();
    addAddressController.isAddressLabelValid.value = true;
    addAddressController.isDirectionValid.value = true;
    // myAddressController.isDetailAddressValid.value = true;
    addAddressController.isMyClearIcon.value = false;
    Get.delete<AddAddressController>();
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
            child: Form(
              key: formKey,
              child: GetBuilder<AddAddressController>(
                init: addAddressController,
                builder: (controller) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getSize(30),
                      ),
                      CommonHeader(
                        title: AppLocalizations.of(context)!.addNewAddress,
                        onTap: () {
                          Get.back();
                        },
                      ),
                      SizedBox(
                        height: getSize(50),
                      ),
                      TextfieldContainer(
                          widget: _addressLabelTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          height: 60, widget: _directionTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          height: 55, widget: _detailAddressTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              buttonColor: ColorSchema.whiteColor,
                              borderRadius: 5,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: ColorSchema.grey54Color,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              text: AppLocalizations.of(context)!.cancel,
                              textStyle: const TextStyle()
                                  .medium16
                                  .textColor(ColorSchema.blackColor),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.back();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CommonButton(
                              borderRadius: 5,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: ColorSchema.grey54Color,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              buttonColor: (addAddressController
                                          .isAddressLabelButtonValid.value &&
                                      addAddressController
                                          .isDirectionButtonValid.value)
                                  ? ColorSchema.primaryColor
                                  : ColorSchema.grey38Color,
                              text: widget.enumForAddress ==
                                      EnumForAddress.addressAdd
                                  ? AppLocalizations.of(context)!.saveAddress
                                  : AppLocalizations.of(context)!.editAddress,
                              textStyle: const TextStyle()
                                  .medium16
                                  .textColor(ColorSchema.whiteColor),
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                addAddressController.isAddressLabelValid.value =
                                    false;
                                addAddressController.isDirectionValid.value =
                                    false;
                                // myAddressController.isDetailAddressValid.value =
                                //     false;
                                if (formKey.currentState!.validate()) {
                                  if (widget.enumForAddress ==
                                      EnumForAddress.addressAdd) {
                                    await addAddressController
                                        .addAddressApiCall(
                                      isDefaultAddress: true,
                                      lat: addAddressController.lat,
                                      long: addAddressController.long,
                                    );
                                  } else {
                                    addAddressController.serviceName =
                                        myAddressController
                                            .addressModel
                                            .data![widget.index!]
                                            .serviceAreaName
                                            .toString();
                                    print(addAddressController.serviceName);
                                    await addAddressController
                                        .editAddressApiCall(
                                            userAddressId: widget.userId,
                                            isDefaultAddress:
                                                widget.isDefaultAddress,
                                            lat: addAddressController.lat,
                                            long: addAddressController.long);
                                    addAddressController.update();
                                    Get.back();
                                  }
                                  if (kDebugMode) {
                                    print('Save address');
                                  }
                                  addAddressController.update();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CommonTextField _addressLabelTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.next,
      focusNode: addAddressController.addressLabelFocusNode,
      textOption: TextFieldOption(
        inputController: addAddressController.addressLabelController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.addressLabel,
        labelStyleText: addAddressController.isAddressLabelValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        addAddressController.mydirectionFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          addAddressController.isAddressLabelValid.value = false;
          addAddressController.isAddressLabelButtonValid.value = false;
          return "";
        } else {
          addAddressController.isAddressLabelValid.value = true;
          addAddressController.isAddressLabelButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          addAddressController.isAddressLabelValid.value = false;
          addAddressController.isAddressLabelButtonValid.value = false;
        } else {
          addAddressController.isAddressLabelValid.value = true;
          addAddressController.isAddressLabelButtonValid.value = true;
        }
        addAddressController.update();
      },
    );
  }

  TypeAheadFormField _directionTextField(BuildContext context) {
    return TypeAheadFormField<CustomModel>(
      getImmediateSuggestions: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          elevation: (addAddressController.myDirectionController.text.isEmpty)
              ? 0
              : 4),
      textFieldConfiguration: TextFieldConfiguration(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: getSize(10)),
          errorStyle: const TextStyle(height: 0),
          labelText: AppLocalizations.of(context)!.direction,
          labelStyle: addAddressController.isDirectionValid.value
              ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
              : const TextStyle().normal16.textColor(ColorSchema.redColor),
          hintText: AppLocalizations.of(context)!.enterLocation,
          suffixIcon: addAddressController.isMyClearIcon.value
              ? GestureDetector(
                  onTap: () {
                    addAddressController.myDirectionController.clear();
                    addAddressController.isMyClearIcon.value = false;
                    addAddressController.isDirectionValid.value = true;
                    addAddressController.isDirectionButtonValid.value = false;
                    addAddressController.update();
                  },
                  child: Icon(
                    Icons.clear,
                    color: ColorSchema.blackColor,
                    size: getSize(25),
                  ),
                )
              : const Text(''),
          border: InputBorder.none,
        ),
        onChanged: (val) {
          if (val.isEmpty) {
            addAddressController.searchAddressList.clear();
            addAddressController.isMyClearIcon.value = false;
            addAddressController.isDirectionValid.value = false;
          } else {
            addAddressController.isMyClearIcon.value = true;
            addAddressController.isDirectionValid.value = true;
          }
          addAddressController.update();
        },
        controller: addAddressController.myDirectionController,
        focusNode: addAddressController.mydirectionFocusNode,
      ),
      validator: (val) {
        if (val!.isEmpty) {
          addAddressController.isDirectionValid.value = false;
          addAddressController.isDirectionButtonValid.value = false;
          return "";
        } else {
          addAddressController.isDirectionValid.value = true;
          addAddressController.isDirectionButtonValid.value = true;
          return null;
        }
      },
      suggestionsCallback: (pattern) async {
        return await addAddressController.apiCallForGetAddressList(
            textEditingController: addAddressController.myDirectionController);
      },
      noItemsFoundBuilder: (context) {
        return (addAddressController.myDirectionController.text.isEmpty)
            ? Text(
                AppLocalizations.of(context)!.noDataFound,
              )
            : Container();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          title: Text(suggestion.description.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        addAddressController.myDirectionController.text =
            suggestion.description.toString();
        addAddressController.isDirectionValid.value = true;
        addAddressController.isDirectionButtonValid.value = true;
        addAddressController.apiCallForGetLatLong(
          placeId: suggestion.placeId,
        );
        addAddressController.update();
      },
    );
  }

  CommonTextField _detailAddressTextField(BuildContext context) {
    return CommonTextField(
      inputAction: TextInputAction.done,
      focusNode: addAddressController.detailAddressFocusNode,
      textOption: TextFieldOption(
          inputController: addAddressController.detailAddressController,
          keyboardType: TextInputType.name,
          labelText: AppLocalizations.of(context)!.apartment,
          labelStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)
          // : const TextStyle().normal16.textColor(ColorSchema.redColor),
          ),
      clearIcon: false,
      validation: (val) {
        // if (val!.isEmpty) {
        //   myAddressController.isDetailAddressValid.value = false;
        //   myAddressController.isDetailAddressButtonValid.value = false;
        //   return "";
        // } else {
        //   myAddressController.isDetailAddressValid.value = true;
        //   myAddressController.isDetailAddressButtonValid.value = true;
        //   return null;
        // }
      },
      textCallback: (val) {
        // if (val.isEmpty) {
        //   myAddressController.isDetailAddressValid.value = false;
        //   myAddressController.isDetailAddressButtonValid.value = false;
        // } else {
        //   myAddressController.isDetailAddressValid.value = true;
        //   myAddressController.isDetailAddressButtonValid.value = true;
        // }
        addAddressController.update();
      },
    );
  }
}
