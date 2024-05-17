import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_profile/repo/abstracts/user_data_repo.dart';

class SharedPreferencesUserRepository implements UserRepository {
  final String _storageKey = 'user_info';

  @override
  Future<void> saveUser(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = jsonEncode(userInfo);
    await prefs.setString(_storageKey, encodedJson);
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(_storageKey);
    if (encodedJson != null) {
      return jsonDecode(encodedJson) as Map<String, dynamic>;
    }
    return null;
  }
}