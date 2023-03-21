import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/app/modules/MyWashingMachine/my_washing_machine_controller.dart';
import 'package:linpo_user/app/modules/services/add_service_screen.dart';
import 'package:linpo_user/components/stepper/stepper.dart';
import 'package:linpo_user/helper/utils/common_functions.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class MyWashingMachineScreen extends StatelessWidget {
  MyWashingMachineScreen({Key? key}) : super(key: key);

  final myWashingMachineController = Get.find<MyWashingMachineController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorSchema.whiteColor,
        child: GetBuilder<MyWashingMachineController>(
          init: myWashingMachineController,
          builder: (controller) => Column(
            children: [
              if (isNullEmptyOrFalse(
                  myWashingMachineController.getCartModel.data?.cartDetail ??
                      ""))
                AddServiceScreen()
              else
                const HorizontalStepper()

              //  AddServiceScreen(),
            ],
          ),
        ));
  }
}
