import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/web_view_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String _url = '';
  @override
  void initState() {
    super.initState();
    // _url = Provider.of<WebViewProvider>(context, listen: false).getUrl;
    // _url =
    "http://192.168.2.58:8080/#/login";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebviewScaffold(
        withJavascript: true,
        url: _url,
        javascriptChannels: [
          JavascriptChannel(
              // js中回调方法必须为  GMJSHandler.postMessage("xxxx");
              // postMessage 是固定写法
              name: 'GMJSHandler',
              onMessageReceived: (JavascriptMessage message) {
                // 此处编写具体的处理
                print(message.message);
                Application.router.pop(context);
              }),
        ].toSet(),
      ),
    );
  }
}
