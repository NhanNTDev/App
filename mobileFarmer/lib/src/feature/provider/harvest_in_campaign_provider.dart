import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';

class HarvestInCampaignProvider {
  static BaseApi<HarvestInCampaign> api = BaseApi<HarvestInCampaign>();

  Future<int> createListHarvestInCampaign(
      List<CreateHarvestInCampaign> list) async {
    int statusCode = 0;
    String url = urlServer + 'product-harvest-in-campaigns';
    var response = await api.postAPICall(url, list);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("tạo thành công");
      }
    }
    return statusCode;
  }

  Future<Pagination<HarvestInCampaign>> getListHarvestsInCampaign(
      int page, int size, int campaignId, int farmId) async {
    String url = urlServer +
        "product-harvest-in-campaigns/campaign/" +
        campaignId.toString() +
        "/farm/" +
        farmId.toString() +
        "?page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<HarvestInCampaign> list =
        Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<HarvestInCampaign>.fromJson(
            response, HarvestInCampaign.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest');
      }
    }
    return list;
  }

  Future<HarvestInCampaignDetail> getHarvestInCampaignById(
      int harvestInCampaignId) async {
    String url = urlServer +
        "product-harvest-in-campaigns/" +
        harvestInCampaignId.toString();
    int statusCode = 0;
    HarvestInCampaignDetail harvestInCampaign = HarvestInCampaignDetail(
        image1: '',
        image2: '',
        image3: '',
        image4: '',
        image5: '',
        harvestName: '',
        productName: '',
        productSystemName: '',
        productCategoryName: '',
        price: 0,
        unit: '',
        valueChangeOfUnit: 0,
        inventory: 0,
        status: '',
        harvestDescription: '',
        harvestId: 0,
        quantity: 0,
        campaignName: '',
        farmName: '',
        campaignId: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        harvestInCampaign = HarvestInCampaignDetail.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load harvest in campaign');
      }
    }
    return harvestInCampaign;
  }

  Future<int> getCountHarvestInCampaign(int campaignId, int farmId) async {
    String url = urlServer +
        "product-harvest-in-campaigns/count/" +
        campaignId.toString() +
        "/" +
        farmId.toString();
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

  Future<int> updateHarvestInCampaign(
      int harvestInCampaignId,
      String productName,
      String unit,
      num inventory,
      num quantity,
      num price,
      num valueChangeOfUnit,
      int harvestId,
      int campaignId) async {
    String url = urlServer +
        "product-harvest-in-campaigns/" +
        harvestInCampaignId.toString();
    int statusCode = 0;
    var body = {
      "id": harvestInCampaignId,
      "productName": productName,
      "unit": unit,
      "inventory": inventory,
      "quantity": quantity,
      "price": price,
      "valueChangeOfUnit": valueChangeOfUnit,
      "harvestId": harvestId,
      "campaignId": campaignId
    };
    var response = await api.putAPICall(url, param: body);
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

  Future<int> deleteHarvestInCampaign(int harvestInCampaignId) async {
    String url = urlServer +
        "product-harvest-in-campaigns/delete/" +
        harvestInCampaignId.toString();
    int statusCode = 0;
    var response = await api.deleteAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Xoa thanh cong");
      } else {
        print("Xoa that bai");
      }
    }
    return statusCode;
  }
}
