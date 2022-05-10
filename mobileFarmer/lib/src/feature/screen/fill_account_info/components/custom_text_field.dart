import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? label;
  final Widget? suffixIcon;
  final String hintText;
  final int? maxLines;
  final bool? isDense;
  final bool? enable;
  final Widget? suffix;
  final TextStyle? suffixStyle;
  final String? initValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final BorderSide? border;
  final TextInputAction? inputAction;

  const CustomTextField({
    Key? key,
    this.prefixIcon,
    this.label,
    this.suffixIcon,
    required this.hintText,
    this.maxLines,
    this.isDense,
    this.validator,
    this.enable,
    this.suffix,
    this.suffixStyle,
    this.initValue,
    this.keyboardType,
    this.border,
    this.inputAction,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontWeight: FontWeight.w400,
          fontSize: 13.sp,
          color: Colors.black),
      textInputAction: inputAction,
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: initValue ?? "",
          selection: TextSelection.collapsed(offset: initValue?.length ?? 0),
        ),
      ),
      // initialValue: initValue,
      enabled: enable,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffix: suffix,
        suffixStyle: suffixStyle,
        prefixIcon: prefixIcon,
        isDense: true,
        // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
        // labelText: "Resevior Name",
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: border ??
              BorderSide(
                  color: Colors.grey.withOpacity(0.4),
                  width: 1,
                  style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
          borderRadius: BorderRadius.circular(8),
        ),
        label: label,
        // labelText: "Tên nông trại",
        // labelStyle: TextStyle(fontSize: 18),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w500,
            fontSize: 11.sp,
            color: Colors.grey),
        suffixIcon: suffixIcon,
      ),
      // The validator receives the text that the user has entered.
      autovalidateMode: AutovalidateMode.disabled,
      validator: validator,
    );
  }
}
