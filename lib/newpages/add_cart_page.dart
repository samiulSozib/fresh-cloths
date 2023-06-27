import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/helpers/database_helper.dart';
import 'package:phone_auth/model/cart_model.dart';

import 'view_my_cart.dart';

class AddCartPage extends StatefulWidget {
  String? productName;
  String? price;

  AddCartPage({
    required this.productName,
    required this.price,
  });

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  // double totalPrice = 0.0;

  final box = GetStorage();

  int counter = 0;
  int finalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Add cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.10,
              width: screenWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                width: 1,
                color: Colors.black,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.productName.toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.price.toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              finalPrice.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (counter > 0) {
                        counter--;
                        finalPrice =
                            counter * int.parse(widget.price.toString());
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.remove,
                        size: screenHeight * 0.050,
                      ),
                    ),
                  ),
                ),
                Text(
                  counter.toString(),
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      counter++;
                      finalPrice = counter * int.parse(widget.price.toString());

                      print(finalPrice);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.add,
                        size: screenHeight * 0.050,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (counter <= 0) {
                    print("add at least one");
                  } else {
                    _submitData(widget.productName, counter, widget.price);
                    // print(CartDatabase.instance.getTotalPrice().toString());
                  }
                },
                child: Text("Add to cart")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                Get.to(() => ViewMyCart());
              },
              child: Text("View My cart"),
            ),
          ],
        ),
      ),
    ));
  }

  _submitData(String? productName, int i, String? price) async {
    final item = CartItem(
        name: productName.toString(),
        price: double.parse(price.toString()),
        quantity: i);

    await CartDatabase.instance.addItem(item);
    await box.write("allprice", await CartDatabase.instance.getTotalPrice());

    print(await CartDatabase.instance.getTotalPrice());
  }
}
