import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/provider_demo_page.dart';
import 'package:flutter_demo/pages/signature_demo_page.dart';
import 'package:flutter_demo/pages/shared_preferences_demo_page.dart';
import 'package:flutter_demo/pages/easy_refresh_demo.dart';
import 'package:fluro/fluro.dart';

Handler homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return HomePage();
  },
);

Handler providerDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return ProverDemoPage();
  },
);

Handler signDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return SignDemoPage();
  },
);

Handler sdfDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return SDFDemoPage();
  },
);
Handler easyRefreshDemoHander = Handler(
  handlerFunc: (context, parameters) {
    return EasyRefreshDemo();
  },
);
