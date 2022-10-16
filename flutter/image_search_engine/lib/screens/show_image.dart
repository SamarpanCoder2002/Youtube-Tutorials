import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_search_engine/config/color_collection.dart';
import 'package:image_search_engine/services/device_specific_operations.dart';
import 'package:share_plus/share_plus.dart';

class ShowImageScreen extends StatefulWidget {
  final String imageUrl;

  const ShowImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  @override
  void dispose() {
    hideKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InkWell(
            onDoubleTap: () {
              Share.share("Share from image search app\n${widget.imageUrl}");
            },
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
