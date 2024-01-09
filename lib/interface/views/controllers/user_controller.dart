import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:vendorapp/interface/utils/constants/models/category.dart';

import '../../utils/constants/constants.dart';
import '../../utils/constants/toast.dart';

class UserController extends GetxController {
  Rx<String> email = Rx('');
  // Rx<String> contact = Rx('');
  Rx<String> token = Rx('');
  Vendor? vendor;
  List<CategoryModel> categories = [];
  List<ItemModel> itemsOfCategory = [];
  List<ItemModel> userCategory = [];

  RxBool isCategoryLoading = false.obs;
  RxBool isItemLoading = false.obs;
  RxBool isVendorLoading = false.obs;

  getVendorProfile() async {
    try {
      isVendorLoading.value = true;
      http.Response response = await http.get(
        Uri.parse('$port/get-vendor'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      isVendorLoading.value = false;
      Map decoded = jsonDecode(response.body);
      vendor = Vendor(
          name: decoded['vendor']['name'],
          image: decoded['vendor']['picture'] ?? '',
          id: decoded['vendor']['_id'],
          desc: decoded['vendor']['description'],
          email: decoded['vendor']['email'],
          contact: decoded['vendor']['phone_number']);

      print(vendor?.id);
    } catch (e) {
      isVendorLoading.value = false;
      print(e.toString());
    }
    update();
  }

  getCategories() async {
    try {
      categories.clear();
      isCategoryLoading.value = true;
      http.Response response = await http.get(
        Uri.parse('$port/viewStockCategory'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      print(response.statusCode);
      isCategoryLoading.value = false;
      Map decoded = jsonDecode(response.body);
      List res = decoded['stockCategories'] as List;
      for (Map e in res) {
        if (!e.containsKey('stockProduct_category')) {
          categories.add(CategoryModel(
              e['title'], e['description'], e['_id'], e['image']));
        }
      }
      print(response.body);
    } catch (e) {
      isCategoryLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
    update();
  }

  addCategory(String name, String desc, XFile imgFile) async {
    try {
      String imgBytes = base64Encode(await imgFile.readAsBytes());
      isCategoryLoading.value = true;
      http.Response response = await http
          .post(Uri.parse('$port/addStockcategory'), headers: {
        'Authorization': 'Bearer ${token.value}'
      }, body: {
        'title': name,
        'description': desc,
        "name": name,
        "image": imgBytes
      });
      isCategoryLoading.value = false;
      print(response.body);
      showToastShort('Added', Colors.green);
      getCategories();
    } catch (e) {
      isCategoryLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
  }

  updateCategory(String name, String id, String desc, XFile imgFile) async {
    try {
      String imgBytes = base64Encode(await imgFile.readAsBytes());
      isCategoryLoading.value = true;
      http.Response response = await http
          .patch(Uri.parse('$port/editStockCategory/$id'), headers: {
        'Authorization': 'Bearer ${token.value}'
      }, body: {
        'title': name,
        'description': desc,
        "name": name,
        "image": imgBytes
      });
      isCategoryLoading.value = false;
      print(response.body);
      showToastShort('Updated', Colors.green);
      getCategories();
    } catch (e) {
      isCategoryLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
  }

  updateVendor(Vendor vendor) async {
    print('image:${vendor.image}');
    try {
      isVendorLoading.value = true;
      http.Response response =
          await http.patch(Uri.parse('$port/edit-vendor'), headers: {
        'Authorization': 'Bearer ${token.value}'
      }, body: {
        'name': vendor.name,
        'description': vendor.desc,
        "phone_number": vendor.contact,
        "email": vendor.email,
        "address": "",
        "picture": vendor.image
      });
      isVendorLoading.value = false;
      print(response.body);
      showToastShort('Updated', Colors.green);
      getVendorProfile();
    } catch (e) {
      isVendorLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
  }

  updateItem(
      String name, String catId, String itemId, String q, String price) async {
    try {
      // String imgBytes = base64Encode(await imgFile.readAsBytes());
      isItemLoading.value = true;
      http.Response response = await http
          .patch(Uri.parse('$port/editStockProduct/$itemId'), headers: {
        'Authorization': 'Bearer ${token.value}'
      }, body: {
        'name': name,
        'price': price,
        "stockProduct_category": catId,
        "quantity": q,
        "desc": "N/A"
        // "image": imgBytes
      });
      isItemLoading.value = false;
      print(response.body);
      showToastShort('Updated', Colors.green);
      getALlUserItems();
    } catch (e) {
      isItemLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
  }

  getItems(String catid) async {
    try {
      itemsOfCategory.clear();
      isItemLoading.value = true;
      http.Response response = await http.get(
        Uri.parse('$port/viewStockProduct'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      isItemLoading.value = false;
      Map decoded = jsonDecode(response.body);
      List res = decoded['stockProducts'] as List;
      print(res);
      for (Map e in res) {
        if (e.containsKey('stockProduct_category')) {
          if (catid == e['stockProduct_category']) {
            itemsOfCategory.add(ItemModel(e['name'] ?? '',
                e['stockProduct_category'] ?? '', e['_id'], e['price'] ?? 0));
          }
        }
      }
      print(response.body);
    } catch (e) {
      isItemLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
    update();
  }

  getALlUserItems() async {
    try {
      userCategory.clear();
      isItemLoading.value = true;
      http.Response response = await http.get(
        Uri.parse('$port/viewStockProduct'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      isItemLoading.value = false;
      Map decoded = jsonDecode(response.body);
      List res = decoded['stockProducts'] as List;
      for (Map e in res) {
        if (e.containsKey('stockProduct_category')) {
          userCategory.add(ItemModel(e['name'] ?? '',
              e['stockProduct_category'] ?? '', e['_id'], e['price'] ?? 0));
        }
      }
      print(response.body);
    } catch (e) {
      isItemLoading.value = false;
      print(e.toString());
      showToastShort("Server Error", Colors.red);
    }
    update();
  }

  addItem(String title, String price, String q, String catId) async {
    
    // try {
    isItemLoading.value = true;
    http.Response response = await http.post(Uri.parse('$port/addStockProduct'),
        headers: {
          'Authorization': 'Bearer ${token.value}'
        },
        body: {
          "name": title,
          "stockProduct_category": catId,
          "price": price,
          "quantity": q
        });

    isItemLoading.value = false;
    getItems(catId);

    showToastShort('Added', Colors.green);
  }

  delCategory(String id) async {
    try {
      await http.delete(
        Uri.parse('$port/deleteStockCategory/$id'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      showToastShort('Deleted', Colors.green);
      getCategories();
    } catch (e) {
      print(e);
    }
  }

  delItem(String id) async {
    try {
      await http.delete(
        Uri.parse('$port/deleteStockProduct/$id'),
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
      showToastShort('Deleted', Colors.green);
      getALlUserItems();
    } catch (e) {
      print(e);
    }
  }
}
