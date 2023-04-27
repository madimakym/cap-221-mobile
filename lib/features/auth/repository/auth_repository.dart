import 'package:cap221_app/utils/global_vars.dart';
import 'package:cap221_app/utils/handle_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  Future getMetier(data) async {
    try {
      var url = '$wpay/api/v1/metier/groupe/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future checkUser(data) async {
    try {
      var url = '$wpay/api/v1/auth/check-user/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future initToken(data) async {
    try {
      var url = 'https://agent-api.wizall.com/token/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future initPaiement(data, token) async {
    try {
      var url = 'https://agent-api.wizall.com/api/merchant/cashout/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ));
      if (kDebugMode) {
        print("response: ${response.data}");
      }
      return response.data;
    } on DioError catch (e) {
      return throw DioExceptions().fromDioError(e);
    }
  }

  Future confirmtPaiement(data, token) async {
    try {
      var url = 'https://agent-api.wizall.com/api/merchant/cashout/confirm/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ));
      if (kDebugMode) {
        print("response: ${response.data}");
      }
      return response.data;
    } on DioError catch (e) {
      return throw DioExceptions().fromDioError(e);
    }
  }

  Future inscription(data) async {
    try {
      var url = '$wpay/api/v1/auth/register/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future login(data) async {
    try {
      var url = '$wpay/api/v1/auth/login';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future fetchToken(data) async {
    try {
      var url = '$wpay/api/v1/auth/';
      if (kDebugMode) {
        print('post: endpoint: $url, data: $data');
        print('Token: $wpayToken');
      }
      var response = await Dio().post(url,
          data: data,
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

  Future getCatHasArticle() async {
    try {
      var url = '$gateway/wp-json/wp/v2/categories?hide_empty=true&exclude=1';
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
