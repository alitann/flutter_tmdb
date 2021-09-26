import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  double get lowValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.01
      : width * 0.01;

  double get mediumLowValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.015
      : width * 0.015;

  double get mediumValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.04
      : width * 0.04;

  double get mediumMHighValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.06
      : width * 0.06;

  double get mediumHighValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.08
      : width * 0.08;

  double get highValue => mediaQuery.orientation == Orientation.portrait
      ? height * 0.1
      : width * 0.1;
}

extension PaddingAllExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);

  EdgeInsets get paddingMediumLow => EdgeInsets.all(mediumLowValue);

  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);

  EdgeInsets get paddingMediumHigh => EdgeInsets.all(mediumHighValue);

  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingSymetricExtension on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get paddingMediumLowVertical =>
      EdgeInsets.symmetric(vertical: mediumLowValue);

  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get paddingMediumHighVertical =>
      EdgeInsets.symmetric(vertical: mediumHighValue);

  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);

  EdgeInsets get paddingMediumLowHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumLowValue);

  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);

  EdgeInsets get paddingMediumHighHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumHighValue);

  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}
