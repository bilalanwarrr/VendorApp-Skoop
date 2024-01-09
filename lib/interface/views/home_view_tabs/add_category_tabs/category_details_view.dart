import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/constants/models/category.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/constants/text_cosntants.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view_tabs/add_category_tabs/edit_ingred.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({super.key, required this.category});
  final CategoryModel category;
  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  UserController userController = Get.find<UserController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getItems(widget.category.id);
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
        title: CustomText.normalText('Category Details'),
      ),
      body: SizedBox(
        height: s.height,
        width: s.width,
        child: Padding(
          padding: AppPaddings.horizontalSymmetricPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            fixedVerticalSpace(20.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 50.h,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        base64Decode(
                          widget.category.image,
                        ),
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      )),
                ),
                fixedHorzSpace(20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.boldText(widget.category.title, fontSize: 22.sp),
                    CustomText.smallText('100 Ingredients Items'),
                  ],
                )
              ],
            ),
            fixedVerticalSpace(20.h),
            CustomText.extraBoldText('Ingredients', fontSize: 22.sp),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(largelBorderRadius)),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Search an item...'),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<UserController>(
                  builder: (controller) => controller.isItemLoading.value
                      ? const Center(
                          child: Text('No items...'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.itemsOfCategory.length,
                          itemBuilder: (context, ind) {
                            return Padding(
                              padding: AppPaddings.topPadding,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 3,
                                child: ListTile(
                                    minVerticalPadding: 0,
                                    onTap: () {
                                      // Get.to(const CategoryDetailsView());
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          primaryColor.withOpacity(0.8),
                                      radius: 20,
                                      child: const Center(
                                        child: Text(
                                          'T',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    title: CustomText.smallText(
                                        controller.itemsOfCategory[ind].name,
                                        fontSize: 16.sp),
                                    subtitle: CustomText.boldText(
                                        '\$ ${controller.itemsOfCategory[ind].price}',
                                        color: primaryColor),
                                    trailing: PopupMenuButton(
                                      padding: const EdgeInsets.all(0),
                                      itemBuilder: (context) => <PopupMenuItem>[
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            Get.to(EditIngredView(
                                              item: controller
                                                  .itemsOfCategory[ind],
                                            ));
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
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 0,
                                          onTap: () async {
                                            controller.delItem(userController
                                                .itemsOfCategory[ind].id);
                                            controller
                                                .getItems(widget.category.id);
                                          },
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
                                                'Delete Stock',
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
                            );
                          })),
            )
          ]),
        ),
      ),
    );
  }
}
