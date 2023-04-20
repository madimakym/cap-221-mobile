import 'package:flutter/foundation.dart';

class DioExceptions implements Exception {
  dynamic fromDioError(dioError) {
    if (dioError.response != null) {
      if (kDebugMode) {
        print("dioError1 data: ${dioError.response.data}");
        print("dioError1 statusCode: ${dioError.response.statusCode}");
      }

      switch (dioError.response.statusCode) {
        case 400:
        case 401:
        case 403:
          return throw ({
            "code": dioError.response!.statusCode.toString(),
            "error": dioError.response.data['error'] ??
                dioError.response.data['message'] ??
                dioError.response.data['MESSAGE']
          });
        case 404:
          return throw ({
            "code": dioError.response!.statusCode.toString(),
            "error":
                "Problème de connexion, veuillez vérifier votre connexion internet puis réessayer"
          });

        case 500:
          return throw ({
            "code": dioError.response!.statusCode.toString(),
            "error": dioError.response.data['error'] ??
                dioError.response.data['message'] ??
                dioError.response.data['MESSAGE']
          });
        default:
          return throw ({
            "code": dioError.response!.statusCode.toString(),
            "error":
                "Problème de connexion, veuillez vérifier votre connexion internet puis réessayer"
          });
      }
    } else {
      if (kDebugMode) {
        print("dioError requestOptions: ${dioError.requestOptions}");
        print("dioError message: ${dioError.message}");
      }
      return throw ({
        "code": "",
        "error":
            "Problème de connexion, veuillez vérifier votre connexion internet puis réessayer."
      });
    }
  }
}
