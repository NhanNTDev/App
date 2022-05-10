import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';

class CampaignProvider {
  static BaseApi<Campaign> api = BaseApi<Campaign>();

  Future<Pagination<Campaign>> getListJoinCampaigns(int page, int size, String farmerId) async {
    String url = urlServer + "campaigns/campaign-farmer-apply/"+ farmerId
        +"?page=" + page.toString() + "&size=" + size.toString();
    int statusCode = 0;
    Pagination<Campaign> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<Campaign>.fromJson(response, Campaign.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return list;
  }

  Future<Pagination<CampaignCanJoin>> getListJoinCampaigns1(int page, int size, String farmerId, String type) async {
    String url = urlServer + "campaigns/campaign-farmer-apply/"+ farmerId + "?type=" + type + "&page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<CampaignCanJoin> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // print(response['data']);
        list = Pagination<CampaignCanJoin>.fromJson(response, CampaignCanJoin.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return list;
  }

  Future<Pagination<JoinedCampaign>> getListJoinedCampaign(int page, int size, String farmerId) async {
    String url = urlServer + "campaigns/campaign-farmer-applied/"+ farmerId +"?page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<JoinedCampaign> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // print(response['data']);
        list = Pagination<JoinedCampaign>.fromJson(response, JoinedCampaign.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return list;
  }

  Future<Campaign> getCampaignById(int campaignId) async {
    String url = urlServer + "campaigns/detail-apply/" +
        campaignId.toString();
    int statusCode = 0;
    Campaign campaign = Campaign(name: '', image1: '', image2: '', image3: '', image4: '', image5: '',
        type: '', description: '', startAt: '', endAt: '', status: '', farmInCampaign: 0,
        campaignDeliveryZones: [], startRecruitmentAt: '', endRecruitmentAt: '', productSalesCampaigns: [], campaignZoneId: 0, campaignZoneName: '');
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        campaign = Campaign.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return campaign;
  }

  Future<CampaignJoinedDetail> getCampaignJoinedById(int campaignId, String farmerId) async {
    String url = urlServer + "campaigns/detail-applied/" + farmerId + "/" +
        campaignId.toString();
    int statusCode = 0;
    CampaignJoinedDetail campaign = CampaignJoinedDetail(name: '', image1: '', image2: '', image3: '', image4: '', image5: '',
        type: '', description: '', startAt: '', endAt: '', status: '', farmInCampaign: 0,
        farms: [], campaignDeliveryZones: [], endRecruitmentAt: '', productSalesCampaigns: [], campaignZoneName: '', campaignZoneId: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        campaign = CampaignJoinedDetail.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return campaign;
  }

  Future<int> getCountCampaignCanApplyByFarmer(String farmerId, String type) async{
    String url =  urlServer + "campaigns/count-campaign-apply/" + farmerId +"?type=" + type;
    int count = 0;
    var response = await api.getAPICall(url);
    if(response != null){
      if (response['status']['status code'] == 200) {
        count = response['data'];
      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load data');
      }
    }
    return count;
  }

  Future<int> getCountJoinedCampaignByFarmer(String farmerId) async{
    String url =  urlServer + "campaigns/count-campaign-applied/" + farmerId;
    int count = 0;
    var response = await api.getAPICall(url);
    if(response != null){
      if (response['status']['status code'] == 200) {
        count = response['data'];
      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load data');
      }
    }
    return count;
  }

  Future<List<SearchJoinCampaign>> getJoinCampaignByName(String search, String farmerId) async {
    int statusCode = 0;
    String url = urlServer + "campaigns/search-apply?farmer-id=" + farmerId +  "&name=" + search;
    List<SearchJoinCampaign> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for(var farm in response['data']){
          list.add(SearchJoinCampaign.fromJson(farm));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return list;
  }

  Future<List<SearchJoinCampaign>> getAppliedCampaignByName(String search, String farmerId) async {
    int statusCode = 0;
    String url = urlServer + "campaigns/search-applied?farmer-id=" + farmerId +  "&name=" + search;
    List<SearchJoinCampaign> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        // list = Pagination<FarmModel>.fromJson(response, FarmModel.fromJsonModel);
        for(var farm in response['data']){
          list.add(SearchJoinCampaign.fromJson(farm));
        }
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load campaign');
      }
    }
    return list;
  }
}
