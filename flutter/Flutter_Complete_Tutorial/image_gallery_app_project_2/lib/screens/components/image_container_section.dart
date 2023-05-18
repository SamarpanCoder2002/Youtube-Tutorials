import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_gallery_app/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PhotoCollectionSection extends StatefulWidget {
  const PhotoCollectionSection({super.key});

  @override
  State<PhotoCollectionSection> createState() => _PhotoCollectionSectionState();
}

class _PhotoCollectionSectionState extends State<PhotoCollectionSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _imageShowingSection(),
      ),
    );
  }

  _imageShowingSection() {
    final _provider = Provider.of<MainProvider>(context);

    if (_provider.isLoading) {
      return _loadingWidget();
    }

    if (_provider.imagesCollection.isEmpty) {
      return const Center(
        child: Text(
          'No Images Found',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      );
    }

    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 2,
      itemCount: _provider.imagesCollection.length,
      itemBuilder: (_, index) => _showImage(index),
    );
  }

  _showImage(int index) {
    final _imagesCollection =
        Provider.of<MainProvider>(context).imagesCollection;

    return Container(
      constraints: BoxConstraints(
        maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CachedNetworkImage(
          imageUrl: _imagesCollection[index]["src"]["original"] ??
              _imagesCollection[index]["src"]["large"]),
    );
  }
  
  _loadingWidget() {
     return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.black.withOpacity(0.6),
          highlightColor: Colors.black.withOpacity(0.8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
                minHeight: 200),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
