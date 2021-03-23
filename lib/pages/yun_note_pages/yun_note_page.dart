import 'package:flutter/material.dart';
import 'package:flutter_demo/model/list_group_model.dart';
import 'package:flutter_demo/model/list_note_by_group_id_model.dart';
import 'package:flutter_demo/provider/note_provider.dart';
import 'package:provider/provider.dart';

class YunNotePage extends StatelessWidget {
  const YunNotePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取分组信息
    Group _group =
        Provider.of<NoteProvider>(context, listen: false).currentGroup(context);
    // 获取要展示的笔记
    List<Note> _noteList = context.watch<NoteProvider>().noteList;
    return Scaffold(
      appBar: AppBar(
        title: Text('${_group.name}'),
      ),
      body: Container(
        child: Text('$_noteList'),
      ),
    );
  }
}
