// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, file_names

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class CommonDotIndicator extends StatelessWidget {
  final int? totalPages;
  final double? currentPage;

  CommonDotIndicator({
    this.totalPages,
    this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return getDottedPageControl();
  }

  Widget getDottedPageControl() {
    return Container(
      padding: EdgeInsets.only(
        bottom: getSize(5),
      ),
      alignment: Alignment.topCenter,
      child: DotsIndicator(
        dotsCount: totalPages!,
        position: currentPage! < 0 ? 0 : currentPage!,
        decorator:const DotsDecorator(
          color: ColorSchema.greyColor,
          shape: CircleBorder(
            side: BorderSide(
              color: ColorSchema.greyColor,
              width: 1,
            ),
          ),
          activeColor: ColorSchema.primaryColor,
        ),
      ),
    );
  }
}
