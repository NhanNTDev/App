import 'package:delivery_driver_application/src/core/base/base_api.dart';
import 'package:delivery_driver_application/src/core/config/server_address.dart';
import 'package:delivery_driver_application/src/feature/model/pagination.dart';
import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';

import 'package:http/http.dart' as http;

class ShippingOrderProvider {
  static BaseApi<DeliveryShipping> api = BaseApi<DeliveryShipping>();

  // Future<Pagination<ShippingOrder>> getListShippingOrders(
  //     int page, int size, String deliveryDriverId, int status) async {
  //   String url = urlServer +
  //       "orders/driver/" +
  //       deliveryDriverId +
  //       "?status=" +
  //       status.toString() +
  //       "&page=1&size=10";
  //   int statusCode = 0;
  //   Pagination<ShippingOrder> list =
  //       Pagination(size: 0, total: 0, items: [], page: 0);
  //   var response = await api.getAPICall(url);
  //   if (response != null) {
  //     statusCode = response['status']['status code'];
  //     if (statusCode == 200) {
  //       print(response['data']);
  //       list = Pagination<ShippingOrder>.fromJson(
  //           response, ShippingOrder.fromJsonModel);
  //     } else {
  //       // If that call was not successful, throw an error.
  //       throw Exception('Failed to load order');
  //     }
  //   }
  //   return list;
  // }

  Future<Pagination<DeliveryShipping>> getListShippingOrders(
      int page, int size, String deliveryDriverId, bool completed) async {
    String url = urlServer +
        "orders/driver/" +
        deliveryDriverId +
        "?completed=" +
        completed.toString() +
        "&page=1&size=10";
    int statusCode = 0;
    Pagination<DeliveryShipping> list =
    Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<DeliveryShipping>.fromJson(
            response, DeliveryShipping.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load order');
      }
    }
    return list;
  }


  Future<int> updateStatusOrder(int orderId, int status) async {
    String url = urlServer + "orders/" + orderId.toString();
    int statusCode = 0;

    var body = {"id": orderId, "status": status};

    var response = await api.putAPICall1(url, param: body);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("cap nhat thanh cong");
      } else {
        print("cap nhat that bai");
      }
    }
    return statusCode;
  }

  Future<int> cancelOrder(int orderId, String note) async {
    String url = urlServer + "orders/" + orderId.toString() + "?note=" + note ;
    int statusCode = 0;
    var response = await api.deleteAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print("Hủy thanh cong");
      } else {
        print("Hủy that bai");
      }
    }
    return statusCode;
  }

  Future<CountTask> countTaskForDriver(String driverId) async {
    String url = urlServer + "shipments/tasks/" + driverId;
    int statusCode = 0;

    var response = await api.getAPICall(url);
    CountTask result = CountTask(taskOfCollections: 0, taskOfShipments: 0, taskOfDeliveries: 0);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        result = CountTask.fromJson(response['data']);
      } else {
        print("cap nhat that bai");
      }
    }
    print(result.taskOfCollections);
    return result;
  }

}
