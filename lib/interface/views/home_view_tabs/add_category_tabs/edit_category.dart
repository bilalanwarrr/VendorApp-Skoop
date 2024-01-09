import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendorapp/interface/utils/constants/models/category.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';

import '../../../utils/constants/fixed_constants.dart';
import '../../../utils/constants/text_cosntants.dart';
import '../../../utils/constants/toast.dart';
import '../../../utils/themes/app_theme.dart';
import '../../controllers/user_controller.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({super.key, required this.category});
  final CategoryModel category;
  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  UserController userController = Get.find<UserController>();

  XFile? imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.category.title;

    // descController.text=widget.category./
  }

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
        title: CustomText.normalText('Update Category'),
      ),
      body: Center(
        child: Container(
          height: s.height,
          width: s.width.h,
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                fixedVerticalSpace(20.h),
                Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                base64Decode(widget.category.image),
                                fit: BoxFit.cover,
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
                        : CustomText.normalText('Update Category',
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
                          userController.updateCategory(
                              titleController.text,
                              widget.category.id,
                              descController.text,
                              imageFile!);
                        }
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
