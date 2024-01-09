import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendorapp/interface/utils/constants/fixed_constants.dart';
import 'package:vendorapp/interface/utils/constants/models/category.dart';
import 'package:vendorapp/interface/utils/constants/paddings.dart';
import 'package:vendorapp/interface/utils/constants/text_cosntants.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';

import '../../utils/constants/toast.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Vendor? vendor;
  bool isUpdating = false;
  String pickedImagebytes = '';

  UserController userController = Get.find<UserController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendor = userController.vendor!;
    userController.getALlUserItems();
    nameController.text = vendor!.name;
    emailController.text = vendor!.email;
    descController.text = vendor!.desc;
    contactController.text = vendor!.contact;
  }

  bool isEditEnabled = false;
  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<UserController>(builder: (controller) {
          return Center(
            child: Container(
              height: s.height,
              width: s.width,
              color: primaryColor,
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        fixedVerticalSpace(20.h),
                        CustomText.normalText('Profile', color: Colors.white),
                        fixedVerticalSpace(20.h),
                        SizedBox(
                          height: s.height * 0.8,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: s.height * 0.75,
                                  width: s.width,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))),
                                  child: Padding(
                                    padding:
                                        AppPaddings.horizontalSymmetricPadding,
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            fixedVerticalSpace(100.h),
                                            isUpdating
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child:
                                                        LinearProgressIndicator(
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            isEditEnabled
                                                ? MaterialButton(
                                                    enableFeedback: !controller
                                                        .isVendorLoading.value,
                                                    height: 50.h,
                                                    minWidth: double.infinity,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                smallBorderRadius)),
                                                    color: primaryColor,
                                                    child:
                                                        CustomText.normalText(
                                                            'Save changes',
                                                            color:
                                                                Colors.white),
                                                    onPressed: () async {
                                                      if (nameController
                                                              .text.length <
                                                          3) {
                                                        showToastShort(
                                                            'name too short',
                                                            Colors.yellow);
                                                        return;
                                                      }
                                                      if (descController
                                                          .text.isEmpty) {
                                                        showToastShort(
                                                            'description not valid',
                                                            Colors.yellow);
                                                        return;
                                                      }

                                                      if (emailController
                                                          .text.isEmpty) {
                                                        showToastShort(
                                                            'not valid email',
                                                            Colors.yellow);
                                                        return;
                                                      }
                                                      if (emailController
                                                              .text.length <
                                                          10) {
                                                        showToastShort(
                                                            'not valid email',
                                                            Colors.yellow);
                                                        return;
                                                      } else {
                                                        if (contactController
                                                                .text.length <
                                                            11) {
                                                          showToastShort(
                                                              'not valid contact',
                                                              Colors.yellow);
                                                          return;
                                                        } else {
                                                          setState(() {
                                                            isUpdating = true;
                                                          });
                                                          await userController.updateVendor(Vendor(
                                                              name:
                                                                  nameController
                                                                      .text,
                                                              id: vendor!.id,
                                                              image:
                                                                  pickedImagebytes,
                                                              desc:
                                                                  descController
                                                                      .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              contact:
                                                                  contactController
                                                                      .text));
                                                          setState(() {
                                                            isEditEnabled =
                                                                false;
                                                            isUpdating = false;
                                                          });
                                                        }
                                                      }
                                                    })
                                                : const SizedBox(),
                                            isEditEnabled
                                                ? fixedVerticalSpace(20.h)
                                                : const SizedBox(),
                                            ListTile(
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              title:
                                                  const Text('Profile Details'),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isEditEnabled =
                                                          !isEditEnabled;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                            ),
                                            fixedVerticalSpace(20.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child:
                                                  CustomText.smallText('Name'),
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          smallBorderRadius)),
                                              child: SizedBox(
                                                height: 65.h,
                                                width: double.infinity,
                                                // decoration: BoxDecoration(
                                                //     color: Colors.white,
                                                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                                                child: Padding(
                                                  padding: AppPaddings
                                                      .horizontalSymmetricPadding,
                                                  child: Center(
                                                    child: TextFormField(
                                                      enabled: isEditEnabled,
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText: 'Name'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            fixedVerticalSpace(20.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: CustomText.smallText(
                                                  'Description'),
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          smallBorderRadius)),
                                              child: SizedBox(
                                                height: 100.h,
                                                width: double.infinity,
                                                // decoration: BoxDecoration(
                                                //     color: Colors.white,
                                                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                                                child: Padding(
                                                  padding: AppPaddings
                                                      .horizontalSymmetricPadding,
                                                  child: Center(
                                                    child: TextFormField(
                                                      enabled: isEditEnabled,
                                                      controller:
                                                          descController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Description'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            fixedVerticalSpace(20.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child:
                                                  CustomText.smallText('Email'),
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          smallBorderRadius)),
                                              child: SizedBox(
                                                height: 65.h,
                                                width: double.infinity,
                                                // decoration: BoxDecoration(
                                                //     color: Colors.white,
                                                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                                                child: Padding(
                                                  padding: AppPaddings
                                                      .horizontalSymmetricPadding,
                                                  child: Center(
                                                    child: TextFormField(
                                                      enabled: isEditEnabled,
                                                      controller:
                                                          emailController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Email'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            fixedVerticalSpace(20.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: CustomText.smallText(
                                                  'Phone number'),
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          smallBorderRadius)),
                                              child: SizedBox(
                                                height: 65.h,
                                                width: double.infinity,
                                                // decoration: BoxDecoration(
                                                //     color: Colors.white,
                                                //     borderRadius: BorderRadius.circular(medBorderRadius)),
                                                child: Padding(
                                                  padding: AppPaddings
                                                      .horizontalSymmetricPadding,
                                                  child: Center(
                                                    child: TextFormField(
                                                      enabled: isEditEnabled,
                                                      controller:
                                                          contactController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Contact'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // fixedVerticalSpace(10.h),
                                            fixedVerticalSpace(20.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: CustomText.smallText(
                                                  'Ingredients',
                                                  fontSize: 18),
                                            ),

                                            SizedBox(
                                              height: s.height * 0.2,
                                              width: double.infinity,
                                              // color: Colors.green,
                                              child: GetBuilder<UserController>(
                                                builder: (controller) {
                                                  return controller
                                                          .userCategory.isEmpty
                                                      ? const Text(
                                                          'No ingredients to show')
                                                      : GridView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: controller
                                                              .userCategory
                                                              .length,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  childAspectRatio:
                                                                      0.7,
                                                                  crossAxisCount:
                                                                      2),
                                                          itemBuilder:
                                                              (context, ind) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  children: [
                                                                    Chip(
                                                                        backgroundColor: Colors
                                                                            .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                20),
                                                                            side: BorderSide(
                                                                                color:
                                                                                    primaryColor)),
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        labelPadding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                10,
                                                                            left:
                                                                                5),
                                                                        label: CustomText.normalText(
                                                                            controller.userCategory[ind].name,
                                                                            color: Colors.orange.shade800)),
                                                                    !isEditEnabled
                                                                        ? const SizedBox()
                                                                        : Align(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child: IconButton(
                                                                                onPressed: () {
                                                                                  controller.delItem(controller.userCategory[ind].id);
                                                                                  setState(() {});
                                                                                },
                                                                                icon: const CircleAvatar(
                                                                                  radius: 10,
                                                                                  backgroundColor: Colors.white,
                                                                                  child: Icon(
                                                                                    Icons.close_rounded,
                                                                                    size: 14,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                )),
                                                                          )
                                                                  ]),
                                                            );
                                                          });
                                                },
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (isEditEnabled) {
                                    XFile? picked = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (picked == null) {
                                      return;
                                    } else {
                                      String imgBytes = base64Encode(
                                          await picked.readAsBytes());
                                      setState(() {
                                        pickedImagebytes = imgBytes;
                                      });
                                    }
                                  } else {
                                    print(userController.vendor!.image);
                                  }
                                },
                                child: userController.vendor!.image == '' &&
                                        pickedImagebytes == ''
                                    ? CircleAvatar(
                                        radius: 50.h,
                                        child: const Icon(Icons.person),
                                      )
                                    : pickedImagebytes != ''
                                        ? CircleAvatar(
                                            radius: 50.h,
                                            child: Image.memory(
                                              base64Decode(pickedImagebytes),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 50.h,
                                            child: Image.memory(
                                              base64Decode(
                                                  userController.vendor!.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
