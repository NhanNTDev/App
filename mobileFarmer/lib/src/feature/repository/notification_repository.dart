import 'package:farmer_application/src/feature/model/notification.dart';
import 'package:farmer_application/src/feature/provider/notification_provider.dart';

class NotificationRepository {
  final _notificationProvider = NotificationProvider();

  Future<List<Notifications>> getListNotifications(String farmerId) =>
      _notificationProvider.getListNotifications(farmerId);
}
