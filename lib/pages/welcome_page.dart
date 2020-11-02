import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            await Provider.of<SDFProvider>(context, listen: false)
                .getFingerLoginEnable();
            await Provider.of<SDFProvider>(context, listen: false)
                .getGestureLoginEnable();
            await Provider.of<SDFProvider>(context, listen: false)
                .getGesturecode();
            bool _fingerLoginEnable =
                Provider.of<SDFProvider>(context, listen: false)
                    .fingerLoginEnable;
            bool _gescodeLoginEnable =
                Provider.of<SDFProvider>(context, listen: false)
                    .gestureLoginEnable;
            if (_fingerLoginEnable || _gescodeLoginEnable) {
              Application.router.navigateTo(context, '/login');
            } else {
              Application.router.navigateTo(context, '/home');
            }
          },
          child: Text('登录'),
        ),
      ),
    );
  }
}
