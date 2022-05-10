import 'dart:convert';
import 'dart:io';
import 'package:delivery_driver_application/src/core/handler/error/handle_error.dart';
import 'package:delivery_driver_application/src/core/handler/error/list_errors.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String tokenSave = '';
String typeSave = '';

class BaseApi<T> {
  static Errors err = Errors();
  // String token = '';
  // Future _getToken() async {
  //   final all = await storage.readAll();
  //   all.entries
  //       .map((entry) => {
  //     if (entry.key == 'token')
  //       {
  //         token = entry.value,
  //       }
  //   })
  //       .toList(growable: false);
  // }


  //GET
  Future<dynamic> getAPICall(String url) async {
    // _getToken();
    print(url);
    var responseJson;
    try {
        final response = await http.get(Uri.parse(url), headers: {
          "Accept": "application/json",
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + tokenSave
        });
        print(response.statusCode);
        responseJson = err.response(response);
    } on SocketException {
      // UIData.toastMessage("Vui lòng kiểm tra lại kết nối internet");
      // throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  //POST
  Future<dynamic> postAPICall(String url, dynamic param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            'Content-type': 'application/json',
            // "Content-Type": "multipart/form-data",
            // "Authorization": tokenType.toString() + " " + token.toString(),
          },
          body: jsonEncode(param));
      // responseJson = _response(response);
      // responseJson = {
      //   "status": {"status code": response.statusCode},
      //   "data": json.decode(response.body)
      // };
      // print(response.statusCode);
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
            // "Authorization": tokenType.toString() + " " + token.toString(),
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
      throw FetchDataException('No Internet connection');
    }
    // on Exception{
    //   print(responseJson);
    // }
    return responseJson;
  }

  Future<MultipartRequest> postAPICallMultiPart(String url) async {
    print("Calling API: $url");
    var request;
    try {
      // print(image.identifier);
      //   final filePath = await FlutterAbsolutePath.getAbsolutePath(image.identifier.toString());
      //   print(filePath);
        request = http.MultipartRequest("POST", Uri.parse(url));
        // request.fields['Name'] = 'aaaaaa';
        // request.files.add(await http.MultipartFile.fromPath('Avatar', filePath.toString()));
        // request.send().then((value) => print(value.statusCode));

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return request;
    // on Exception{
    //   print(responseJson);
    // }
  }

  Future<MultipartRequest> putAPICallMultiPart(String url) async {
    print("Calling API: $url");
    var request;
    try {
      // print(image.identifier);
      //   final filePath = await FlutterAbsolutePath.getAbsolutePath(image.identifier.toString());
      //   print(filePath);
      request = http.MultipartRequest("PUT", Uri.parse(url));
      // request.fields['Name'] = 'aaaaaa';
      // request.files.add(await http.MultipartFile.fromPath('Avatar', filePath.toString()));
      // request.send().then((value) => print(value.statusCode));

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return request;
    // on Exception{
    //   print(responseJson);
    // }
  }

  Future<dynamic> putAPICall(String url, {required Map param}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            // "Authorization": tokenType.toString() + " " + token.toString(),
          },
          body: jsonEncode(param));
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": json.decode(response.body)
      };
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
            // "Authorization": tokenType.toString() + " " + token.toString(),
          },
          body: jsonEncode(param));
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": response.body
      };
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> putAPICall2(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            // "Authorization": tokenType.toString() + " " + token.toString(),
          });
      responseJson = {
        "status": {"status code": response.statusCode},
        "data": response.body
      };
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
