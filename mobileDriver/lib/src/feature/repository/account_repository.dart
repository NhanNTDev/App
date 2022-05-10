import 'package:delivery_driver_application/src/feature/provider/account_provider.dart';

class AccountRepository {
  final accountProvider = AccountProvider();

  Future login(String username, String password) =>
      accountProvider.login(username, password);

  Future<dynamic> updateAvatar(String farmerId, String avatar) =>
      accountProvider.updateAvatar(farmerId, avatar);

  Future<int> forgotPassword(String username, String newPassword) =>
      accountProvider.forgotPassword(username, newPassword);

  Future<int> checkDuplicatePhone(String phoneNumber) =>
      accountProvider.checkDuplicatePhone(phoneNumber);

  Future<dynamic> changePassword(
          String farmerId, String currentPassword, String newPassword) =>
      accountProvider.changePassword(farmerId, currentPassword, newPassword);

  Future<int> updateAccount(String farmerId, String fullName,
      String dateOfBirth, String gender, String address) =>
      accountProvider.updateAccount(
          farmerId, fullName, dateOfBirth, gender, address);
}
