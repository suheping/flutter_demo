import 'package:flutter/material.dart';
// import 'package:flutter_demo/model/group_info_model.dart';
import 'package:flutter_demo/model/list_note_by_group_id_model.dart';
import 'package:flutter_demo/util/custom_request.dart';
import 'package:flutter_demo/model/list_group_model.dart';

class NoteProvider with ChangeNotifier {
  // 分组数据
  List<Group> _groupList;
  // 当前分组id
  int _currentGroupId;
  // 当前分组info
  Group _group;
  // 当前分组笔记数据
  List<Note> _noteList;

  // 获取分组列表
  listGroup(BuildContext context, String pathName, {String name}) async {
    _groupList = [];
    Map<String, dynamic> data = {};
    if (name != null) {
      data = {"name": name};
    }
    await CustomRequest(context, pathName, 'get', data: data).then((value) {
      ListGroupModel listGroupModel = ListGroupModel.fromJson(value);
      if (listGroupModel.code == 1) {
        _groupList = listGroupModel.data;
      } else {
        _groupList = [];
      }
    });
    notifyListeners();
  }

  // 获取分组下的笔记
  listNoteByGroupId(BuildContext context, String pathName,
      {String name}) async {
    _noteList = [];
    Map<String, dynamic> data = {};
    if (name != null) {
      data = {'group_id': _currentGroupId, "name": name};
    } else {
      data = {'group_id': _currentGroupId};
    }
    await CustomRequest(context, pathName, 'get', data: data).then((value) {
      ListNoteByGroupIdModel listNoteByGroupIdModel =
          ListNoteByGroupIdModel.fromJson(value);
      if (listNoteByGroupIdModel.code == 1) {
        _noteList = listNoteByGroupIdModel.data;
      } else {
        _noteList = [];
      }
    });
    notifyListeners();
  }

  // 设置当前分组id
  setCurrentGroupId(BuildContext context, int groupId) {
    _currentGroupId = groupId;
    notifyListeners();
  }

  // 获取当前分组info
  Group currentGroup(BuildContext context) {
    for (var item in _groupList) {
      if (item.id == _currentGroupId) {
        _group = item;
        break;
      }
    }
    return _group;
  }

  // 添加分组
  addGroup(BuildContext context, String pathName, String name) async {
    Map<String, dynamic> data = {"name": name, "sort_no": null};
    await CustomRequest(context, pathName, 'post', data: data).then((value) {
      print(value);
    });
  }

  // 添加笔记
  addNote(BuildContext context, String pathName, String name) async {
    Map<String, dynamic> data = {
      "name": name,
      "group_id": _currentGroupId,
      "sort_no": null,
      "content": null
    };
    await CustomRequest(context, pathName, 'post', data: data).then((value) {
      print(value);
    });
  }

  // 分组list
  List<Group> get groupList => _groupList;
  // 当前分组的笔记
  List<Note> get noteList => _noteList;
}
