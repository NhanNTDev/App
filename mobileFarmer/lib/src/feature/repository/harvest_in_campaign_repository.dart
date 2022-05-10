import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/provider/harvest_in_campaign_provider.dart';

class HarvestInCampaignRepository {
  final _harvestInCampaignProvider = HarvestInCampaignProvider();

  Future<int> createListHarvestInCampaign(List<CreateHarvestInCampaign> list) =>
      _harvestInCampaignProvider.createListHarvestInCampaign(list);

  Future<Pagination<HarvestInCampaign>> getListHarvestsInCampaign(
          int page, int size, int campaignId, int farmId) =>
      _harvestInCampaignProvider.getListHarvestsInCampaign(
          page, size, campaignId, farmId);

  Future<HarvestInCampaignDetail> getHarvestInCampaignById(
          int harvestInCampaignId) =>
      _harvestInCampaignProvider.getHarvestInCampaignById(harvestInCampaignId);

  Future<int> getCountHarvestInCampaign(int campaignId, int farmId) =>
      _harvestInCampaignProvider.getCountHarvestInCampaign(campaignId, farmId);

  Future<int> updateHarvestInCampaign(
          int harvestInCampaignId,
          String productName,
          String unit,
          num inventory,
          num quantity,
          num price,
          num valueChangeOfUnit,
          int harvestId,
          int campaignId) =>
      _harvestInCampaignProvider.updateHarvestInCampaign(
          harvestInCampaignId,
          productName,
          unit,
          inventory,
          quantity,
          price,
          valueChangeOfUnit,
          harvestId,
          campaignId);

  Future<int> deleteHarvestInCampaign(int harvestInCampaignId) => _harvestInCampaignProvider.deleteHarvestInCampaign(harvestInCampaignId);
}
