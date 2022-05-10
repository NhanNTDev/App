import 'package:farmer_application/src/feature/model/account.dart';
import 'package:farmer_application/src/feature/provider/account_provider.dart';

class AccountRepository {
  final _accountProvider = AccountProvider();

  Future login(String username, String password) =>
      _accountProvider.login(username, password);

  Future<int> checkDuplicatePhone(String phoneNumber) =>
      _accountProvider.checkDuplicatePhone(phoneNumber);

  Future<dynamic> registerFarmer(String phoneNumber, String password) =>
      _accountProvider.registerFarmer(phoneNumber, password);

  Future<int> updateAccount(String farmerId, String fullName,
          String dateOfBirth, String gmail, String gender, String address) =>
      _accountProvider.updateAccount(
          farmerId, fullName, dateOfBirth, gmail, gender, address);

  Future<dynamic> updateAvatar(String farmerId, String avatar) =>
      _accountProvider.updateAvatar(farmerId, avatar);

  Future<dynamic> changePassword(
          String farmerId, String currentPassword, String newPassword) =>
      _accountProvider.changePassword(farmerId, currentPassword, newPassword);

  Future<int> forgotPassword(String username, String newPassword) =>
      _accountProvider.forgotPassword(username, newPassword);

  Future<DashBoard> getDashBoard(String farmerId) => _accountProvider.getDashBoard(farmerId);

  Future<Revenue> getRevenue(String farmerId) => _accountProvider.getRevenue(farmerId);
}
