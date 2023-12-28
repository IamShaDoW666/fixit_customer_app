import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget placeHolderWidget(
    {String? placeHolderImage,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment}) {
  return PlaceHolderWidget(
    height: height,
    width: width,
    alignment: alignment ?? Alignment.center,
  );
}
