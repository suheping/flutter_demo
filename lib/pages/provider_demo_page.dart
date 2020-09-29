import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/counter_provider.dart';
import 'package:provider/provider.dart';

class ProverDemoPage extends StatelessWidget {
  const ProverDemoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('count操作页面'),
      ),
      body: countPage(context),
    );
  }

  Widget countPage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
              // provider状态管理get方法
              '${Provider.of<CounterProvider>(context).count}'),
          RaisedButton(
            onPressed: () {
              // provider状态管理set方法
              Provider.of<CounterProvider>(context, listen: false)
                  .setCount('add');
            },
            child: Text('+1'),
          ),
          RaisedButton(
            onPressed: () {
              Provider.of<CounterProvider>(context, listen: false)
                  .setCount('reduce');
            },
            child: Text('-1'),
          )
        ],
      ),
    );
  }
}
