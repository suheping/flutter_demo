import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SDFProvider with ChangeNotifier {
  bool _fingerLoginEnable = false;
  String _name = '您未保存用户名';
  List<int> _gestureCode = [];
  bool _gestureLoginEnable = false;

  String get name => _name;
  bool get fingerLoginEnable => _fingerLoginEnable;

  List<int> get gestureCode => _gestureCode;
  bool get gestureLoginEnable => _gestureLoginEnable;

  // 获取持久化中的name
  getName() async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    // 取出持久化中的用户名，赋值为_name
    _name = sdf.getString('name') == null ? '您未保存用户名' : sdf.getString('name');
  }

  // 修改持久化中的name
  saveName(String name) async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    // set
    await sdf.setString('name', name);
    // 取出持久化中的用户名，赋值为_name
    _name = sdf.getString('name') == null ? '您未保存用户名' : sdf.getString('name');
    // 通知监听者
    notifyListeners();
  }

  // 获取持久化中的是否开启指纹登录
  getFingerLoginEnable() async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    // 取出持久化中的是否开启指纹登录，赋值给_fingerLoginEnable
    _fingerLoginEnable = sdf.getBool('fingerLoginEnable') == null ||
            sdf.getBool('fingerLoginEnable') == false
        ? false
        : true;
  }

  // 修改持久化中的是否开启指纹登录
  setFingerLoginEnable(bool b) async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    await sdf.setBool('fingerLoginEnable', b);
    _fingerLoginEnable = sdf.getBool('fingerLoginEnable');
    notifyListeners();
  }

  // 获取持久化中的是否开启手势密码登录
  getGestureLoginEnable() async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    // 取出持久化中的是否开启手势密码登录，赋值给_gestureLoginEnable
    _gestureLoginEnable = sdf.getBool('gestureLoginEnable') == null ||
            sdf.getBool('gestureLoginEnable') == false
        ? false
        : true;
  }

  // 设置持久化中的是否开启手势密码登录
  setGestureLoginEnable(bool b) async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    await sdf.setBool('gestureLoginEnable', b);
    _gestureLoginEnable = sdf.getBool('gestureLoginEnable');
    notifyListeners();
  }

  // 获取持久化中的手势密码
  getGesturecode() async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    String tmp = sdf.getString('gestureCode');
    if (tmp == null) {
      _gestureCode = [];
    } else {
      if (tmp.length > 3) {
        String newtmp = tmp.substring(1, tmp.length - 1);
        List<String> stringList = newtmp.split(',');
        _gestureCode = [];
        for (var item in stringList) {
          _gestureCode.add(int.parse(item));
        }
      } else {
        _gestureCode = [];
      }
    }
  }

  // 设置持久化中的手势密码
  setGestureCode(List<int> gestureCode) async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    await sdf.setString('gestureCode', gestureCode.toString());
    String tmp = sdf.getString('gestureCode');
    String newtmp = tmp.substring(1, tmp.length - 1);
    List<String> stringList = newtmp.split(',');
    _gestureCode = [];
    for (var item in stringList) {
      _gestureCode.add(int.parse(item));
    }
    notifyListeners();
  }
}
