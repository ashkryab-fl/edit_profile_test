abstract class UserRepository {
  Future<void> saveUser(Map<String, dynamic> userInfo);
  Future<Map<String, dynamic>?> getUser();
}