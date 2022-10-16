import 'package:flutter/material.dart';
import 'package:image_search_engine/config/color_collection.dart';
import 'package:image_search_engine/config/text_style_collection.dart';
import 'package:image_search_engine/screens/components/image_container_component.dart';
import 'package:image_search_engine/screens/components/search_section.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
        child: _actualBody(),
      ),
    );
  }

  _actualBody() {
    return Column(
      children: const [
        SizedBox(height: 30,),
        Center(child: Text('Search Image',style: TextStyleCollection.headingTextStyle,),),
        SizedBox(height: 15,),
        SearchSection(),
        SizedBox(height: 15,),
        ImageContainerComponent(),
      ],
    );
  }
}
