import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/login_view.dart';
import 'package:vendorapp/interface/views/splash_screen.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(428, 926),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return GetMaterialApp(
        theme: AppTheme.apptheme(),
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
      );
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = Get.put(UserController());
  checkLoggedIn() async {
    var ins = await SharedPreferences.getInstance();
    if (ins.containsKey('token')) {
      if (ins.getString('token') != null) {
        userController.token.value = ins.getString('token') ?? '';
        Get.to(const HomeView());
      }
    } else {
      Get.to(const LoginScreen());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
