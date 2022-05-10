import 'dart:convert';

import 'package:delivery_driver_application/src/core/authentication/authentication.dart';
import 'package:delivery_driver_application/src/core/base/base_api.dart';
import 'package:delivery_driver_application/src/core/config/server_address.dart';
import 'package:delivery_driver_application/src/feature/model/account.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider {
  static BaseApi<Account> api = BaseApi<Account>();

  Future login(String username, String password) async {
    String url = urlServer + "Users/login";
    final body = {
      "userName": username,
      "password": password,
    };
    int statusCode = 0;
    var response = await api.postAPICall(url, body);
    // print(response['status']['status code']);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        Account? account = Account.fromJson(response["data"]);
        if (account.role.contains('driver')) {
          await storage.write(key: 'token', value: account.token);
          await storage.write(key: 'tokenType', value: account.tokenType);
          await storage.write(key: 'expires', value: account.expires);
          await storage.write(key: 'userId', value: account.id);
          await storage.write(key: 'username', value: account.username);
          await storage.write(key: 'name', value: account.name);
          // await storage.write(key: 'email', value: account.email);
          await storage.write(key: 'avatar', value: account.avatar);
          await storage.write(key: 'role', value: account.role);
          await storage.write(key: 'address', value: account.address);
          await storage.write(key: 'phoneNumber', value: account.phoneNumber);
          await storage.write(key: 'gender', value: account.gender);
          await storage.write(key: 'dateOfBirth', value: account.dateOfBirth);
          await storage.write(key: 'type', value: account.type.toString());
          tokenSave = account.token;
          typeSave = account.type.toString();
          if(account.name != '' && account.dateOfBirth != '' && account.gender != '' && account.address != ''){

            tokenSave = account.token;
            SharedPreferences preferences =
            await SharedPreferences.getInstance();
            preferences.setString('token', account.token);
            preferences.setString('tokenType', account.tokenType);
            preferences.setString('expires', account.expires);
            preferences.setString('userId', account.id.toString());
            preferences.setString('username', account.username);
            preferences.setString('name', account.name);
            // preferences.setString('email', account.email);
            preferences.setString('avatar', account.avatar);
            preferences.setString('role', account.role);
            preferences.setString('address', account.address);
            preferences.setString('phoneNumber', account.phoneNumber);
            preferences.setString('gender', account.gender);
            preferences.setString('dateOfBirth', account.dateOfBirth);
            preferences.setString('type', account.type.toString());
          }
        } else {
          print('fail to login by role');
        }
        // print(await storage.readAll());
      }
      // else {
      //   print(response);
      //   if(statusCode == 404){
      //     UIData.toastMessage(response['message error']);
      //   }
      //   // If that call was not successful, throw an error.
      //   // throw Exception('Failed to login');
      //   // UIData.toastMessage('Đăng nhập thành công');
      //
      // }
    } else {
      // response['status']['status code'] = 0;
    }
    // print(response['status']['status code']);
    return response;
  }

  Future<dynamic> updateAvatar(String farmerId, String avatar) async {
    int statusCode = 0;
    String url = urlServer + "users/change-image/" + farmerId;
    var request = await api.putAPICallMultiPart(url);
    request.fields['Id'] = farmerId;
    if (avatar.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('Image', avatar));
    }
    String responseString = '';
    var result = {"statusCode": 0, "pathImage": ''};
    var response = await request.send();
    if (response.statusCode != 0) {
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        responseString = await response.stream.bytesToString();
        // print(responseString);
        result = {"statusCode": statusCode, "pathImage": responseString};
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      }
    }
    // print(statusCode);
    return result;
  }

  Future<int> forgotPassword(String username, String newPassword) async {
    String url = urlServer + "users/forgot-password/" + username + "?new-password=" + newPassword;
    int statusCode = 0;
    var response = await api.putAPICall(url, param: {});
    if(response != null){
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Cap nhat thanh cong");
      } else {
        print("Cap nhat that bai");
      }
    }
    return statusCode;
  }

  Future<int> checkDuplicatePhone(String phoneNumber) async {
    String url = urlServer + "users/check-duplicate?username=" + phoneNumber;
    int statusCode = 0;
    var response = await api.putAPICall(url, param: {});
    print(response);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Khong trung");
      } else {
        print("trung");
      }
    }
    // print(statusCode);
    return statusCode;
  }

  Future<dynamic> changePassword(
      String farmerId, String currentPassword, String newPassword) async {
    int statusCode = 0;
    var body = {
      "id": farmerId,
      "currentPassword": currentPassword,
      "password": newPassword
    };
    String url = urlServer + "users/change-password";
    var response = await api.putAPICall(url, param: body);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Cap nhat thanh cong");
      } else {
        print("Cap nhat that bai");
      }
    }
    return response;
  }

  Future<int> updateAccount(String farmerId, String fullName,
      String dateOfBirth, String gender, String address) async {
    String url = urlServer + "users/update-user/" + farmerId;
    int statusCode = 0;
    var body = {
      "id": farmerId,
      "email": null,
      "name": fullName,
      "address": address,
      "gender": gender,
      "dateOfBirth": dateOfBirth
    };
    var response = await api.putAPICall(url, param: body);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
      }
    } else {
      print(response['data']);
    }
    return statusCode;
  }
}
