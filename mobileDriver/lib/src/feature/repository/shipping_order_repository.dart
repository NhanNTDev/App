import 'package:delivery_driver_application/src/feature/model/pagination.dart';
import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';
import 'package:delivery_driver_application/src/feature/provider/shipping_order_provider.dart';

class ShippingOrderRepository {
  final _shippingOrderProvider = ShippingOrderProvider();

  // Future<Pagination<ShippingOrder>> getListShippingOrders(
  //     int page, int size, String deliveryDriverId, int status) => _shippingOrderProvider.getListShippingOrders(page, size, deliveryDriverId, status);
  Future<Pagination<DeliveryShipping>> getListShippingOrders(
      int page, int size, String deliveryDriverId, bool completed) => _shippingOrderProvider.getListShippingOrders(page, size, deliveryDriverId, completed);

  Future<int> updateStatusOrder(int orderId, int status) => _shippingOrderProvider.updateStatusOrder(orderId, status);

  Future<CountTask> countTaskForDriver(String driverId) => _shippingOrderProvider.countTaskForDriver(driverId);

  Future<int> cancelOrder(int orderId, String note) => _shippingOrderProvider.cancelOrder(orderId, note);
}
