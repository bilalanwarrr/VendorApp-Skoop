import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:vendorapp/interface/utils/constants/constants.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';

import '../../utils/constants/text_cosntants.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: CustomText.extraBoldText(userController.vendor!.name,
            fontSize: 22.sp),
      ),
      body: Obx(() => userController.isCategoryLoading.value || userController.isItemLoading.value ?
      
      const Center(child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.orange),
      ),)
       : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Card(
            elevation: 0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              // trailing: const Icon(Icons.keyboard_arrow_down_rounded),
              title: CustomText.normalText('Overview'),
            ),
          ),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              // trailing: Icon(
              //   Icons.line_weight_sharp,
              //   color: primaryColor,
              // ),
              title: CustomText.normalText('Categories'),
              subtitle: CustomText.normalText(
                  '  ${userController.categories.length}'),
            ),
          ),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // trailing: Icon(
              //   Icons.list,
              //   color: primaryColor,
              // ),
              title: CustomText.normalText('Items/Ingredients'),
              subtitle: CustomText.normalText(
                  '  ${userController.userCategory.length}'),
            ),
          ),
        ]),
      ),)
    );
  }
}
