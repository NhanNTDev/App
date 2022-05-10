import 'dart:convert';

import 'package:http/http.dart' as http;

import 'handle_error.dart';

class Errors {
  dynamic response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = {
          "status": {"status code": response.statusCode},
          "data": json.decode(response.body)
        };
        return responseJson;
      case 400:
        var responseJson = {
          "status": {"status code": response.statusCode},
          "message error": json.decode(response.body)['error']['message'].toString()
        };
        return responseJson;
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        var responseJson = {
          "status": {"status code": response.statusCode},
          "message error": json.decode(response.body)['error']['message'].toString()
        };
        return responseJson;
      case 500:
      default:
        throw FetchDataException('Error occurs');
    }
  }
}
