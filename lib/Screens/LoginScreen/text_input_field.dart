import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeholderText;
  final List<TextInputFormatter>? inputFormattersList;
  final Function validationFunc;
  final bool? obscureTextVal;
  final Widget suffixWidget;
  final TextInputType? keyboardtype;
  final TextCapitalization? textcapitalization;
  final FocusNode? focusnodes;
  final Widget? prefixWidget;
  final bool? readOnlyValue;
  final Function? onChangeFunc;

  const TextInputField({
    super.key,
    required this.textEditingController,
    required this.placeholderText,
    this.inputFormattersList,
    required this.validationFunc,
    this.obscureTextVal = false,
    required this.suffixWidget,
    this.keyboardtype,
    this.textcapitalization,
    this.focusnodes,
    this.prefixWidget,
    this.readOnlyValue = false,
    this.onChangeFunc,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusnodes,
      controller: textEditingController,
      obscureText: obscureTextVal ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        // prefixIcon: prefixWidget ?? const SizedBox.shrink(),
        errorStyle: TextStyle(
          color: ColorConstants.redColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 10.sp,
        ),
        filled: true,
        fillColor: ColorConstants.whiteColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
            color: ColorConstants.lightShadeBlueColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
            color: ColorConstants.lightShadeBlueColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
            color: ColorConstants.lightShadeBlueColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
            color: ColorConstants.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          borderSide: BorderSide(
            width: 1.sp,
            color: ColorConstants.redColor,
          ),
        ),
        hintText: placeholderText,
        hintStyle: TextStyle(
          color: ColorConstants.blackColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 10.sp,
        ),
      ),
      enableInteractiveSelection: false,
      readOnly: readOnlyValue ?? false,
      inputFormatters: inputFormattersList ??
          [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
            FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
            FilteringTextInputFormatter.deny(RegExp(
                r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
          ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardtype ?? TextInputType.name,
      textCapitalization: textcapitalization ?? TextCapitalization.words,
      validator: (value) {
        return validationFunc(value);
      },
      onChanged: (value) {
        if (onChangeFunc != null) {
          onChangeFunc!(value);
        }
      },
      style: TextStyle(
        color: ColorConstants.blackColor,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 10.sp,
      ),
    );
  }
}
