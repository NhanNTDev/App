import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/provider/campaign_provider.dart';

class CampaignRepository {
  final _campaignProvider = CampaignProvider();

  Future<Pagination<Campaign>> fetchAllJoinCampaigns(
          int page, int size, String farmerId) =>
      _campaignProvider.getListJoinCampaigns(page, size, farmerId);

  Future<Pagination<CampaignCanJoin>> fetchAllJoinCampaigns1(
          int page, int size, String farmerId, String type) =>
      _campaignProvider.getListJoinCampaigns1(page, size, farmerId, type);

  Future<Pagination<JoinedCampaign>> getListJoinedCampaign(
          int page, int size, String farmerId) =>
      _campaignProvider.getListJoinedCampaign(page, size, farmerId);

  Future<Campaign> getCampaignById(int campaignId) =>
      _campaignProvider.getCampaignById(campaignId);

  Future<CampaignJoinedDetail> getCampaignJoinedById(
          int campaignId, String farmerId) =>
      _campaignProvider.getCampaignJoinedById(campaignId, farmerId);

  Future<int> getCountJoinedCampaignByFarmer(String farmerId) =>
      _campaignProvider.getCountJoinedCampaignByFarmer(farmerId);

  Future<int> getCountCampaignCanApplyByFarmer(String farmerId, String type) =>
      _campaignProvider.getCountCampaignCanApplyByFarmer(farmerId, type);

  Future<List<SearchJoinCampaign>> getJoinCampaignByName(
          String search, String farmerId) =>
      _campaignProvider.getJoinCampaignByName(search, farmerId);

  Future<List<SearchJoinCampaign>> getAppliedCampaignByName(
          String search, String farmerId) =>
      _campaignProvider.getAppliedCampaignByName(search, farmerId);
}
