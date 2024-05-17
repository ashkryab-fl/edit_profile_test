import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_profile/di/locator.dart';
import 'package:test_profile/pages/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:test_profile/pages/edit_profile/edit_profile_page.dart';
import 'package:test_profile/services/user_data_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (_) => EditProfileBloc(UserServices()),
          child: const EditProfilePage()),
    );
  }
}
