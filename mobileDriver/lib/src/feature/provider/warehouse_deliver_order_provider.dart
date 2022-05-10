import 'dart:convert';
import 'package:delivery_driver_application/src/core/base/base_api.dart';
import 'package:delivery_driver_application/src/core/config/server_address.dart';
import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/pagination.dart';
import 'package:delivery_driver_application/src/feature/model/warehouse_deliver_order.dart';

import 'package:http/http.dart' as http;

class WarehouseDeliverOrderProvider {
  static BaseApi<WarehouseDeliverOrder> api = BaseApi<WarehouseDeliverOrder>();

  Future<Pagination<WarehouseDeliverOrder>> getListShipment(
      int page, int size, String deliveryDriverId, int status) async {
    String url =
        urlServer + "shipments/driver/" +deliveryDriverId + "?status=" + status.toString()+ "&page=1&size=10";
    int statusCode = 0;
    Pagination<WarehouseDeliverOrder> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
        list = Pagination<WarehouseDeliverOrder>.fromJson(response, WarehouseDeliverOrder.fromJsonModel);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load shipment');
      }
    }
    return list;
  }

  Future<int> updateStatusShipment(int shipmentId) async{
    String url = urlServer + "shipments/driver/complete-task/" + shipmentId.toString();
    int statusCode = 0;

    var response = await api.putAPICall1(url, param: {});
    if(response != null){
      statusCode = response['status']['status code'];
      if(statusCode == 200){
        print("cap nhat thanh cong");
      }else{
        print("cap nhat that bai");
      }
    }
    return statusCode;
  }

}
