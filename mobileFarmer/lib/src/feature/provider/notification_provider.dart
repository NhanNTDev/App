import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/server_address.dart';
import 'package:farmer_application/src/feature/model/notification.dart';

class NotificationProvider {
  static BaseApi<Notifications> api = BaseApi<Notifications>();

  Future<List<Notifications>> getListNotifications(String farmerId) async {
    String url = urlServer + "externals/notification/"+ farmerId;
    int statusCode = 0;
    List<Notifications> list = [];
    var response = await api.getAPICall(url);
    if (response != null) {
      statusCode = response['status']['status code'];
      if (statusCode == 200) {
        list = List<Notifications>.from(response['data']
            .map((itemsJson) => Notifications.fromJsonModel(itemsJson)));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load notification');
      }
    }
    return list;
  }

}
