import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/provider/harvest_provider.dart';
import 'package:farmer_application/src/feature/screen/campaign_apply_request/campaign_apply_request_screen.dart';

class HarvestRepository {
  final _harvestProvider = HarvestProvider();

  Future<Pagination<Harvest>> fetchAllHarvestsByFarmer(
          int page, int size, String farmerId) =>
      _harvestProvider.getListHarvestsByFarmer(page, size, farmerId);

  Future<Pagination<Harvest>> fetchAllHarvestsByFarm(
          int page, int size, int farmId) =>
      _harvestProvider.getListHarvestsByFarm(page, size, farmId);

  Future<Harvest> getHarvestById(int harvestId) =>
      _harvestProvider.getHarvestById(harvestId);

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
          int productSystemId) =>
      _harvestProvider.createNewHarvest(
          harvestName,
          productNameChange,
          images,
          harvestDescription,
          dateHarvestStart,
          dateEstimateHarvest,
          inventory,
          actualProduction,
          farmId,
          productSystemId);

  Future<int> updateHarvest(
          int harvestId,
          List<String> images,
          String harvestName,
          String harvestDescription,
          String productNameChange,
          int actualProduction,
          DateTime dateEstimatedHarvest) =>
      _harvestProvider.updateHarvest(harvestId, images, harvestName,
          harvestDescription, productNameChange,actualProduction, dateEstimatedHarvest);

  Future<int> deleteHarvest(int harvestId) =>
      _harvestProvider.deleteHarvest(harvestId);

  Future<List<HarvestModel>> getHarvestInFarm(int farmId) =>
      _harvestProvider.getHarvestInFarm(farmId);

  Future<int> getCountHarvestByFarmer(String farmerId) =>
      _harvestProvider.getCountHarvestByFarmer(farmerId);

  Future<List<SearchHarvest>> getHarvestByName(
          String search, String farmerId) =>
      _harvestProvider.getHarvestByName(search, farmerId);

  Future<List<HarvestInCampaignModel>> getHarvestSuggest(
          String farmerId, int campaignId) =>
      _harvestProvider.getHarvestSuggest(farmerId, campaignId);

  Future<List<HarvestSuggest>> getHarvestSuggestByFarm(
      int farmId, int campaignId) => _harvestProvider.getHarvestSuggestByFarm(farmId, campaignId);
}
