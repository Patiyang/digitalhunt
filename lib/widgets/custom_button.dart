// ignore: implementation_imports
import 'package:digitalhunt/utils/loading.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'custom_text.dart';

class CustomFlatButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback callback;
  final double? height;
  final double? width;
  final double? radius;
  final double? iconSize;
  final bool? verifying;
  final IconData? icon;
  final double? fontSize;
  final double? elevation;
  final bool ?showTer;
  const CustomFlatButton(
      {super.key,
      this.text,
      this.color,
      required this.callback,
      this.textColor,
      this.height,
      this.width,
      this.radius,
      this.icon,
      this.fontSize,
      this.iconColor,
      this.iconSize,
      this.verifying = false,
      this.elevation, this.showTer = true});

  @override
  Widget build(BuildContext context) {
    // var themeVal = context.read<ThemeModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: MaterialButton(
        elevation: elevation ?? 1,
        height: height ?? Theme.of(context).buttonTheme.height,
        minWidth: width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius ?? 25))),
        onPressed: verifying == true
            ? () {
                Fluttertoast.showToast(msg: 'Please wait');
              }
            : callback,
        color: color ?? (Theme.of(context).primaryColor),
        child: Container(
          width: width ?? 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon == null
              //     ? SizedBox.shrink()
              //     : Icon(
              //         icon,
              //         size: iconSize ?? 17,color: white,
              //       ),
              // icon == null
              //     ? SizedBox.shrink()
              //     : SizedBox(
              //         width: 0,
              //       ),
              Expanded(
                child: verifying == true
                    ? Container(height: height, child:Loading(spinkit:  SpinKitChasingDots(color: Theme.of(context).textTheme.bodyMedium!.color, size: 18),))
                    : CustomText(
                        text: text == null ? 'action' :showTer==false?text: text!.tr(),
                        color: textColor ?? Theme.of(context).textTheme.bodyMedium!.color,
                        size: fontSize??15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
