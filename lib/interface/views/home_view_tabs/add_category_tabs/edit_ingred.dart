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

class EditIngredView extends StatefulWidget {
  const EditIngredView({super.key, required this.item});
  final ItemModel item;
  @override
  State<EditIngredView> createState() => _EditIngredViewState();
}

class _EditIngredViewState extends State<EditIngredView> {
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
    titleController.text = widget.item.name;
    priceController.text = widget.item.price.toString();
    qController.text = '100';
    minController.text = '100';
    if (userController.categories.isNotEmpty) {
      setState(() {
        _drpDownValue = userController.categories
            .where((element) => element.id == widget.item.catId)
            .first;
        selectedCatID = userController.categories
            .where((element) => element.id == widget.item.catId)
            .first
            .id;
      });
    }
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
        title: CustomText.normalText('Update Item'),
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
                              const InputDecoration(hintText: 'Item title'),
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
                          _drpDownValue!.title ?? 'Select category',
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        value: _drpDownValue,
                        items: userController.categories
                            .map((CategoryModel value) {
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
                          controller: minController,
                          decoration: const InputDecoration(
                              hintText: 'Minimum stock quantity limitation'),
                        ),
                      ),
                    ),
                  ),
                ),
                fixedVerticalSpace(s.height * 0.2.h),
                MaterialButton(
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

                      if (minController.text.isEmpty) {
                        showToastShort(
                            'not valid minimum limit', Colors.yellow);
                        return;
                      } else {
                        userController.updateItem(
                            titleController.text,
                            selectedCatID,
                            widget.item.id,
                            qController.text,
                            priceController.text);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
