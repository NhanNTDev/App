import '../model/notification.dart';
import '../provider/notification_provider.dart';

class NotificationRepository {
  final _notificationProvider = NotificationProvider();

  Future<List<Notifications>> getListNotifications(String farmerId) =>
      _notificationProvider.getListNotifications(farmerId);
}
