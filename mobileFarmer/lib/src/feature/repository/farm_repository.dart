import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/feedback.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/provider/farm_provider.dart';

class FarmRepository {
  final _farmProvider = FarmProvider();

  Future<Pagination<Farm>> fetchAllFarmByFarmer(
          int page, int size, String farmerId) =>
      _farmProvider.getListFarmByFarmer(page, size, farmerId);

  Future<Farm> getFarmById(int farmId) => _farmProvider.getFarmById(farmId);

  Future<int> addNewFarm(String avatar, List<String> images, String farmName,
          String farmDescription, String farmAddress, String farmerId, int farmZoneId) =>
      _farmProvider.addNewFarm(avatar, images, farmName, farmDescription,
          farmAddress, farmerId, farmZoneId);

  Future<int> updateFarm(int farmId, String avatar, List<String> images,
          String farmName, String farmDescription, String farmAddress) =>
      _farmProvider.updateFarm(
          farmId, avatar, images, farmName, farmDescription, farmAddress);

  Future<int> deleteFarm(int farmId) => _farmProvider.deleteFarm(farmId);

  Future<List<FarmModel>> getFarmCanJoinCampaign(
          String farmerId, int campaignId) =>
      _farmProvider.getFarmCanJoinCampaign(farmerId, campaignId);

  Future<List<SearchFarm>> getFarmByName(String search, String farmerId) =>
      _farmProvider.getFarmByName(search, farmerId);

  Future<int> getCountFarmByFarmer(String farmerId) => _farmProvider.getCountFarmByFarmer(farmerId);

  Future<Pagination<FeedbackInFarm>> getListFeedBackByFarm(
      int page, int size, int farmId) => _farmProvider.getListFeedBackByFarm(page, size, farmId);
}
