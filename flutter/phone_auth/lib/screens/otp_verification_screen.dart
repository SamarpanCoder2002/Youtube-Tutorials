import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:phone_auth/config/color_collection.dart';
import 'package:phone_auth/screens/base_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../config/text_style_collection.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    _onPhoneAuth();
  }

  _onPhoneAuth() async{
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final PhoneVerificationCompleted verificationCompleted =
        _onVerificationCompleted;

    final PhoneVerificationFailed verificationFailed = _onVerificationFailed;

    final PhoneCodeSent codeSent = _codeSent;

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        _codeAutoRetrivalTimeout;

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  _codeAutoRetrivalTimeout(String verificationId) {
    if (mounted) {
      setState(() {
        _verificationId = verificationId;
      });
    }
  }

  _codeSent(String verificationId, [int? forceResendingToken]) async {
    if (mounted) {
      setState(() {
        _verificationId = verificationId;
        _isLoading = false;
      });
    }
  }

  _onVerificationFailed(FirebaseAuthException authException) {
    print("Verification Failed:  ${authException}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error in Phone Auth: ${authException.message ?? ""}'),
      duration: const Duration(seconds: 10),
    ));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _onVerificationCompleted(AuthCredential phoneAuthCredential) async {
    print("on Verification Completed: ${phoneAuthCredential.token}");
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: AppColors.pureBlackColor.withOpacity(0.6),
      progressIndicator: const CircularProgressIndicator(
        color: AppColors.specialPinkColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.pureWhiteColor,
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: _getActualBody(),
        ),
      ),
    );
  }

  _getActualBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _otpTakingSection(),
        const SizedBox(height: 20),
        _verifyButton(),
      ],
    );
  }

  _otpTakingSection() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        inactiveColor: AppColors.pureBlackColor.withOpacity(0.6),
        selectedColor: AppColors.pureBlackColor.withOpacity(0.6),
        activeColor: AppColors.pureBlackColor.withOpacity(0.6),
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      controller: _otpController,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {

      },
      beforeTextPaste: (text) {
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  _verifyButton() {
    return Center(
      child: ElevatedButton(
        child: Text('Verify',
          style: TextStyleCollection.headingTextStyle.copyWith(fontSize: 18, color: AppColors.pureWhiteColor),),
        onPressed: _onVerifyOtp,
      ),
    );
  }

  void _onVerifyOtp() {
    if(_otpController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Otp must be 6 digit number')));
      return;
    }

    final _otpCode = _otpController.text.trim();

    final _authCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: _otpCode);

    _firebaseAuth.signInWithCredential(_authCredential).then((UserCredential value) {
      print('Phone Authentication Successful');

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BaseScreen()));
    }).catchError((err){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    });
  }
}












