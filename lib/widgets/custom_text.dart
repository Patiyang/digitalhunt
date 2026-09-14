import 'package:digitalhunt/utils/config/config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final double? letterSpacing;
  final double? wordSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final String? fontFam;
  final FontStyle? fontStyle;
  const CustomText({
    super.key,
    @required this.text,
    this.size,
    this.color,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.textDecoration,
    this.fontFam,
    this.fontStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.visible,
      style: TextStyle(
        fontStyle: fontStyle,
        decoration: textDecoration ?? TextDecoration.none,
        fontSize: size,
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal,
        letterSpacing: letterSpacing ?? 0,
        wordSpacing: wordSpacing ?? 0,
        fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
      ),
    );
  }
}

class CustomRich extends StatelessWidget {
  final String? lightFont;
  final String? thirdText;
  final String? boldFont;
  final double? lightFontSize;
  final double? boldFontSize;
  final double? letterSpacing;
  final Color? lightColor;
  final Color? boldColor;
  final TextAlign? textAlign;
  final int? maxlines;
  final bool reversed;

  final LongPressGestureRecognizer? longPressGestureRecognizer;
  final VoidCallback? callback;
  const CustomRich({
    super.key,
    this.lightFont,
    this.thirdText,
    this.boldFont,
    this.lightFontSize,
    this.boldFontSize,
    this.letterSpacing,
    this.longPressGestureRecognizer,
    this.callback,
    this.lightColor,
    this.boldColor,
    this.maxlines,
    this.textAlign,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxlines ?? 5,
      textAlign: textAlign ?? TextAlign.start,
      text: reversed == false
          ? TextSpan(
              children: [
                TextSpan(
                  text: lightFont,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                    color: lightColor ?? Colors.grey,
                    fontSize: lightFontSize ?? 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(text: ' '),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = callback,
                  text: boldFont,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                    color: callback != null ? Config().appColor : boldColor ?? Theme.of(context).textTheme.titleMedium!.color,
                    fontSize: boldFontSize ?? 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: letterSpacing,
                    decoration: callback != null ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ],
            )
          : TextSpan(
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = callback,
                  text: boldFont,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                    color: callback != null ? Config().appColor : boldColor ?? Theme.of(context).textTheme.titleMedium!.color,
                    fontSize: boldFontSize ?? 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: letterSpacing,
                    decoration: callback != null ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),                TextSpan(text: ' '),

                TextSpan(
                  text: lightFont,
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
                    color: lightColor ?? Colors.grey,
                    fontSize: lightFontSize ?? 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );
  }
}
