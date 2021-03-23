import 'package:flutter/material.dart';
import 'package:flutter_demo/model/list_group_model.dart';
import 'package:flutter_demo/model/list_note_by_group_id_model.dart';
import 'package:flutter_demo/provider/note_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    // 笔记item
    _noteWidget(BuildContext context, int index) {
      return InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(_noteList[index].name),
        ),
      );
    }

    // 笔记列表
    _noteListWidget(BuildContext context) {
      return ListView.builder(
        itemCount: _noteList.length,
        itemBuilder: (BuildContext context, int index) {
          return _noteWidget(context, index);
        },
      );
    }

    // 添加笔记弹窗
    _addNoteWidget(BuildContext context) {
      TextEditingController _controller = TextEditingController();
      return AlertDialog(
        title: Text('添加分组笔记'),
        content: Container(
          child: TextField(
            controller: _controller,
            maxLength: 20,
            autofocus: true,
            decoration: InputDecoration(hintText: '请输入笔记名称'),
          ),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('取消'),
          ),
          RaisedButton(
            onPressed: () async {
              String _name = _controller.text;
              if (_name.length == 0) {
                Fluttertoast.showToast(
                    msg: '笔记名称不可为空', backgroundColor: Colors.grey);
              } else {
                // 此处实现添加逻辑
                await Provider.of<NoteProvider>(context, listen: false)
                    .addNote(context, 'note', _name);
                // // 添加后重新加载列表
                await Provider.of<NoteProvider>(context, listen: false)
                    .listNoteByGroupId(context, 'note');
                Navigator.pop(context);
              }
            },
            child: Text('提交'),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_group.name}'),
        actions: [
          IconButton(
            onPressed: () {
              // 弹出添加笔记窗口
              showDialog(
                // 点击弹窗外的区域不会关闭弹窗
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return _addNoteWidget(context);
                },
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: TextField(
                style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                decoration: InputDecoration(hintText: '请输入笔记名称进行搜索'),
                onSubmitted: (value) async {
                  // 查询
                  await Provider.of<NoteProvider>(context, listen: false)
                      .listNoteByGroupId(context, 'note', name: value);
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            // 分组列表
            Container(
              height: ScreenUtil().setHeight(1000),
              child: _noteList.length == 0
                  ? Text('暂无数据')
                  : _noteListWidget(context),
            )
          ],
        ),
      ),
    );
  }
}
