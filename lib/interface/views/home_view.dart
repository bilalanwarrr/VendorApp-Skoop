import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view_tabs/category_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/dashboard_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/profile_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/settings_view.dart';

import '../utils/themes/app_theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentTab = 1;
  UserController userController = Get.find();
  final List<Widget> _tabs = [
    DashboardView(),
    const CategoryView(),
    const SettingsView(),
    const ProfileView()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getVendorProfile();
    userController.getALlUserItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _tabs[_currentTab],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          currentIndex: _currentTab,
          selectedItemColor: Colors.white,
          // unselectedItemColor: secondaryColor,
          selectedLabelStyle: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          unselectedLabelStyle: GoogleFonts.montserrat(
              textStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          onTap: (val) {
            setState(() {
              _currentTab = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                      _currentTab == 0 ? Colors.white : primaryColor,
                  child: Image.asset(
                    'lib/assets/icons/nav1.png',
                    color: _currentTab == 0 ? primaryColor : Colors.white70,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                      _currentTab == 1 ? Colors.white : primaryColor,
                  child: Image.asset(
                    'lib/assets/icons/nav2.png',
                    color: _currentTab == 1 ? primaryColor : Colors.white,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                      _currentTab == 2 ? Colors.white : primaryColor,
                  child: Image.asset(
                    'lib/assets/icons/nav3.png',
                    color: _currentTab == 2 ? primaryColor : Colors.white,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
                label: 'Settings'),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                      _currentTab == 3 ? Colors.white : primaryColor,
                  child: Image.asset(
                    'lib/assets/icons/nav4.png',
                    color: _currentTab == 3 ? primaryColor : Colors.white,
                  ),
                ),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
