import 'package:test_profile/di/locator.dart';

import '../repo/abstracts/user_data_repo.dart';

class UserServices   {
  final UserRepository _userRepository = getIt<UserRepository>();

  late Map<String, dynamic> _userInfo;

  Future<void> loadUserInfo() async {
    final userInfo = await _userRepository.getUser()??{};
      _userInfo = userInfo;
  }

  Map<String, dynamic> get userInfo => _userInfo;

  Future<void> saveUserInfo(Map<String, dynamic> newUserInfo) async {
    await _userRepository.saveUser(newUserInfo);
    _userInfo = newUserInfo;
  }
}