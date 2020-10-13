import 'package:flutter/material.dart';

class DragDemoPage extends StatefulWidget {
  DragDemoPage({Key key}) : super(key: key);

  @override
  _DragDemoPageState createState() => _DragDemoPageState();
}

class _DragDemoPageState extends State<DragDemoPage> {
  List<Widget> movableItems = [
    Container(
      height: 3000,
      width: 1000,
      decoration: BoxDecoration(color: Colors.white),
    )
  ];
  // List<Widget> movableItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖拽演示'),
      ),
      body: Stack(
        children: movableItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 添加一个可拖动组件
          setState(() {
            movableItems.add(_DragItem());
          });
        },
        child: Text('+'),
      ),
    );
  }
}

class _DragItem extends StatefulWidget {
  _DragItem({Key key}) : super(key: key);

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<_DragItem> {
  double x = 100;
  double y = 100;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: y,
        left: x,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              x += details.delta.dx;
              y += details.delta.dy;
            });
          },
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
            child: Text('${x.toStringAsFixed(2)}\n${y.toStringAsFixed(2)}'),
          ),
        ));
  }
}
