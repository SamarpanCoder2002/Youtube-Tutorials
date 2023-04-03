import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './data/cars_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _initialize() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xffe8e5e8),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8e5e8),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: carsData.keys.length,
            itemBuilder: (_, index) => _commonTile(index),
          )),
    );
  }

  _commonTile(int index) {
    final _carBrandName = carsData.keys.toList()[index];
    final _carBrandImages = carsData.values.toList()[index];

    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        maintainState: false,
        initiallyExpanded: false,
        title: Text(
          _carBrandName,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        backgroundColor: Colors.grey.withOpacity(0.1),
        collapsedBackgroundColor: Colors.white,
        children: [
          ..._carBrandImages.map((image) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image))),
            );
          }).toList()
        ],
      ),
    );
  }
}
