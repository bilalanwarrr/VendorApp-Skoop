import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/constants/text_cosntants.dart';
import 'package:vendorapp/interface/utils/constants/toast.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  UserController userController = Get.find<UserController>();

  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Container(
      height: s.height,
      width: s.width.h,
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            fixedVerticalSpace(20.h),
            Card(
              elevation: 3,
              child: GestureDetector(
                onTap: () async {
                  XFile? res = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (res != null) {
                    setState(() {
                      imageFile = res;
                    });
                  }
                },
                child: Container(
                  height: (s.height * 0.3).h,
                  width: (s.width * 0.9).h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: imageFile != null
                      ? Image.file(File(imageFile!.path))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/icons/select-img-icon.png'),
                            fixedVerticalSpace(5.h),
                            CustomText.bodyText('Select image',
                                color: Colors.grey.shade700)
                          ],
                        ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius)),
              child: SizedBox(
                height: 65.h,
                width: s.width * 0.9.h,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                child: Padding(
                  padding: AppPaddings.horizontalSymmetricPadding,
                  child: Center(
                    child: TextFormField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(hintText: 'Category title'),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius)),
              child: SizedBox(
                height: 100.h,
                width: s.width * 0.9.h,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                child: Padding(
                  padding: AppPaddings.horizontalSymmetricPadding,
                  child: Center(
                    child: TextFormField(
                      controller: descController,
                      decoration: const InputDecoration(
                          hintText: 'Write description here...'),
                    ),
                  ),
                ),
              ),
            ),
            fixedVerticalSpace(s.height * 0.2.h),
            Obx(() => MaterialButton(
                height: 50.h,
                minWidth: s.width * 0.9.h,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius)),
                color: primaryColor,
                child: userController.isCategoryLoading.value
                    ? const CircularProgressIndicator()
                    : CustomText.normalText('Add Category',
                        color: Colors.white),
                onPressed: () async {
                  if (titleController.text.length < 3) {
                    showToastShort('Title too short', Colors.yellow);
                  }
                  if (descController.text.length < 3) {
                    showToastShort('Description too short', Colors.yellow);
                  } else {
                    if (imageFile == null) {
                      showToastShort('Pick image first', Colors.yellow);
                    } else {
                      userController.addCategory(titleController.text,
                          descController.text, imageFile!);
                    }
                  }
                }))
          ],
        ),
      ),
    );
  }
}
