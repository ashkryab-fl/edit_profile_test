import 'package:get_it/get_it.dart';
import 'package:test_profile/repo/abstracts/user_data_repo.dart';
import 'package:test_profile/repo/local_user_repo.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<UserRepository>(SharedPreferencesUserRepository());
}