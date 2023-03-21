// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class CommonListTile extends StatelessWidget {
  final String? txt;
  final String? svgImage;
  final Widget? image;
  void Function()? onTap;
  final double? height;
  final double? width;
  final double? padding;

  CommonListTile(
      {Key? key,
      this.txt,
      this.svgImage,
      this.image,
      this.onTap,
      this.height,
      this.width,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorSchema.whiteColor,
        child: Padding(
          padding: EdgeInsets.all(getSize(16)),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image!,
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 0.0),
                child: Text(txt!),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: ColorSchema.greyColor20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
