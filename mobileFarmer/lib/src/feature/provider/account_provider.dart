import 'dart:convert';

import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/account.dart';
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
    await storage.deleteAll();

    var response = await api.postAPICall(url, body);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        Account? account = Account.fromJson(response["data"]);
        if (account.role.contains('farmer')) {
          await storage.write(key: 'token', value: account.token);
          await storage.write(key: 'tokenType', value: account.tokenType);
          await storage.write(key: 'expires', value: account.expires);
          await storage.write(key: 'userId', value: account.id);
          await storage.write(key: 'username', value: account.username);
          await storage.write(key: 'name', value: account.name);
          await storage.write(key: 'email', value: account.email);
          await storage.write(key: 'avatar', value: account.avatar);
          await storage.write(key: 'role', value: account.role);
          await storage.write(key: 'address', value: account.address);
          await storage.write(key: 'phoneNumber', value: account.phoneNumber);
          await storage.write(key: 'gender', value: account.gender);
          await storage.write(key: 'dateOfBirth', value: account.dateOfBirth);

          if (account.name != '' &&
              account.dateOfBirth != '' &&
              account.gender != '' &&
              account.address != '') {
            tokenSave = account.token;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('token', account.token);
            preferences.setString('tokenType', account.tokenType);
            preferences.setString('expires', account.expires);
            preferences.setString('userId', account.id.toString());
            preferences.setString('username', account.username);
            preferences.setString('name', account.name);
            preferences.setString('email', account.email);
            preferences.setString('avatar', account.avatar);
            preferences.setString('role', account.role);
            preferences.setString('address', account.address);
            preferences.setString('phoneNumber', account.phoneNumber);
            preferences.setString('gender', account.gender);
            preferences.setString('dateOfBirth', account.dateOfBirth);
          }
        } else {
          print('fail to login by role');
        }
      }
    } else {
      // response['status']['status code'] = 0;
    }
    // print(response['status']['status code']);
    return response;
  }

  Future<void> logout() async {}

  Future<int> checkDuplicatePhone(String phoneNumber) async {
    String url = urlServer + "users/check-duplicate?username=" + phoneNumber;
    int statusCode = 0;
    var response = await api.putAPICall(url, param: {});
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Khong trung");
      } else {
        print("trung");
      }
    }
    return statusCode;
  }

  Future<dynamic> registerFarmer(String phoneNumber, String password) async {
    String url = urlServer + "users";
    int statusCode = 0;
    var body = {
      "phoneNumber": phoneNumber,
      "password": password,
      "role": [
        {"name": "farmer"}
      ]
    };
    var response = await api.postAPICall(url, body);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("tao thanh cong");
      } else {
        print(response['data']);
      }
    }
    return response;
  }

  Future<int> updateAccount(String farmerId, String fullName,
      String dateOfBirth, String gmail, String gender, String address) async {
    String url = urlServer + "users/update-user/" + farmerId;
    int statusCode = 0;
    var body = {
      "id": farmerId,
      "email": gmail,
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
        result = {"statusCode": statusCode, "pathImage": responseString};
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      }
    }
    return result;
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

  Future<int> forgotPassword(String username, String newPassword) async {
    String url = urlServer +
        "users/forgot-password/" +
        username +
        "?new-password=" +
        newPassword;
    int statusCode = 0;
    var response = await api.putAPICall(url, param: {});
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Cap nhat thanh cong");
      } else {
        print("Cap nhat that bai");
      }
    }
    return statusCode;
  }

  Future<DashBoard> getDashBoard(String farmerId) async {
    String url = urlServer + "users/count/dashboard?farmer-id=" + farmerId;
    int statusCode = 0;
    DashBoard dashBoard =
        DashBoard(farms: 0, harvests: 0, orderConfirms: 0, customerOrder: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Cap nhat thanh cong");
        dashBoard = DashBoard.fromJson(response['data']);
      } else {
        print("Cap nhat that bai");
      }
    }
    return dashBoard;
  }

  Future<Revenue> getRevenue(String farmerId) async {
    String url = urlServer + "users/statistical/" + farmerId;
    int statusCode = 0;
    Revenue revenue = Revenue(totalRevenues: 0, customers: 0, farmOrders: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Cap nhat thanh cong");
        revenue = Revenue.fromJson(response['data']);
      } else {
        print("Cap nhat that bai");
      }
    }
    return revenue;
  }
}
