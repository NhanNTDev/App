import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/handler/error/handle_error.dart';
import 'package:farmer_application/src/core/handler/error/list_errors.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String tokenSave = '';

class BaseApi<T> {
  static Errors err = Errors();

  //GET
  Future<dynamic> getAPICall(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + tokenSave
      });
      // print(response.body);
      responseJson = err.response(response);
    } on SocketException {
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
      // throw FetchDataException('No internet connection');
    } on TimeoutException {
      UIData.toastMessage("Không có phản hồi");
    }
    return responseJson;
  }

  //POST
  Future<dynamic> postAPICall(String url, dynamic param) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            'Content-type': 'application/json',
            // "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer ' + tokenSave
          },
          body: jsonEncode(param));
      // responseJson = _response(response);
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": json.decode(response.body)
      };
      print(response.statusCode);
      responseJson = err.response(response);
    } on SocketException {
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
      // throw FetchDataException('No Internet connection');
    }
    // on Exception{
    //   print(responseJson);
    // }
    return responseJson;
  }

  Future<dynamic> postAPICall1(String url, String param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            'Content-type': 'application/json',
            // "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer ' + tokenSave
          },
          body: param);
      // responseJson = _response(response);
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": json.decode(response.body)
      };
      print(response.statusCode);
      responseJson = err.response(response);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return responseJson;
  }

  Future<MultipartRequest> postAPICallMultiPart(String url) async {
    print("Calling API: $url");
    var request;
    Map<String, String> headers = {'Authorization': 'Bearer ' + tokenSave};
    try {
      request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return request;
  }

  Future<MultipartRequest> putAPICallMultiPart(String url) async {
    print("Calling API: $url");
    var request;
    Map<String, String> headers = {'Authorization': 'Bearer ' + tokenSave};
    try {
      request = http.MultipartRequest("PUT", Uri.parse(url));
      request.headers.addAll(headers);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return request;
  }

  Future<dynamic> putAPICall(String url, {required Map param}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + tokenSave
          },
          body: jsonEncode(param));
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": json.decode(response.body)
      };
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return responseJson;
  }

  Future<dynamic> putAPICall1(String url, {required Map param}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + tokenSave
          },
          body: jsonEncode(param));
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": response.body
      };
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return responseJson;
  }

  Future<dynamic> deleteAPICall(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + tokenSave
      });
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": response.body
      };
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
    }
    return responseJson;
  }
}
