
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomTextField extends StatelessWidget {
  final String? hint;

  // ignore: prefer_typing_uninitialized_variables
  final iconOne;
  final iconTwo;
  final Color? containerColor;
  final Color? hintColor;
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextAlign? align;
  final double? radius;
  final double? width;
  final double? textFieldPadding;
  final changed;
  final int? maxLines;
  final int? maxLength;
  final MainAxisAlignment? mainAxisAlignment;
  final VoidCallback? ontap;
  final TextCapitalization? textCapitalization;
  final InputBorder? inputBorder;
  final validator;
  final onEditingComplete;
  const CustomTextField(
      {super.key,
      this.hint,
      this.width,
      this.iconOne,
      this.iconTwo,
      this.containerColor,
      this.hintColor,
      this.controller,
      this.validator,
      this.obscure,
      this.textInputType,
      this.align,
      this.radius,
      this.inputBorder,
      this.changed,
      this.readOnly,
      this.maxLines,
      this.textFieldPadding,
      this.maxLength,
      this.onEditingComplete,
      this.mainAxisAlignment,
      this.ontap,
      this.textInputFormatter,
      this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius ?? 1)), boxShadow: const [
        BoxShadow(blurRadius: 0, color: Colors.transparent, spreadRadius: 0),
      ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: textFieldPadding ?? 8, horizontal: 0),
        child: Container(
          width: width ?? MediaQuery.of(context).size.height,
          child: TextFormField(
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            autofocus: false,
            inputFormatters: textInputFormatter,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            textAlign: align ?? TextAlign.start,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: obscure ?? false,
            validator: validator,
            onEditingComplete: onEditingComplete,
            onChanged: changed,
            controller: controller,
            onTap: ontap,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: 0),
            decoration: InputDecoration(
              fillColor: containerColor,
              filled: containerColor != null ? true : false,
              contentPadding: EdgeInsets.only(bottom: 8, left: 10),
              suffixIcon: iconTwo ?? SizedBox.shrink(),
              border: inputBorder,
              hintText: '',
              alignLabelWithHint: true,
              labelText: hint,
              hintMaxLines: 2,
              helperMaxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
