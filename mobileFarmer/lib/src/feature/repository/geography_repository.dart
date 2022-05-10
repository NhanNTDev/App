import 'package:farmer_application/src/feature/provider/geography_provider.dart';

class GeographyRepository {
  final _geographyProvider = GeographyProvider();

  Future getProvinceOrCity() => _geographyProvider.getProvinceOrCityResponse();

  Future getDistrictByCode(String fileName) =>
      _geographyProvider.getDistrictResponse(fileName);

  Future getSubDistrictOrVillageByCode(String fileName) =>
      _geographyProvider.getSubDistrictOrVillageResponse(fileName);
}
