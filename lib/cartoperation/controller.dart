import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/newpages/new_dashboard.dart';

class CartController extends GetxController {
  final box = GetStorage();

  var points1 = <String>[].obs;

  var isLoading = false.obs;

  var isFetching = false.obs;

  var isUploading = false.obs;

  RxInt totalPrice = 0.obs;

  var allList;

  var user_id;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isFetching.value = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("draft_user_cart")
        .where('id', isEqualTo: box.read("userKey").toString())
        .get();

    allList = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allList.length; i++) {
      totalPrice = totalPrice + int.parse(allList[i]["finalprice"].toString());
    }

    isFetching.value = false;
  }

  List<String> toList1() {
    allList.forEach((item) {
      points1.add(item.toString());
    });

    return points1.toList();
  }

  Future<void> saveCartData() async {
    isUploading.value = true;

    print(toList1());

    try {
      await FirebaseFirestore.instance.collection('my_cart').add({
        "cart": toList1(),
      });
      isUploading.value = false;
      Get.snackbar(
        "Status",
        "Your data has been saved",
        colorText: Colors.white,
        backgroundColor: Colors.blueGrey,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.to(() => NewUserDashBoard());
    } catch (e) {
      isUploading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong ..... try again",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
