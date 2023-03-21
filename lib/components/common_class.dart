// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';


class CommonHeader extends StatelessWidget {
  final String? title;
  final TextStyle? headerStyle;
  Function()? onTap;

  CommonHeader({Key? key, this.title, this.headerStyle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title ?? '',
            maxLines: 2,
            style: headerStyle ??
                const TextStyle().semibold24.textColor(ColorSchema.blackColor),
          ),
        ),
        GestureDetector(
          onTap: onTap ??
              () {
                Get.back();
              },
          child: const CircleAvatar(
            radius: 18,
            child: Icon(
              Icons.close_rounded,
              color: ColorSchema.whiteColor,
              size: 20,
            ),
            backgroundColor: ColorSchema.lightBlueColor,
          ),
        ),
      ],
    );
  }
}

class CommonContainer extends StatelessWidget {
  final Widget? widget;
  final Color? borderColor;
  final double? borderWidth;
  final void Function()? onTap;

  const CommonContainer(
      {Key? key, this.widget, this.borderColor, this.onTap, this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: getSize(20), horizontal: getSize(20)),
            // margin: EdgeInsets.symmetric(horizontal: getSize(15)),
            //height: getSize(180),
            width: MathUtilities.screenWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: borderWidth??1, color: borderColor ?? ColorSchema.blackColor)),
            child: widget),
      ),
    );
  }
}

class Alertdialog extends StatelessWidget {
  final String? contentText;
  final Widget? titleWidget;
  final Widget? actionWidget;
  final TextStyle? contentTextStyle;
  Function? onTap;
  bool? isFullButton;
  final double? fullButtonWidth;

  Alertdialog(
      {Key? key,
      this.contentText,
      this.titleWidget,
      this.actionWidget,
      this.contentTextStyle,
      this.onTap,
      this.isFullButton = false,
      this.fullButtonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: titleWidget ?? Container(),
      content: Text(contentText!),
      contentPadding:
          EdgeInsets.symmetric(vertical: getSize(20), horizontal: getSize(30)),
      actionsPadding: EdgeInsets.all(getSize(10)),
      contentTextStyle: contentTextStyle ??
          const TextStyle().normal18.textColor(ColorSchema.grey54Color),
      actions: [
        isFullButton!
            ? SizedBox(
                width:
                    fullButtonWidth ?? MathUtilities.screenWidth(context) / 4,
                height: 40,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSchema.primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(ColorSchema.whiteColor),
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () {
                      onTap!();
                    },
                    child: actionWidget ?? const Text('')
                    
                    ),
              )
            : TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    splashFactory: NoSplash.splashFactory),
                onPressed: () {
                  onTap!();
                },
                child: actionWidget ?? const Text('')
                
                ),
      ],
    );
  }
}
