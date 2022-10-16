import 'package:flutter/material.dart';
import 'package:image_search_engine/api/collection/searchApis.dart';

class MainProvider extends ChangeNotifier {
  bool _isShimmerLoading = false, _atBottom = false;
  int _pageIndex = 0;
  String _currSearchQuery = '';
  List<dynamic> _imagesCollection = [];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  ScrollController get scrollController => _scrollController;

  TextEditingController get searchController => _textEditingController;

  List<dynamic> get imagesCollection => _imagesCollection;

  bool get isShimmerLoading => _isShimmerLoading;

  initializeScrolling() {
    _scrollController.addListener(listener);
  }

  updateShimmerLoadingStatus(bool _isStarted) {
    _isShimmerLoading = _isStarted;
    notifyListeners();
  }

  updateSearchQuery(String newQuery) {
    if (_currSearchQuery == newQuery) return;

    _currSearchQuery = newQuery;
    notifyListeners();
  }

  onSearch({bool considerCurrSearchQuery = false}) async {
    final _searchQuery = considerCurrSearchQuery
        ? _currSearchQuery
        : _textEditingController.text;

    if (_searchQuery.isEmpty || _searchQuery.length < 3) return;

    _searchQuery == _currSearchQuery
        ? updatePageIndex(true)
        : _resetPageIndex();

    if (_pageIndex == 1) updateShimmerLoadingStatus(true);

    final _response =
        await SearchApis.onImageSearch(_searchQuery, pageIndex: _pageIndex);

    if (_pageIndex == 1) updateShimmerLoadingStatus(false);

    if (_response['error'] != null) return;

    dataInclusion(_response['photos'] ?? [], _searchQuery);
  }

  dataInclusion(List<dynamic> _remoteImages, String _searchQuery) {
    if (_currSearchQuery != _searchQuery) {
      updateSearchQuery(_searchQuery);
      clearImageContainer();
    }

    if (_remoteImages.isEmpty && _pageIndex == 1) {
      clearImageContainer();
      notifyListeners();
      return;
    }

    _imagesCollection = [..._imagesCollection, ..._remoteImages];
    notifyListeners();
    updateAtBottomStatus(false);
  }

  updateAtBottomStatus(bool _isAtBottom) {
    _atBottom = _isAtBottom;
    notifyListeners();
  }

  clearImageContainer() {
    _imagesCollection.clear();
    notifyListeners();
  }

  updatePageIndex(bool increase) {
    if (!increase && _pageIndex > 0) {
      _pageIndex -= 1;
    }

    if (increase) {
      _pageIndex += 1;
    }

    notifyListeners();
  }

  _resetPageIndex() {
    _pageIndex = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (!_atBottom &&
        _scrollController.position.pixels.toInt() >=
            (_scrollController.position.maxScrollExtent.toInt()) - 200) {
      updateAtBottomStatus(true);
      onSearch(considerCurrSearchQuery: true);
    }

    if (_atBottom &&
        _scrollController.position.pixels.toInt() <
            (_scrollController.position.maxScrollExtent.toInt()) - 200) {
      updateAtBottomStatus(false);
    }
  }
}
