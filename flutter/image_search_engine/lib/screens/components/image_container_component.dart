import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_search_engine/config/text_style_collection.dart';
import 'package:image_search_engine/providers/main_provider.dart';
import 'package:image_search_engine/screens/show_image.dart';
import 'package:image_search_engine/services/device_specific_operations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/color_collection.dart';

class ImageContainerComponent extends StatefulWidget {
  const ImageContainerComponent({Key? key}) : super(key: key);

  @override
  State<ImageContainerComponent> createState() =>
      _ImageContainerComponentState();
}

class _ImageContainerComponentState extends State<ImageContainerComponent> {
  @override
  void initState() {
    changeSystemNavigationAndStatusBarColor();
    Provider.of<MainProvider>(context, listen: false).initializeScrolling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mainProvider = Provider.of<MainProvider>(context);

    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _mainProvider.isShimmerLoading
            ? _loadingSection()
            : _searchResult(),
      ),
    );
  }

  _loadingSection() {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.pureBlackColor.withOpacity(0.6),
          highlightColor: AppColors.pureBlackColor.withOpacity(0.8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
                minHeight: 200),
            decoration: BoxDecoration(
              color: AppColors.pureBlackColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  _searchResult() {
    final _mainProvider = Provider.of<MainProvider>(context);
    final _imagesCollection = _mainProvider.imagesCollection;

    if (_imagesCollection.isEmpty) {
      return Center(
        child: Text(
          'No Images Found',
          style: TextStyleCollection.headingTextStyle.copyWith(fontSize: 25),
        ),
      );
    }

    return MasonryGridView.count(
        controller: _mainProvider.scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: _imagesCollection.length,
        itemBuilder: (context, index) =>
            _imageElement(_imagesCollection[index]));
  }

  _imageElement(particularImage) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ShowImageScreen(
                imageUrl: particularImage['src']['large'] ??
                    particularImage['src']['original'])));
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.pureBlackColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CachedNetworkImage(
            imageUrl: particularImage['src']['large'] ??
                particularImage['src']['original']),
      ),
    );
  }
}
