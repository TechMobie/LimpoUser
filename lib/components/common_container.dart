import 'package:flutter/material.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';

class TextfieldContainer extends StatelessWidget {
  final Widget? widget;
  final double? height;

  const TextfieldContainer({Key? key, this.widget, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: ColorSchema.grey54Color)),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: widget);
  }
}

class BottomContainer extends StatelessWidget {
  final Alignment? align;
  final bool icon;
  final String? name;
  final Function()? onTap;

  const BottomContainer(
      {Key? key, this.align, required this.icon, this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: getSize(60),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: ColorSchema.greyColor),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment:
              icon ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            icon
                ? const Icon(
                    Icons.keyboard_arrow_left,
                    color: ColorSchema.primaryColor,
                  )
                : const Text(''), // widget.icon
            Flexible(
              child: Text(
                name ?? '',
                style: const TextStyle()
                    .size(17)
                    .textColor(ColorSchema.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
