import 'dart:convert';

import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:flutter/services.dart';

class GeographyProvider {
  ///Read JSON province/city data from assets
  Future<dynamic> getProvinceOrCityResponse() async {
    var res = await rootBundle.loadString(UIData.getProvinceOrCity);
    return jsonDecode(res);
  }

  ///Read JSON district data from assets
  Future<dynamic> getDistrictResponse(String fileName) async {
    var res = await rootBundle
        .loadString('assets/jsons/geography/district/$fileName.json');
    return jsonDecode(res);
  }

  ///Read JSON sub district/village data from assets
  Future<dynamic> getSubDistrictOrVillageResponse(String fileName) async {
    var res = await rootBundle.loadString(
        'assets/jsons/geography/sub_district_village/$fileName.json');
    return jsonDecode(res);
  }
}
