import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/color_collection.dart';

void showStatusAndNavigationBar() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

void changeSystemNavigationAndStatusBarColor(
    {Color navigationBarColor = AppColors.pureWhiteColor,
      Color statusBarColor = AppColors.transparentColor,
      Brightness? statusIconBrightness = Brightness.dark,
      Brightness? navigationIconBrightness = Brightness.dark}) =>
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navigationBarColor, // navigation bar color
      statusBarColor: statusBarColor, // status bar color
      statusBarIconBrightness: statusIconBrightness,
      systemNavigationBarIconBrightness: navigationIconBrightness,
    ));

void onlyShowStatusBar() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

void hideStatusAndNavigationBar() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

void changeOnlyStatusBarColor(
    {Color statusBarColor = AppColors.transparentColor, Brightness statusBarIconBrightness = Brightness.dark}) =>
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness
    ));

void changeOnlyNavigationBarColor(
    {Color navigationBarColor = AppColors.pureWhiteColor,
      bool darkIcons = true}) =>
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness:
        darkIcons ? Brightness.dark : Brightness.light));

void makeStatusBarTransparent({bool darkIcons = true}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.transparentColor,
      statusBarIconBrightness: darkIcons ? Brightness.dark : Brightness.light));
}

void makeScreenCleanView({Color navigationBarColor = Colors.white}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: navigationBarColor,
    statusBarColor: Colors.transparent, // status bar color
  ));
}

void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');

void showKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.show');

makeNavigationBarTransparent() =>
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light));

makeScreenStrictPortrait() => SystemChrome.setPreferredOrientations(
  [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ],
);

makeFullScreen() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

closeFullScreen() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

closeYourApp() => SystemNavigator.pop();

Future<void> copyText(text) async =>
    await Clipboard.setData(ClipboardData(text: text.toString()));