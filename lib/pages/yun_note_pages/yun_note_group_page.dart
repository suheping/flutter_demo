import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/note_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class YunNoteGroupPage extends StatelessWidget {
  const YunNoteGroupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用这种方式可以监听分组列表的变化，变化后重新加载
    List _groupList = context.watch<NoteProvider>().groupList;
    // 分组info部件
    Widget _groupItemWidget(BuildContext context, int index) {
      return InkWell(
        onTap: () async {
          // print(_groupList[index].id);
          // 设置当前分组id
          Provider.of<NoteProvider>(context, listen: false)
              .setCurrentGroupId(context, _groupList[index].id);
          // 获取当前分组下所有的笔记
          await Provider.of<NoteProvider>(context, listen: false)
              .listNoteByGroupId(context, 'note');
          // 跳转到笔记列表页面
          Application.router.navigateTo(context, '/yunNote');
        },
        child: ListTile(
          title: Text(
            _groupList[index].name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: Icon(Icons.arrow_right),
        ),
      );
    }

    // 分组list部件
    Widget _groupListWidget(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _groupList.length,
        itemBuilder: (BuildContext context, int index) {
          return _groupItemWidget(context, index);
        },
      );
    }

    // 添加分组弹窗
    Widget _addGroupWidget(BuildContext context) {
      TextEditingController _controller = TextEditingController();
      return AlertDialog(
        title: Text('添加分组'),
        content: Container(
          child: TextField(
            controller: _controller,
            maxLength: 20,
            autofocus: true,
            decoration: InputDecoration(hintText: '请输入分组名称'),
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
                    msg: '请输入分组名称', backgroundColor: Colors.grey);
              } else {
                // 此处实现添加逻辑
                await Provider.of<NoteProvider>(context, listen: false)
                    .addGroup(context, 'group', _name);
                // // 添加后重新加载列表
                await Provider.of<NoteProvider>(context, listen: false)
                    .listGroup(context, 'group');
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
        title: Text('云笔记'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                // 点击弹窗外的区域不会关闭弹窗
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return _addGroupWidget(context);
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
          children: <Widget>[
            // 搜索
            Container(
              child: TextField(
                style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                decoration: InputDecoration(hintText: '搜索分组'),
                onSubmitted: (value) async {
                  await Provider.of<NoteProvider>(context, listen: false)
                      .listGroup(context, 'group', name: value);
                },
              ),
            ),
            SizedBox(height: 10),
            // 分组列表
            Container(
              height: ScreenUtil().setHeight(1000),
              child: _groupList.length == 0
                  ? Text('暂无数据')
                  : _groupListWidget(context),
            )
          ],
        ),
      ),
    );
  }
}
