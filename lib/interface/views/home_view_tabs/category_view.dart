import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view_tabs/add_category_tabs/category_details_view.dart';
import 'package:vendorapp/interface/views/home_view_tabs/add_category_tabs/edit_category.dart';
import 'package:vendorapp/interface/views/home_view_tabs/add_new_category.dart';
import '../../utils/constants/text_cosntants.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final String _drpDownValue = 'Newly added first';

  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return SafeArea(
      child: Center(
        child: SizedBox(
            // color: Colors.black,
            width: s.width * 0.85,
            height: s.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomText.largeText('My Stock', fontSize: 24.h),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(const AddNewCategoryView());
                  },
                  child: Container(
                      width: (s.width * 0.85),
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                          child: CustomText.boldText('Add Category',
                              color: primaryColor))),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.normalText('Categories'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() => Expanded(
                      child: userController.isCategoryLoading.value
                          ? const Center(
                              child: Text('Loading categories'),
                            )
                          : ListView.builder(
                              itemCount: userController.categories.length,
                              itemBuilder: (context, ind) {
                                return Padding(
                                  padding: AppPaddings.topPadding,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: ListTile(
                                          onTap: () {
                                            Get.to(CategoryDetailsView(
                                              category: userController
                                                  .categories[ind],
                                            ));
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.memory(
                                                  base64Decode(userController
                                                      .categories[ind].image),
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: CustomText.normalText(
                                              userController
                                                  .categories[ind].title),
                                          subtitle: CustomText.smallText(
                                              '${userController.categories[ind].description} in stock',
                                              color: Colors.grey),
                                          trailing: PopupMenuButton(
                                            padding: const EdgeInsets.all(0),
                                            itemBuilder: (context) =>
                                                <PopupMenuItem>[
                                              PopupMenuItem<int>(
                                                onTap: () async {
                                                  Get.to(EditCategoryView(
                                                      category: userController
                                                          .categories[ind]));
                                                },
                                                value: 0,
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.edit_note,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text('Edit',
                                                        style: TextStyle(
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem<int>(
                                                onTap: () async {
                                                  userController.delCategory(
                                                      userController
                                                          .categories[ind].id);
                                                },
                                                value: 0,
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      'Delete Category',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              }),
                    ))
              ],
            )),
      ),
    );
  }
}
