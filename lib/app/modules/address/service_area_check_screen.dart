import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/address/service_area_check_controller.dart';
import 'package:linpo_user/app/routes/app_pages.dart';
import 'package:linpo_user/components/common_container.dart';
import 'package:linpo_user/helper/utils/images.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceAreaCheckScreen extends StatefulWidget {
  const ServiceAreaCheckScreen({Key? key}) : super(key: key);

  @override
  State<ServiceAreaCheckScreen> createState() => _ServiceAreaCheckScreenState();
}

class _ServiceAreaCheckScreenState extends State<ServiceAreaCheckScreen> {
  final addressController =
      Get.put<ServiceAreaCheckController>(ServiceAreaCheckController());
  final ScrollController controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    addressController.directionController.dispose();
    controller.dispose();
  }

  @override
  void initState() {
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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: getSize(50),
                    ),
                    SvgPicture.asset(ImageConstants.location),
                    SizedBox(
                      height: getSize(100),
                    ),
                    Text(
                      AppLocalizations.of(context)!.enterYourAddress,
                      style: const TextStyle().normal18,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getSize(50),
                    ),
                    GetBuilder(
                        init: ServiceAreaCheckController(),
                        builder: (controller1) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            controller.animateTo(
                                controller.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear);
                          });
                          return Column(
                            children: [
                              TextfieldContainer(
                                widget: _directionTextField(context),
                                height: 55,
                              ),
                              (addressController
                                      .directionFocusNode.hasPrimaryFocus)
                                  ? (addressController
                                          .searchAddressList.isNotEmpty)
                                      ? SizedBox(
                                          height: getSize(300),
                                        )
                                      : Container()
                                  : Container()
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: BottomContainer(
            align: Alignment.centerRight,
            name: AppLocalizations.of(context)!.enterHere,
            icon: false,
            onTap: () {
              // addressController.directionController.text.isNotEmpty
              //     ? Get.toNamed(Routes.serviceAreaScreen)
              //     :
              Get.toNamed(Routes.signIn);
              addressController.update();
            },
          ),
        ),
      ),
    );
  }

  TypeAheadFormField _directionTextField(BuildContext context) {
    return TypeAheadFormField<CustomModel>(
      getImmediateSuggestions: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          elevation:
              (addressController.directionController.text.isEmpty) ? 0 : 4),
      textFieldConfiguration: TextFieldConfiguration(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: getSize(10)),
          errorStyle: const TextStyle(height: 0),
          border: InputBorder.none,
          labelText: AppLocalizations.of(context)!.direction,
          labelStyle:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color),
          hintText: AppLocalizations.of(context)!.enterLocation,
          suffixIcon: addressController.isClearIcon.value
              ? GestureDetector(
                  onTap: () {
                    addressController.directionController.clear();
                    addressController.isClearIcon.value = false;
                    addressController.isDirectionValid.value = false;
                    addressController.update();
                  },
                  child: Icon(
                    Icons.clear,
                    color: ColorSchema.blackColor,
                    size: getSize(20),
                  ),
                )
              : const Text(''),
        ),
        onChanged: (val) {
          if (val.isEmpty) {
            addressController.searchAddressList.clear();
            addressController.isClearIcon.value = false;
            addressController.isDirectionValid.value = false;
            addressController.update();
          } else {
            addressController.isClearIcon.value = true;
            addressController.isDirectionValid.value = true;
          }
        },
        controller: addressController.directionController,
        focusNode: addressController.directionFocusNode,
      ),
      validator: (val) {
        if (val!.isEmpty) {
          addressController.isDirectionValid.value = false;
          return "";
        } else {
          addressController.isDirectionValid.value = true;
          return null;
        }
      },
      suggestionsCallback: (pattern) async {
        return await addressController.apiCallForGetAddressList(
            textEditingController: addressController.directionController);
      },
      noItemsFoundBuilder: (context) {
        return (addressController.directionController.text.isEmpty)
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
        addressController.directionController.text =
            suggestion.description.toString();
        if (kDebugMode) {
          print(suggestion.description.toString());
        }
        addressController.apiCallForGetLatLong(placeId: suggestion.placeId);
        if (kDebugMode) {
          print("place id :${suggestion.placeId}");
        }
      },
    );
  }
}
