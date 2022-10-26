import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth/config/color_collection.dart';
import 'package:phone_auth/config/text_style_collection.dart';
import 'package:phone_auth/screens/otp_verification_screen.dart';
import 'package:phone_auth/services/device_specific_operations.dart';

class PhoneNumberTakingScreen extends StatefulWidget {
  const PhoneNumberTakingScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberTakingScreen> createState() =>
      _PhoneNumberTakingScreenState();
}

class _PhoneNumberTakingScreenState extends State<PhoneNumberTakingScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    changeSystemNavigationAndStatusBarColor();

    /// Optional
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: _getActualBody(),
      ),
    );
  }

  _getActualBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _phoneNumberTakingSection(),
        const SizedBox(height: 20),
        _continueBtn(),
      ],
    );
  }

  _phoneNumberTakingSection() {
    return TextFormField(
      controller: _phoneController,
      cursorColor: AppColors.lightBorderGreenColor,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.lightBorderGreenColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.lightBorderGreenColor)),
      ),
    );
  }

  _continueBtn() {
    return Center(
      child: ElevatedButton(
        child: Text(
          'Continue',
          style: TextStyleCollection.headingTextStyle.copyWith(fontSize: 18, color: AppColors.pureWhiteColor),
        ),
        onPressed: () {
          if (_phoneController.text.isEmpty ||
              _phoneController.text.length != 10) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Give a valid phone number of 10 digit')));
            return;
          }

          String _countryCode = '+91'; // India

          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OtpVerificationScreen(
                  phoneNumber: '$_countryCode${_phoneController.text}')));
        },
      ),
    );
  }
}
