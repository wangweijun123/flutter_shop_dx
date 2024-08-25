import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/index.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = Dio();
    // 多余的跑异常
    // dio.options.contentType =
    //     ContentType.parse('application/x-www-form-urlencoded') as String?;
    if (formData == null) {
      response = await dio.post(servicePath[url]!);
    } else {
      response = await dio.post(servicePath[url]!, data: formData);
    }
    if (response.statusCode == 200) {
      print('request url success... ${servicePath[url]} ');
      return response;
    } else {
      print('request url falied... ${servicePath[url]} ');
      throw Exception('后端接口异常,请检查测试代码和服务器运行情况...');
    }
  } catch (e) {
    print('request url falied... ${servicePath[url]}error:::${e}');
    return print('error:::${e}');
  }
}
