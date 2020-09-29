import 'package:flutter/material.dart';
import 'package:flutter_demo/data/refresh_data.dart';

class RefreshProvider with ChangeNotifier {
  List _listData = [];
  int _pageSize = 10;
  int _pageNum = 0;
  bool _noMore = false;

  List get listData => _listData;
  bool get noMore => _noMore;

  // 第一次获取数据，获取前10条
  getData() {
    _listData = data.sublist(0, 10);
    _pageNum = 0;
    _noMore = false;
  }

  loadMoreData() async {
    // 延迟3秒
    await Future.delayed(Duration(seconds: 2));
    // 1、页码+1
    _pageNum++;
    // 2、请求后端，获取下一页数据
    int _start = _pageNum * _pageSize;
    // 判断是否有更多数据
    if (_start >= data.length) {
      _noMore = true;
      notifyListeners();
    } else {
      _noMore = false;
      int _end = (_pageNum + 1) * _pageSize;
      // 判断加载10条是否会越界
      if (_end > data.length) {
        _end = data.length;
      }
      List _newListData = data.sublist(_start, _end);
      // 3、将获取到的新数据，添加到原来的list之后
      _listData.addAll(_newListData);
      // print(_listData);
      notifyListeners();
    }
  }

  refresh() async {
    // 延迟
    await Future.delayed(Duration(seconds: 2));
    int _end = (_pageNum + 1) * _pageSize;
    if (_end > data.length) {
      _end = data.length;
    }
    _listData = data.sublist(0, _end);
    print(_listData);
    notifyListeners();
  }
}
