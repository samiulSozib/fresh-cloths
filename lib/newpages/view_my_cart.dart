import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/helpers/database_helper.dart';
import 'package:phone_auth/model/cart_model.dart';
import 'package:phone_auth/newpages/new_dashboard.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'new_products_page.dart';

class ViewMyCart extends StatefulWidget {
  const ViewMyCart({super.key});

  @override
  State<ViewMyCart> createState() => _ViewMyCartState();
}

class _ViewMyCartState extends State<ViewMyCart> {
  DateTime now = DateTime.now();
  late Future<List<CartItem>> cartList;
  late double _total_price = 0.0;
  late int _total_qnt = 0;
  var isUploading = false.obs;
  var allList;
  var points1 = <String>[].obs;
  //late Future<Object> total_price;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController houseController = TextEditingController();

  @override
  void initState() {
    _updateCartList();
    _updateTotalPriceAndItem();

    super.initState();
  }

  Future<void> _updateTotalPriceAndItem() async {
    final total_price = (await CartDatabase.instance.getTotalPrice());
    final total_qnt = await CartDatabase.instance.totalItems();
    print(total_price);
    setState(() {
      _total_price = total_price;
      _total_qnt = total_qnt;
    });
  }

  _updateCartList() {
    setState(() {
      cartList = CartDatabase.instance.getItems();
    });
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cartList,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: 1 + snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 40,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            "My Cart List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${snapshot.data![index - 1].name}"),
                              Text(
                                  "${(snapshot.data![index - 1].quantity) * (snapshot.data![index - 1].price)}"),
                              Text("${snapshot.data![index - 1].quantity}"),
                              Text("${snapshot.data![index - 1].price}"),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _deleteItem(snapshot.data![index - 1].id);
                                    _updateCartList();
                                    _updateTotalPriceAndItem();
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            width: screenWidth,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Text("Totoal Quantity: ${_total_qnt}"),
                  Spacer(),
                  Text("Total Price: ${_total_price}"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enter Your Address",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Full Name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: locationController,
                              decoration: InputDecoration(
                                hintText: "Location Name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: blockController,
                              decoration: InputDecoration(
                                hintText: "Block",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: roadController,
                              decoration: InputDecoration(
                                hintText: "Road No",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 40,
                            width: screenWidth,
                            color: Colors.grey,
                            child: TextField(
                              controller: houseController,
                              decoration: InputDecoration(
                                hintText: "House No",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (nameController.text.isNotEmpty &&
                                      phoneController.text.isNotEmpty &&
                                      roadController.text.isNotEmpty &&
                                      blockController.text.isNotEmpty &&
                                      houseController.text.isNotEmpty &&
                                      locationController.text.isNotEmpty) {
                                    _submitData();
                                    CartDatabase.instance.clearTable();
                                  } else {
                                    print("enter data");
                                  }
                                },
                                child: Text("Place Order Now"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 50,
              width: screenWidth,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(child: Text("Continue")),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  _submitData() async {
    // print(await CartDatabase.instance.items());

    Random random = Random();
    int min = 100;
    int max = 999;
    var randomNumber = min + random.nextInt(max - min);

    var myuniqueID = phoneController.text + randomNumber.toString();
    //   List<String> mynewlist = [];
    //  var finalList = mynewlist.add(myuniqueID);

    final List<String> myorderid = [myuniqueID];

    var mylist = await CartDatabase.instance.items();

    try {
      await FirebaseFirestore.instance.collection("AllUserOrders").doc().set({
        "cart": mylist,
        "date":
            "${DateFormat.d().format(now)}-${DateFormat.MMMM().format(now)}-${DateFormat.y().format(now)}",
        "name": nameController.text,
        "phone": phoneController.text,
        "location": locationController.text,
        "block": blockController.text,
        "road": roadController.text,
        "house": houseController.text,
        "userID": box.read("userKey"),
        "orderID": myuniqueID,
        "orderStatus": "pending",
        "totalQuantity": _total_qnt,
        "totalPrice": _total_price,
      }).then((_) {
        FirebaseFirestore.instance
            .collection("PersonalOrderIdList")
            .doc(box.read("userKey"))
            .collection("list")
            .add({"myordersid": myuniqueID});
      });

      // await FirebaseFirestore.instance
      //     .collection("allorderlist")
      //     .doc(box.read("userKey"))
      //     .set({
      //   "cart": mylist,
      //   "name": nameController.text,
      //   "phone": phoneController.text,
      //   "location": locationController.text,
      //   "block": blockController.text,
      //   "road": roadController.text,
      //   "house": houseController.text,
      //   "uerID": box.read("userKey"),
      //   "orderStatus": "pending",
      //   "totalQuantity": _total_qnt,
      //   "totalPrice": _total_price,
      // });

      // await FirebaseFirestore.instance.collection('allorders').add({
      //   "cart": mylist,
      //   "name": nameController.text,
      //   "phone": phoneController.text,
      //   "location": locationController.text,
      //   "block": blockController.text,
      //   "road": roadController.text,
      //   "house": houseController.text,
      //   "uerID": box.read("userKey"),
      //   "orderStatus": "pending",
      //   "totalQuantity": _total_qnt,
      //   "totalPrice": _total_price,
      // });

      isUploading.value = false;
      Get.snackbar(
        "Status",
        "Your data has been saved",
        colorText: Colors.white,
        backgroundColor: Colors.blueGrey,
        snackPosition: SnackPosition.BOTTOM,
      );
      await CartDatabase.instance.clearTable();

      Get.to(() => NewUserDashBoard());
    } catch (e) {
      isUploading.value = false;
      print(e);
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

_deleteItem(int? id) async {
  await CartDatabase.instance.removeItem(id!);
}
