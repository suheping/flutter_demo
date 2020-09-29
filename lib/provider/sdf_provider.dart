import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SDFProvider with ChangeNotifier {
  String _name = '您未保存用户名';

  String get name => _name;

  getName() async {
    // 获取持久化实例
    SharedPreferences sdf = await SharedPreferences.getInstance();
    // 取出持久化中的用户名，赋值为_name
    _name = sdf.getString('name') == null ? '您未保存用户名' : sdf.getString('name');
  }

  // 修改持久化中的用户名
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
}
