import 'package:flutter/material.dart';
import 'package:image_gallery_app/api/api_caller.dart';

class MainProvider extends ChangeNotifier {
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();
  List<dynamic> _imagesCollection = [];

  bool get isLoading => _isLoading;
  TextEditingController get controller => _controller;
  List<dynamic> get imagesCollection => _imagesCollection;

  updateLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  get searchImage async {
    final _topic = controller.text;

    if (_topic.isEmpty) return;

    updateLoading(true);
    final _data = await ApiCaller.searchImage(_topic);
    updateLoading(false);

    if (_data == null) return;

    includeImageData(_data["photos"] ?? []);
  }

  includeImageData(List<dynamic> incomingData) {
    clearImages;
    _imagesCollection = incomingData;
    notifyListeners();
  }

  get clearImages {
    _imagesCollection.clear();
    notifyListeners();
  }
}
