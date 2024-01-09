import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/constants/text_cosntants.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          iconSize: 20,
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText.normalText('Change Password'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SizedBox(
          height: s.height,
          width: s.width.h,
          child: Column(
            children: [
              fixedVerticalSpace(20.h),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius)),
                child: SizedBox(
                  height: 65.h,
                  width: s.width * 0.9,
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(medBorderRadius)),
                  child: Padding(
                    padding: AppPaddings.horizontalSymmetricPadding,
                    child: Center(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Old password',
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius)),
                child: SizedBox(
                  height: 65.h,
                  width: s.width * 0.9,
                  child: Padding(
                    padding: AppPaddings.horizontalSymmetricPadding,
                    child: Center(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'New password',
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius)),
                child: SizedBox(
                  height: 65.h,
                  width: s.width * 0.9,
                  child: Padding(
                    padding: AppPaddings.horizontalSymmetricPadding,
                    child: Center(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                )),
                            hintText: 'Confirm new password'),
                      ),
                    ),
                  ),
                ),
              ),
              fixedVerticalSpace(s.height * 0.1.h),
              MaterialButton(
                  height: 50.h,
                  minWidth: s.width * 0.9,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallBorderRadius)),
                  color: primaryColor,
                  child: CustomText.normalText('Save Changes',
                      color: Colors.white),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
