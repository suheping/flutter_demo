import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/service_url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioPage extends StatefulWidget {
  @override
  _DioPageState createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  String _token = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('dio demo'),
        ),
        body: Column(
          children: [
            RaisedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  "app_id": "731266365780545111",
                  "app_secret": "UqhqrggjBErJKUe111",
                  "grant_type": "client_credentials"
                };
                Map<String, dynamic> header = {
                  "Content-Type": "application/json"
                };
                try {
                  await Dio()
                      .post(servicePath['getToken'],
                          data: data, options: Options(headers: header))
                      .then((value) {
                    print(value);
                    if (value.statusCode == 200) {
                      if (value.data['result_code'] == '0') {
                        setState(() {
                          _token = value.data['data']['access_token'];
                          Fluttertoast.showToast(
                              msg: 'token: $_token',
                              backgroundColor: Colors.grey);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: '${value.data}', backgroundColor: Colors.grey);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: '${value.data}', backgroundColor: Colors.grey);
                    }
                  });
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: '$e', backgroundColor: Colors.grey);
                }
              },
              child: Text('获取token'),
            ),
            RaisedButton(
              onPressed: () async {
                Map<String, dynamic> data = {"user_id": "00731266865947103111"};
                Map<String, dynamic> header = {
                  "Content-Type": "application/json",
                  "sign": "2AF3D3B02D509C091177775DFF787111",
                  "Authentication": _token
                };
                try {
                  await Dio()
                      .post(servicePath['queryPUserInfo'],
                          data: data, options: Options(headers: header))
                      .then((value) {
                    if (value.statusCode == 200) {
                      // print(value.data);
                      Fluttertoast.showToast(
                          msg: '${value.data}', backgroundColor: Colors.grey);
                    } else {
                      // print(value.data);
                      Fluttertoast.showToast(
                          msg: '${value.data}', backgroundColor: Colors.grey);
                    }
                  });
                } catch (e) {
                  // print(e);
                  Fluttertoast.showToast(
                      msg: '$e', backgroundColor: Colors.grey);
                }
              },
              child: Text('获取用户信息'),
            ),
          ],
        ));
  }
}
