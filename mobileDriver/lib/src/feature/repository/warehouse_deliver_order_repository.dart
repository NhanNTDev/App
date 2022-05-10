import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/pagination.dart';
import 'package:delivery_driver_application/src/feature/model/warehouse_deliver_order.dart';
import 'package:delivery_driver_application/src/feature/provider/collect_order_provider.dart';
import 'package:delivery_driver_application/src/feature/provider/warehouse_deliver_order_provider.dart';

class WarehouseDeliverOrderRepository {
  final _warehouseDeliverOrderProvider = WarehouseDeliverOrderProvider();

  Future<Pagination<WarehouseDeliverOrder>> getListShipment(
          int page, int size, String deliveryDriverId, int status) =>
      _warehouseDeliverOrderProvider.getListShipment(
          page, size, deliveryDriverId, status);

  Future<int> updateStatusShipment(int shipmentId) =>
      _warehouseDeliverOrderProvider.updateStatusShipment(shipmentId);
}
