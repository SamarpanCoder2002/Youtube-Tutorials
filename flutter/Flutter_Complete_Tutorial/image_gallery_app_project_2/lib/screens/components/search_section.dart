import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_app/provider/main_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black.withOpacity(0.2))),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: Provider.of<MainProvider>(context).controller,
        textInputAction: TextInputAction.search,
        onEditingComplete: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Provider.of<MainProvider>(context, listen: false).searchImage;
        },
        decoration: InputDecoration(
          icon: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(Icons.search_rounded)),
          iconColor: Colors.grey.withOpacity(0.8),
          hintText: 'Search Topic',
          hintStyle: const TextStyle(fontSize: 16, color: Colors.black87),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}
