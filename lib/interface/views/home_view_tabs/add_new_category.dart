import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendorapp/interface/utils/themes/app_theme.dart';
import 'package:vendorapp/interface/views/home_view_tabs/add_category_tabs/add_ingred_tab.dart';

import 'add_category_tabs/add_category_tab.dart';

class AddNewCategoryView extends StatefulWidget {
  const AddNewCategoryView({super.key});

  @override
  State<AddNewCategoryView> createState() => _AddNewCategoryViewState();
}

class _AddNewCategoryViewState extends State<AddNewCategoryView> {
  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Category'),
      const Tab(text: 'Ingredient'),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              )),
          backgroundColor: Colors.white70,
          title: const Text(
            "Add New",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: primaryColor,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(children: [
          AddCategoryView(),
          AddIngredView(),
        ]),
      ),
    );
  }
}
