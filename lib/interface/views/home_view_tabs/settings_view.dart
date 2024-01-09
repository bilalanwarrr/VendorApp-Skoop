import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view_tabs/login_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/settings_view_tabs/change_password_view.dart';

import '../../utils/constants/fixed_constants.dart';
import '../../utils/constants/text_cosntants.dart';
import '../../utils/themes/app_theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomText.extraBoldText('Settings', fontSize: 22.sp),
      ),
      body: SizedBox(
        height: s.height,
        width: s.width,
        child: Padding(
          padding: AppPaddings.horizontalSymmetricPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            fixedVerticalSpace(20.h),
            // Card(
            //   elevation: 3,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(largelBorderRadius)),
            //   child: Center(
            //       child: ListTile(
            //     onTap: () {
            //       Get.to(const ChangePasswordView());
            //     },
            //     leading: const Icon(Icons.lock_outline_rounded),
            //     trailing: const Icon(Icons.arrow_forward_ios_rounded),
            //     title: CustomText.smallText('Change Password', fontSize: 18.sp),
            //   )),
            // ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(largelBorderRadius)),
              child: Center(
                  child: ListTile(
                onTap: () async {
                  SharedPreferences inst =
                      await SharedPreferences.getInstance();
                  await inst.remove('token');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                leading: const Icon(Icons.logout),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                title: CustomText.smallText('Logout', fontSize: 18.sp),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
