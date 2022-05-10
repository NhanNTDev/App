import 'package:farmer_application/src/feature/provider/customer_provider.dart';

import '../model/customer.dart';
import '../model/pagination.dart';

class CustomerRepository {
  final _customerProvider = CustomerProvider();

  Future<Pagination<Customer>> getListCustomer(
      int page, int size, String farmerId)  => _customerProvider.getListCustomer(page, size, farmerId);
}
