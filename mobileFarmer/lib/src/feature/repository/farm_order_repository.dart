import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:farmer_application/src/feature/provider/farm_order_provider.dart';

class NeedConfirmFarmOrderRepository {
  final _farmOrderProvider = FarmOrderProvider();

  Future<Pagination<FarmOrder>> getListFarmOrder(
      int page, int size, String farmerId, String status) => _farmOrderProvider.getListFarmOrder(page, size, farmerId, status);

  Future<FarmOrderDetail> getFarmOrderById(int farmOrderId) => _farmOrderProvider.getFarmOrderById(farmOrderId);

  Future<int> updateStatusFarmOrder(int farmOrderId, int status) => _farmOrderProvider.updateStatusFarmOrder(farmOrderId, status);

  Future<int> cancelFarmOrder(int farmOrderId, String note) => _farmOrderProvider.cancelFarmOrder(farmOrderId, note);

  Future<int> getCountFarmOrderByStatus(String farmerId, int status) => _farmOrderProvider.getCountFarmOrderByStatus(farmerId, status);
}
