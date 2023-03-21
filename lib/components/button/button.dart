import 'package:flutter/material.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  const CommonAppButton({
    Key? key,
    this.onTap,
    this.text,
    this.color,
    this.icon,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          // height: getSize(60),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: width ?? getSize(145),
          decoration: BoxDecoration(
              border: border,
              color: color ??
                  ColorSchema.lightGreenColor, //ColorConstants.buttonColor,
              borderRadius: BorderRadius.circular(borderRadius!),
              boxShadow: boxShadow),
          child: Center(
            child: Text(
              text!,
              style: style,
            ),
          ),
        ));
  }
}

class CommonButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final IconData? icon;
  final Color? textColor;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isIcon;

  const CommonButton({
    Key? key,
    this.onTap,
    this.text,
    this.icon,
    this.textColor,
    this.buttonColor,
    this.textStyle,
    this.borderRadius,
    this.width,
    this.height,
    this.boxShadow,
    this.border,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: height ?? getSize(60),
        width: width ?? double.infinity,

        padding: const EdgeInsets.only(top: 15, bottom: 15),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: buttonColor,
            border: border,
            borderRadius: BorderRadius.circular(borderRadius!),
            boxShadow: boxShadow),
        child: Center(
          child: isIcon!
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: ColorSchema.whiteColor,
                      size: getSize(20),
                    ),
                    Text(
                      text!,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Text(
                  text!,
                  style: textStyle,
                ),
        ),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:linpo_user/schemata/color_schema.dart';
// import 'package:linpo_user/schemata/text_style.dart';

// enum ButtonType { enable, disable, progress }

// class Button extends StatelessWidget {
//   final ButtonType buttonType;
//   final double height;
//   final String title;
//   final Function? onTap;
//   const Button({
//     Key? key,
//     this.buttonType = ButtonType.disable,
//     this.onTap,
//     this.title = "",
//     this.height = 50,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Color background = ColorSchema.primaryColor;
//     switch (buttonType) {
//       case ButtonType.enable:
//         {
//           background = ColorSchema.primaryColor;
//         }
//         break;
//       case ButtonType.disable:
//         {
//           background = ColorSchema.primaryColor;
//         }
//         break;
//       case ButtonType.progress:
//         break;
//     }
//     return InkWell(
//       onTap: () {
//         if (ButtonType.enable == buttonType) onTap!();
//       },
//       child: Container(
//         height: height,
//         decoration: BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.circular(
//             5,
//           ),
//         ),
//         child: Center(
//             child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (buttonType == ButtonType.progress)
//               const CupertinoActivityIndicator(
//                 radius: 15,
//                 color: ColorSchema.whiteColor,
//               ),
//             if (buttonType != ButtonType.progress)
//               Text(
//                 title,
//                 style: const TextStyle().medium20.textColor(
//                       ColorSchema.whiteColor,
//                     ),
//               ),
//           ],
//         )),
//       ),
//     );
//   }
// }