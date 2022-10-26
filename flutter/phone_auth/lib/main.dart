import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/config/color_collection.dart';
import 'package:phone_auth/screens/phone_number_taking_screen.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Auth Tutorial',
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: AppColors.transparentColor)),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
      home: const PhoneNumberTakingScreen(),
    );
  }
}
