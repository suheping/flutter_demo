import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/refresh_provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

class EasyRefreshDemo extends StatelessWidget {
  const EasyRefreshDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _listData = Provider.of<RefreshProvider>(context).listData;
    return Scaffold(
      appBar: AppBar(
        title: Text('easyRefresh演示页面'),
      ),
      body: Container(
        child: EasyRefresh(
          enableControlFinishLoad: false,
          // 判断是否还有更多，如果没有更多把onLoad置为null，解决加载完所有数据footer还显示的问题
          onLoad: Provider.of<RefreshProvider>(context).noMore
              ? null
              : () async {
                  await Provider.of<RefreshProvider>(context, listen: false)
                      .loadMoreData();
                },
          footer: ClassicalFooter(
            enableInfiniteLoad: false, // 上拉一段距离松手后才会加载更多，更有仪式感
            loadText: '上拉加载更多',
            loadReadyText: '松手~开始加载',
            loadingText: '努力加载中',
            loadedText: '加载完成',
            loadFailedText: '加载失败了~',
            infoText: 'design by peace',
          ),
          onRefresh: () async {
            await Provider.of<RefreshProvider>(context, listen: false)
                .refresh();
          },
          header: ClassicalHeader(
              infoText: 'design by peace',
              enableInfiniteRefresh: false,
              refreshText: '下拉刷新',
              refreshReadyText: '撒手~开始刷新',
              refreshingText: '努力加载中',
              refreshedText: '加载完成',
              refreshFailedText: '加载失败了~'),
          child: ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  leading: Text('$index'),
                  title: Text(_listData[index]['title']),
                  subtitle: Text(_listData[index]['subtitle']),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
