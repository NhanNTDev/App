import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/model/product_system.dart';

class ProductSystemProvider {
  static BaseApi<ProductSystem> api = BaseApi<ProductSystem>();

  Future<Pagination<ProductSystem>> getListProductSystem(int page, int size) async {
    String url = urlServer + "product-systems?page=" +
        page.toString() +
        "&size=" +
        size.toString();
    int statusCode = 0;
    Pagination<ProductSystem> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<ProductSystem>.fromJson(response, ProductSystem.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load product system');
      }
    }
    return list;
  }
}
