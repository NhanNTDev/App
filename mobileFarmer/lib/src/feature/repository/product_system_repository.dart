import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/model/product_system.dart';
import 'package:farmer_application/src/feature/provider/product_system_provider.dart';

class ProductSystemRepository {
  final _productSystemProvider = ProductSystemProvider();

  Future<Pagination<ProductSystem>> fetchAllProductSystem(int page, int size) =>
      _productSystemProvider.getListProductSystem(page, size);
}