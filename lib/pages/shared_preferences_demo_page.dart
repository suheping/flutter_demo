import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:provider/provider.dart';

class SDFDemoPage extends StatelessWidget {
  SDFDemoPage({Key key}) : super(key: key);
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shared_preferences持久化'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('您的用户名为：${Provider.of<SDFProvider>(context).name}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: '请输入用户名'),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    String name = _controller.text;
                    // _controller.text;
                    // 保存用户名
                    await Provider.of<SDFProvider>(context, listen: false)
                        .saveName(name);
                  },
                  child: Text('保存'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
