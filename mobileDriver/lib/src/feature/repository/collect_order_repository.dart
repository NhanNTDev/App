import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/pagination.dart';
import 'package:delivery_driver_application/src/feature/provider/collect_order_provider.dart';

class CollectOrderRepository {
  final _collectOrderProvider = CollectOrderProvider();

  Future<Pagination<CollectDestination>> getListFarmOrder(int page, int size, String deliveryDriverId, bool completed) => _collectOrderProvider.getListFarmOrder(page,size, deliveryDriverId,completed);

  // Future<List<CollectDestination>> getListFarmOrder(int page, int size, String deliveryDriverId, int status) => _collectOrderProvider.getListFarmOrder(page,size, deliveryDriverId,status);

  Future<int> updateStatusFarmOrder(int farmOrderId, int status) => _collectOrderProvider.updateStatusFarmOrder(farmOrderId, status);

  Future<int> cancelFarmOrder(int farmOrderId, String note) => _collectOrderProvider.cancelFarmOrder(farmOrderId, note);
}
