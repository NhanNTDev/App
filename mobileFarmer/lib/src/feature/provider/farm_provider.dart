import 'dart:convert';
import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/feedback.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:http/http.dart' as http;

class FarmProvider {
  static BaseApi<Farm> api = BaseApi<Farm>();

  Future<Pagination<Farm>> getListFarmByFarmer(
      int page, int size, String farmerId) async {
    String url = urlServer +
        "farms?farmer-id=" +
        farmerId +
        "&page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<Farm> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
        list = Pagination<Farm>.fromJson(response, Farm.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    // console.log(list.items.length);
    for(int i = 0; i < list.items.length; i++){
      print(list.items[i].name);
    }
    return list;
  }

  Future<Farm> getFarmById(int farmId) async {
    String url = urlServer +
        "farms/" + farmId.toString();
    int statusCode = 0;
    Farm farm = Farm(
        name: '',
        avatar: '',
        image1: '',
        image2: '',
        image3: '',
        image4: '',
        image5: '',
        description: '',
        address: '',
        active: false, totalStar: 0, feedbacks: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        farm = Farm.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return farm;
  }

  Future<int> addNewFarm(
      String avatar,
      List<String> images,
      String farmName,
      String farmDescription,
      String farmAddress,
      String farmerId,
      int farmZoneId) async {
    int statusCode = 0;
    String url = urlServer + "farms";
    var request = await api.postAPICallMultiPart(url);
    request.fields['Name'] = farmName;
    request.files
        .add(await http.MultipartFile.fromPath('Avatar', avatar));
    for (String path in images) {
      request.files
          .add(await http.MultipartFile.fromPath('Images', path.toString()));
    }
    request.fields['Description'] = farmDescription;
    request.fields['Address'] = farmAddress;
    request.fields['FarmerId'] = farmerId;
    request.fields['FarmZoneId'] = 1.toString();
    var response = await request.send();
    if(response.statusCode != 0){
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      }
    }
    print(statusCode);
    return statusCode;
  }

  Future<int> updateFarm(
      int farmId,
      String avatar,
      List<String> images,
      String farmName,
      String farmDescription,
      String farmAddress,) async {
    int statusCode = 0;
    String url = urlServer + "farms/" + farmId.toString();
    var request = await api.putAPICallMultiPart(url);
    request.fields['Id'] = farmId.toString();
    request.fields['Name'] = farmName;
    if(avatar.isNotEmpty){
      request.files
          .add(await http.MultipartFile.fromPath('Avatar', avatar));
    }
    if(images.isNotEmpty){
      for (String path in images) {
        request.files
            .add(await http.MultipartFile.fromPath('Images', path.toString()));
      }
    }
    request.fields['Description'] = farmDescription;
    request.fields['Address'] = farmAddress;
    var response = await request.send();
    if(response.statusCode != 0){
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      }
    }
    return statusCode;
  }

  Future<int> deleteFarm(int farmId) async {
    String url = urlServer +
        "farms/" + farmId.toString();
    int statusCode = 0;
    var response = await api.deleteAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // statusCode = 200;
      }else if(statusCode == 400){
        print(response['message error']);
      }
    }
    return statusCode;
  }

  Future<List<FarmModel>> getFarmCanJoinCampaign(String farmerId, int campaignId) async {
    int statusCode = 0;
    String url = urlServer + "campaigns/farm-join/" + farmerId + "/" + campaignId.toString();
    List<FarmModel> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for(var farm in response['data']){
          list.add(FarmModel.fromJson(farm));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return list;
  }

  Future<List<SearchFarm>> getFarmByName(String search, String farmerId) async {
    int statusCode = 0;
    String url = urlServer + "farms/search-name?farmer-id=" + farmerId +  "&name=" + search;
    List<SearchFarm> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for(var farm in response['data']){
          list.add(SearchFarm.fromJson(farm));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return list;
  }

  Future<int> getCountFarmByFarmer(String farmerId) async{
    String url =  urlServer + "farms/count-farm/" + farmerId;
    int count = 0;
    var response = await api.getAPICall(url);
    if(response != null){
      if (response['status']['status code'] == 200) {
        count = response['data'];
        }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return count;
  }

  Future<Pagination<FeedbackInFarm>> getListFeedBackByFarm(
      int page, int size, int farmId) async {
    String url = urlServer +
        "farm-orders/feedback/" +
        farmId.toString() +
        "?page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<FeedbackInFarm> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<FeedbackInFarm>.fromJson(response, FeedbackInFarm.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load feedback');
      }
    }
    return list;
  }
}
