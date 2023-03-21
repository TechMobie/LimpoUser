import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linpo_user/helper/utils/math_utils.dart';
import 'package:linpo_user/schemata/color_schema.dart';
import 'package:linpo_user/schemata/text_style.dart';


// ignore: prefer_generic_function_type_aliases
typedef OnValidation(String? text);

// ignore: must_be_immutable
class CommonTextField extends StatefulWidget {
  final TextFieldOption? textOption;
  final Function(String text)? textCallback;
  final VoidCallback? tapCallback;
  final VoidCallback? function;
  Function()? onTap;
  bool? isEditable;
  final VoidCallback? onNextPress;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final double? cursorHeight;
  final bool? autoFocus;
  bool? clearIcon;
  bool? isEyeIcon;
  final OnValidation? validation;
  final TextStyle? hintStyleText;
  final EdgeInsetsGeometry? contentPadding;
  final Color borderColor;

  CommonTextField(
      {Key? key,
      @required this.textOption,
      @required this.textCallback,
      this.tapCallback,
      this.function,
      this.isEditable,
      this.onNextPress,
      this.inputAction,
      this.autoFocus,
      this.clearIcon = false,
      this.isEyeIcon = false,
      this.focusNode,
      this.cursorHeight,
      this.onTap,
      this.contentPadding,
      this.validation,
      this.hintStyleText,
      this.borderColor = ColorSchema.grey54Color})
      : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool obscureText = false;
  IconData obscureIcon = Icons.remove_red_eye_outlined;

  @override
  void initState() {
    super.initState();
    obscureText = widget.textOption!.isSecureTextField ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlignVertical: TextAlignVertical(y: 0.1),
      // autocorrect: widget.autoCorrect!,
      onTap: () {
        widget.onTap;
      },
      enabled: widget.isEditable ?? true,

      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],

      maxLines: widget.textOption!.maxLine,
      maxLength: widget.textOption!.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      textInputAction: widget.inputAction ?? TextInputAction.done,
      focusNode: widget.focusNode,
      minLines: widget.textOption!.minLine ?? 1,
      cursorHeight: widget.cursorHeight,
      autofocus: widget.autoFocus ?? false,
      controller: widget.textOption!.inputController,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      style: const TextStyle().normal16.textColor(ColorSchema.blackColor),
      keyboardType: widget.textOption!.keyboardType ?? TextInputType.text,
      textCapitalization:
          widget.textOption!.textCapitalization ?? TextCapitalization.none,
      cursorColor: ColorSchema.primaryColor,
      // inputFormatters: widget.textOption!.formatter ?? [],
      decoration: InputDecoration(
        isDense: true,

        labelText: widget.textOption!.labelText,
        labelStyle: (widget.textOption!.labelStyleText != null)
            ? widget.textOption!.labelStyleText
            : const TextStyle().medium20.textColor(ColorSchema.blackColor),
        filled: widget.textOption!.fill,
        fillColor: widget.textOption!.fillColor,
        // contentPadding: widget.contentPadding ??
        //     EdgeInsets.symmetric(horizontal: getSize(0), vertical: 0),
        errorStyle: const TextStyle(height: 0),

        // (widget.textOption!.errorStyleText != null)
        //     ? widget.textOption!.errorStyleText
        //     : const TextStyle().errorText12.textColor(ColorSchema.redColor),
        errorMaxLines: 3,
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        //   borderSide: BorderSide(
        //       width: 1, color: widget.borderColor //ColorSchema.grey54Color,
        //       ),
        // ),
        // enabledBorder: widget.textOption!.enabledBorder ??
        //     const UnderlineInputBorder(
        //       borderSide:
        //           BorderSide(color: ColorSchema.chatBackGround, width: 1),
        //     ),
        // focusedBorder: widget.textOption!.focusedBorder ??
        //     const UnderlineInputBorder(
        //       borderSide: BorderSide(
        //         color: ColorSchema.primaryColor,
        //         width: 1,
        //       ),
        //     ),
        border: InputBorder.none,
        // OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        //   borderSide:
        //       const BorderSide(width: 1, color: ColorSchema.grey38Color),
        // ),
        // widget.textOption!.border ??
        //     const UnderlineInputBorder(
        //       borderSide:
        //           BorderSide(color: ColorSchema.chatBackGround, width: 1),
        //    ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        //   borderSide:
        //       const BorderSide(width: 1, color: ColorSchema.primaryColor),
        // ),
        hintStyle: (widget.textOption!.hintStyleText != null)
            ? widget.textOption!.hintStyleText
            : const TextStyle().normal16.textColor(ColorSchema.grey54Color),
        hintText: widget.textOption!.hintText,
        prefixIconConstraints: const BoxConstraints(
          // maxHeight: 20,
          //  maxWidth: 30,
          minWidth: 0,
          minHeight: 0,
        ),

        // prefixIconColor: (widget.focusNode!.hasFocus)
        //     ? ColorSchema.primaryColor
        //     : ColorSchema.blackColor,
        prefixIcon: (widget.textOption!.prefixWid != null)
            ? Padding(
                padding: const EdgeInsets.only(right: 7, left: 10),
                child: widget.textOption!.prefixWid,
              )
            : null,

        suffixIcon: widget.isEyeIcon!
            ? (widget.textOption!.isSecureTextField != null &&
                    widget.textOption!.isSecureTextField!)
                ? IconButton(
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    icon: Icon(
                      obscureIcon,
                      size: 20,
                      color: ColorSchema.blackColor,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          obscureText = !obscureText;
                          if (obscureText) {
                            obscureIcon = Icons.remove_red_eye_outlined;
                          } else {
                            obscureIcon = Icons.remove_red_eye;
                          }
                        },
                      );
                      //TextInputConnection;
                    },
                  )
                : null
            : widget.clearIcon!
                ? GestureDetector(
                    onTap: widget.function,
                    child: widget.textOption!.suffixIcon ??
                        Icon(
                          Icons.clear,
                          color: ColorSchema.blackColor,
                          size: getSize(20),
                        ),
                  )
                : const Text(''),
        // suffixIcon: (widget.textOption!.inputController!.text.isNotEmpty)
        //     ? (widget.textOption!.isSecureTextField != null &&
        //             widget.textOption!.isSecureTextField!)
        //         ? IconButton(
        //             highlightColor: Colors.transparent,
        //             focusColor: Colors.transparent,
        //             icon: Icon(
        //               obscureIcon,
        //               size: 20,
        //               color: ColorSchema.blackColor,
        //             ),
        //             onPressed: () {
        //               setState(
        //                 () {
        //                   obscureText = !obscureText;
        //                   if (obscureText) {
        //                     obscureIcon = Icons.visibility_off;
        //                   } else {
        //                     obscureIcon = Icons.visibility;
        //                   }
        //                 },
        //               );
        //               //TextInputConnection;
        //             },
        //           )
        //         : null
        //     : null,
      ),

      onFieldSubmitted: (String text) {
        widget.textCallback!(text);
        FocusScope.of(context).unfocus();
        if (widget.onNextPress != null) {
          widget.onNextPress!();
        }
      },
      validator: (text) {
        return widget.validation!(text!);
      },
      onChanged: (String text) {
        widget.textCallback!(text);
        //setState(() {});
      },
      onEditingComplete: () {
        // widget.textCallback!(widget.textOption?.inputController?.text ?? "");
      },
    );
  }
}

class TextFieldOption {
  String? labelText;
  String? hintText;
  bool? isSecureTextField = false;
  TextInputType? keyboardType;
  int? maxLine;
  int? minLine;
  int? maxLength;
  Widget? suffixIcon;
  TextStyle? hintStyleText;
  TextStyle? labelStyleText;
  TextStyle? errorStyleText;
  Widget? prefixWid;
  Color? fillColor;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? border;

  bool? fill;
  Widget? postfixWid;
  List<TextInputFormatter>? formatter;
  TextEditingController? inputController;
  TextCapitalization? textCapitalization;

  TextFieldOption(
      {this.labelText,
      this.hintText,
      this.isSecureTextField,
      this.keyboardType,
      this.maxLine = 1,
      this.minLine,
      this.suffixIcon,
      this.fill = false,
      this.fillColor,
      this.enabledBorder,
      this.focusedBorder,
      this.border,
      this.formatter,
      this.maxLength,
      this.hintStyleText,
      this.labelStyleText,
      this.errorStyleText,
      this.inputController,
      this.prefixWid,
      this.postfixWid,
      this.textCapitalization});
}
