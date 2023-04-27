import 'package:cap221_app/utils/global_vars.dart';
import 'package:cap221_app/utils/handle_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ArticleRepository {
  Future getArticle(urls) async {
    try {
      var url = '$gateway/$urls';
      if (kDebugMode) {
        print('post: endpoint: $url,');
      }
      var response = await Dio().get(url,
          options: Options(
            headers: {"Content-Type": "application/json"},
          ));
      if (kDebugMode) {
        print("response: ${response.data}");
      }
      return response.data;
    } on DioError catch (e) {
      return throw DioExceptions().fromDioError(e);
    }
  }
}
