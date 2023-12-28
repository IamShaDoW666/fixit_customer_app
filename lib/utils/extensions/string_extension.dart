import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/booking/component/app_widgets.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

extension intExt on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color:
          color ?? (appStore.isDarkMode ? Colors.white : appTextSecondaryColor),
      errorBuilder: (context, error, stackTrace) => placeHolderWidget(
          height: size ?? 24, width: size ?? 24, fit: fit ?? BoxFit.cover),
    );
  }
}
