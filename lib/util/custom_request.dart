import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/config/service_url.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future CustomRequest(BuildContext context, String pathName, String method,
    {data, headers}) async {
  print(
      '开始请求后端接口：[$method]${servicePath[pathName]} \n 请求headers: $headers \n 请求参数：$data');
  Dio dio = new Dio();
  Response response;
  // 请求拦截

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options) {
      // 显示加载中dialog
      EasyLoading.show(status: 'loading...');
    },
    onResponse: (Response response) {
      // 隐藏加载中loading
      EasyLoading.dismiss();
    },
    onError: (e) {
      Map<dynamic, dynamic> _map = Map.from(e.response.data);
      EasyLoading.dismiss();
      EasyLoading.showError('${_map['errors']}');
    },
  ));

  if (headers != null) {
    dio.options.headers = headers;
  }

  switch (method) {
    case 'get':
      if (data != null) {
        response = await dio.get(servicePath[pathName], queryParameters: data);
      } else {
        response = await dio.get(servicePath[pathName]);
      }
      break;
    case 'post':
      dio.options.contentType = Headers.jsonContentType;
      response = await dio.post(servicePath[pathName], data: data);
      break;
    case 'put':
      dio.options.contentType = Headers.jsonContentType;
      response = await dio.put(servicePath[pathName], data: data);
      break;
    case 'delete':
      response = await dio.delete(servicePath[pathName], queryParameters: data);
      break;
    default:
      print('method不正确，请检查！');
  }

  print('接口$pathName返回：$response');

  if (response != null) {
    return response.data;
  } else {
    throw Exception('后端接口无响应');
  }
}
