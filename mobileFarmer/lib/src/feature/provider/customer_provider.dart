import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/customer.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';

class CustomerProvider {
  static BaseApi<Customer> api = BaseApi<Customer>();

  Future<Pagination<Customer>> getListCustomer(
      int page, int size, String farmerId) async {
    String url = urlServer + "users/loyal-customers/farm/" + farmerId +
        "?page=" + page.toString() + "&size=" + size.toString();
    int statusCode = 0;
    Pagination<Customer> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<Customer>.fromJson(response, Customer.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load customer');
      }
    }
    return list;
  }
}
