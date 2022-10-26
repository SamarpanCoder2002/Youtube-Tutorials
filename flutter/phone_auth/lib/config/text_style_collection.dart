import 'package:flutter/material.dart';

import 'color_collection.dart';

class TextStyleCollection {
  static const TextStyle veryLargeTextStyle =
  TextStyle(fontSize: 40, color: AppColors.greyColor);

  static const TextStyle headingTextStyle =
  TextStyle(fontSize: 30, color: AppColors.infoMsgColor);

  static const TextStyle headingTextStyleBlack =
  TextStyle(fontSize: 30, color: AppColors.pureBlackColor);

  static const TextStyle searchTextStyle =
  TextStyle(fontSize: 16, color: AppColors.infoMsgColor);

  static const TextStyle userIdSmall =
  TextStyle(fontSize: 13, color: AppColors.pureBlackColor);

  static const TextStyle secondaryHeadingTextStyle = TextStyle(
      fontSize: 14,
      color: AppColors.infoMsgColor,
      fontWeight: FontWeight.w600);

  static const TextStyle activityTitleTextStyle = TextStyle(
      fontSize: 14,
      color: AppColors.infoMsgColor,
      fontWeight: FontWeight.w600);

  static const TextStyle normalTextStyle = TextStyle(
      fontSize: 16,
      color: AppColors.infoMsgColor,
      fontWeight: FontWeight.w600);

  static const TextStyle normalTextStyleBlack = TextStyle(
      fontSize: 16,
      color: AppColors.pureBlackColor,
      fontWeight: FontWeight.w600);

  static const TextStyle introPagesHeadingFont = TextStyle(
      fontSize: 25,
      color: AppColors.introPagesHeadingFontColor,
      fontWeight: FontWeight.w600);

  static const TextStyle introPagesNormalTextStyle = TextStyle(
    fontSize: 12,
    color: AppColors.introPagesNormalTextColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle terminalTextStyle = TextStyle(
      fontSize: 12,
      color: AppColors.infoMsgColor,
      fontWeight: FontWeight.w600);
}