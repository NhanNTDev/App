import 'dart:convert';
import 'package:delivery_driver_application/src/core/base/base_api.dart';
import 'package:delivery_driver_application/src/core/config/server_address.dart';
import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/pagination.dart';

import 'package:http/http.dart' as http;

class CollectOrderProvider {
  static BaseApi<CollectDestination> api = BaseApi<CollectDestination>();

  Future<Pagination<CollectDestination>> getListFarmOrder(
      int page, int size, String deliveryDriverId, bool completed) async {
    String url =
        urlServer + "farm-orders/driver/" +deliveryDriverId + "?completed=" + completed.toString()+ "&page=1&size=10";
    int statusCode = 0;
    Pagination<CollectDestination> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
        list = Pagination<CollectDestination>.fromJson(response, CollectDestination.fromJsonModel);
        print(list.items.length);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return list;
  }

  // Future<List<CollectDestination>> getListFarmOrder(
  //     int page, int size, String deliveryDriverId, int status) async {
  //   String url =
  //       "http://localhost:3000/data";
  //   int statusCode = 0;
  //   // Pagination<CollectOrder> list = Pagination(size: 0, total: 0, items: [], page: 0);
  //   List<CollectDestination> list = [];
  //   var response = await api.getAPICall(url);
  //   print(response);
  //   if (response != null) {
  //     statusCode = response['status']['status code'];
  //     if (statusCode == 200) {
  //       print(response['data']);
  //       // list = List<Farm>.from(json['farms']
  //       //     .map((itemsJson) => Farm.fromJsonModel(itemsJson)));
  //     } else {
  //       // If that call was not successful, throw an error.
  //       throw Exception('Failed to load farm');
  //     }
  //   }
  //   return list;
  // }

  Future<int> updateStatusFarmOrder(int farmOrderId, int status) async{
    String url = urlServer + "farm-orders/update/" +
        farmOrderId.toString() + "?status=" + status.toString();
    int statusCode = 0;

    var response = await api.putAPICall2(url);
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

  Future<int> cancelFarmOrder(int farmOrderId, String note) async{
    String url = urlServer + "farm-orders/cancel/" +
        farmOrderId.toString() + "?note=" + note;
    int statusCode = 0;

    var response = await api.putAPICall2(url);
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
