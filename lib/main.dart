import 'package:app/src/features/register/presentation/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/features/dashboard/presentation/dashboard_page.dart';
import 'src/features/login/presentation/login_page.dart';
import 'src/presentation/controllers/authentication_controller.dart';

import 'src/utils/color_constants.dart';
import 'src/utils/app_constants.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //lazy get put AuthenticationController
  Get.put(AuthenticationController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        primarySwatch: ColorConstants.primarySwatch,
        primaryColor: ColorConstants.primaryColor,
      ),
      darkTheme: ThemeData(
        primarySwatch: ColorConstants.darkPrimarySwatch,
        primaryColor: ColorConstants.darkPrimaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
      onGenerateRoute: (settings) {
        // If a named route is requested that doesn't have a corresponding
        // route handler, this callback is executed.
        // In this example, we just redirect to the home page.
        return MaterialPageRoute(builder: (context) => const LoginPage());
      },
    );
  }
}
