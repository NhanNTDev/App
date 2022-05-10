import 'dart:convert';
import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/screen/campaign_apply_request/campaign_apply_request_screen.dart';
import 'package:http/http.dart' as http;

class HarvestProvider {
  static BaseApi<Harvest> api = BaseApi<Harvest>();

  Future<Pagination<Harvest>> getListHarvestsByFarmer(
      int page, int size, String farmerId) async {
    String url = urlServer +
        "product-harvests?farmer-id=" +
        farmerId +
        "&page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<Harvest> list =
        Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<Harvest>.fromJson(response, Harvest.fromJsonModel);
        print(list.items.length);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }

  Future<Pagination<Harvest>> getListHarvestsByFarm(
      int page, int size, int farmId) async {
    String url = urlServer +
        "product-harvests?farm-id=" +
        farmId.toString() +
        "&page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<Harvest> list =
        Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<Harvest>.fromJson(response, Harvest.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }

  Future<Harvest> getHarvestById(int harvestId) async {
    String url = urlServer + "product-harvests/" + harvestId.toString();
    int statusCode = 0;
    Harvest harvest = Harvest(
      image1: '',
      image2: '',
      image3: '',
      image4: '',
      image5: '',
      name: '',
      farmName: '',
      productName: '',
      startAt: '',
      estimatedTime: '',
      estimatedProduction: 0,
      unit: '',
      categoryName: '',
      inventoryTotal: 0,
      description: '',
      minPrice: 0,
      maxPrice: 0,
      productSystemName: '',
      productNameChange: '',
      actualProduction: 0,
    );
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        harvest = Harvest.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return harvest;
  }

  Future<int> createNewHarvest(
      String harvestName,
      String productNameChange,
      List<String> images,
      String harvestDescription,
      DateTime dateHarvestStart,
      DateTime dateEstimateHarvest,
      int inventory,
      int actualProduction,
      int farmId,
      int productSystemId) async {
    int statusCode = 0;
    String url = urlServer + "product-harvests";
    var request = await api.postAPICallMultiPart(url);
    // request.fields['InventoryTotal'] = inventory.toString();
    request.fields['EstimatedTime'] = dateEstimateHarvest.toString();
    request.fields['Name'] = harvestName;
    request.fields['FarmId'] = farmId.toString();
    request.fields['StartAt'] = dateHarvestStart.toString();
    request.fields['EstimatedProduction'] = inventory.toString();
    if (actualProduction != 0) {
      request.fields['ActualProduction'] = actualProduction.toString();
    }
    for (String path in images) {
      request.files
          .add(await http.MultipartFile.fromPath('Images', path.toString()));
    }
    request.fields['ProductSystemId'] = productSystemId.toString();
    request.fields['ProductName'] = productNameChange;
    request.fields['Description'] = harvestDescription;
    var response = await request.send();
    if (response.statusCode != 0) {
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        print(responseString);
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      }
    }

    print(statusCode);
    return statusCode;
  }

  Future<int> updateHarvest(
    int harvestId,
    List<String> images,
    String harvestName,
    String harvestDescription,
    String productNameChange,
    int actualProduction,
    DateTime dateEstimatedHarvest,
  ) async {
    int statusCode = 0;
    String url = urlServer + "product-harvests/" + harvestId.toString();
    var request = await api.putAPICallMultiPart(url);
    request.fields['Id'] = harvestId.toString();
    request.fields['Name'] = harvestName;
    request.fields['ProductName'] = productNameChange;
    if (images.isNotEmpty) {
      for (String path in images) {
        request.files
            .add(await http.MultipartFile.fromPath('Images', path.toString()));
      }
    }
    request.fields['Description'] = harvestDescription;
    request.fields['EstimatedTime'] = dateEstimatedHarvest.toString();
    // if(actualProduction != 0){
    request.fields['ActualProduction'] = actualProduction.toString();
    // }
    var response = await request.send();
    if (response.statusCode != 0) {
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        print(responseString);
      } else if (response.statusCode == 400) {
        var result = await http.Response.fromStream(response);
        final map = jsonDecode(result.body) as Map<String, dynamic>;
        print(map['error']['message']);
      } else {
        var result = await http.Response.fromStream(response);
        // final map = jsonDecode(result.body) as Map<String, dynamic>;
        // print(map['error']['message']);
        print(result.body);
      }
    }
    return statusCode;
  }

  Future<int> deleteHarvest(int harvestId) async {
    String url = urlServer + "product-harvests/" + harvestId.toString();
    int statusCode = 0;
    var response = await api.deleteAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
      } else {
        statusCode = 400;
      }
    }
    return statusCode;
  }

  Future<List<HarvestModel>> getHarvestInFarm(int farmId) async {
    int statusCode = 0;
    String url =
        urlServer + "campaigns/harvest-apply/" +
            farmId.toString();
    List<HarvestModel> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for (var harvest in response['data']) {
          list.add(HarvestModel.fromJson(harvest));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return list;
  }

  Future<int> getCountHarvestByFarmer(String farmerId) async {
    String url = urlServer + "product-harvests/count/" + farmerId;
    int count = 0;
    var response = await api.getAPICall(url);
    if (response != null) {
      if (response['status']['status code'] == 200) {
        count = response['data'];
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load data');
      }
    }
    return count;
  }

  Future<List<SearchHarvest>> getHarvestByName(
      String search, String farmerId) async {
    int statusCode = 0;
    String url = urlServer +
        "product-harvests/search?farmer-id=" +
        farmerId +
        "&name=" +
        search;
    List<SearchHarvest> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for (var farm in response['data']) {
          list.add(SearchHarvest.fromJson(farm));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }

  Future<List<HarvestInCampaignModel>> getHarvestSuggest(
      String farmerId, int campaignId) async {
    int statusCode = 0;
    String url =
        urlServer + "campaigns/" + farmerId + "/" + campaignId.toString();
    List<HarvestInCampaignModel> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for (var harvest in response['data']) {
          list.add(HarvestInCampaignModel.fromJson(harvest));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }

  Future<List<HarvestSuggest>> getHarvestSuggestByFarm(
      int farmId, int campaignId) async {
    int statusCode = 0;
    String url = urlServer +
        "campaigns/harvest-apply/" +
        farmId.toString() +
        "/" +
        campaignId.toString();
    List<HarvestSuggest> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for (var harvest in response['data']) {
          list.add(HarvestSuggest.fromJson(harvest));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }
}
