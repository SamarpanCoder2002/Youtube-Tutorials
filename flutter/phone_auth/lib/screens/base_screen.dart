import 'package:flutter/material.dart';
import 'package:phone_auth/config/color_collection.dart';
import 'package:phone_auth/config/text_style_collection.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            'We are logged in',
            style: TextStyleCollection.normalTextStyle
                .copyWith(fontSize: 20, color: AppColors.pureBlackColor),
          ),
        ),
      ),
    );
  }
}
