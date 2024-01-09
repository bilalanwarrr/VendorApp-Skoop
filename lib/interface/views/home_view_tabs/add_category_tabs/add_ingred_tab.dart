import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
// import 'package:vendorapp/data/models/category.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/constants/text_cosntants.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';

import '../../../utils/constants/models/category.dart';
import '../../../utils/constants/toast.dart';

class AddIngredView extends StatefulWidget {
  const AddIngredView({super.key});

  @override
  State<AddIngredView> createState() => _AddIngredViewState();
}

class _AddIngredViewState extends State<AddIngredView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController minController = TextEditingController();
  TextEditingController qController = TextEditingController();

  UserController userController = Get.find<UserController>();

  CategoryModel? _drpDownValue;
  String selectedCatID = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userController.categories.isNotEmpty) {
      setState(() {
        _drpDownValue = userController.categories.first;
        selectedCatID = userController.categories.first.id;
      });
    }
  }

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
                      decoration: const InputDecoration(hintText: 'Item title'),
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
                      child: DropdownButton<CategoryModel>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: CustomText.normalText(
                      _drpDownValue?.title ?? 'Select category',
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    value: _drpDownValue,
                    items: userController.categories.map((CategoryModel value) {
                      return DropdownMenuItem<CategoryModel>(
                        value: value,
                        child: Text(value.title),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedCatID = v!.id;
                        _drpDownValue = v;
                      });
                    },
                  )),
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
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Price'),
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
                      keyboardType: TextInputType.number,
                      controller: qController,
                      decoration: const InputDecoration(
                          hintText: 'Minimum stock quantity limitation'),
                    ),
                  ),
                ),
              ),
            ),
            fixedVerticalSpace(s.height * 0.2.h),
            MaterialButton(
                enableFeedback: userController.categories.isNotEmpty,
                height: 50.h,
                minWidth: s.width * 0.9.h,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius)),
                color: primaryColor,
                child: userController.isItemLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomText.normalText('Add Ingredient',
                        color: Colors.white),
                onPressed: () async {
                  if (titleController.text.length < 3) {
                    showToastShort('Title too short', Colors.yellow);
                    return;
                  }
                  if (priceController.text.isEmpty) {
                    showToastShort('price not valid', Colors.yellow);
                    return;
                  }

                  if (qController.text.isEmpty) {
                    showToastShort('not valid minimum limit', Colors.yellow);
                    return;
                  } else {
                    userController.addItem(titleController.text,
                        priceController.text, qController.text, selectedCatID);
                  }
                })
          ],
        ),
      ),
    );
  }
}
