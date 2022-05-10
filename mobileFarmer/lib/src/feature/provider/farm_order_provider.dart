import 'dart:convert';

import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/pagination.dart';
import 'package:http/http.dart' as http;

class FarmOrderProvider {
  static BaseApi<FarmOrder> api = BaseApi<FarmOrder>();

  Future<Pagination<FarmOrder>> getListFarmOrder(
      int page, int size, String farmerId, String status) async {
    String url = urlServer + "farm-orders/all/" + farmerId +
        "?status=" + status + "&page=" + page.toString() + "&size=" + size.toString();
    int statusCode = 0;
    Pagination<FarmOrder> list = Pagination(size: 0, total: 0, items: [], page: 0);
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = Pagination<FarmOrder>.fromJson(response, FarmOrder.fromJsonModel);
        print(list.items.length);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm order');
      }
    }
    return list;
  }

  Future<FarmOrderDetail> getFarmOrderById(int farmOrderId) async {
    String url = urlServer + "farm-orders/" +
        farmOrderId.toString();
    int statusCode = 0;
    FarmOrderDetail farmOrder = FarmOrderDetail(code: '', total: 0, status: '', createAt: '', orderId: 0, customerName: ''
        , campaignName:'', address: '', paymentStatus: '', paymentTypeName: '', farmName: '', harvestOrders: [], phone: '', feedBackCreateAt: '', star: 0, content: '', note: '');
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        print(response['data']);
        farmOrder = FarmOrderDetail.fromJson(response['data']);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm order');
      }
    }
    return farmOrder;
  }

  Future<int> updateStatusFarmOrder(int farmOrderId, int status) async{
    String url = urlServer + "farm-orders/update/" +
        farmOrderId.toString() + "?status=" + status.toString();
    int statusCode = 0;
    var body = {
      "id": farmOrderId,
      "status": status
    };
    var response = await api.putAPICall1(url, param: body);
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

  Future<int> getCountFarmOrderByStatus(String farmerId, int status) async{
    String url =  urlServer + "farm-orders/count/" + farmerId + "?status=" + status.toString();
    int count = 0;
    var response = await api.getAPICall(url);
    if(response != null){
      if (response['status']['status code'] == 200) {
        count = response['data'];
      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load farm');
      }
    }
    return count;
  }
}
