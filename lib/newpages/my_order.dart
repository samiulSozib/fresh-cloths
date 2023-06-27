import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'order_details.page.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth,
              child: Center(
                child: Text(
                  "All Order List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("AllUserOrders")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mydata = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => OrderDetailsPage());
                              },
                              child: Container(
                                height: 500,
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  // color: Colors.grey,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: screenWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Name : " + mydata["name"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  "Date : " + mydata["date"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "ID : " + mydata["orderID"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  "Phone No : " +
                                                      mydata["phone"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Location : " +
                                                      mydata["location"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  mydata["orderStatus"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.040,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "H- " + mydata["house"] + ",",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  "Rd- " + mydata["road"] + ",",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  "Block- " + mydata["block"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 1,
                                              width: screenWidth,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Text("SL"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    child: Text("Product Name"),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    children: [
                                                      Text("Quantity")
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [Text("Price")],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 1,
                                              width: screenWidth,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        width: screenWidth,
                                        // color: Colors.blue.shade100,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: mydata["cart"].length,
                                          itemBuilder: (context, cartindex) {
                                            int myindex = cartindex + 1;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      myindex.toString() + "."),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: Text(mydata["cart"]
                                                                  [cartindex]
                                                              ["name"]
                                                          .toString()),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Text(mydata["cart"]
                                                                    [cartindex]
                                                                ["quantity"]
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(mydata["cart"]
                                                                    [cartindex]
                                                                ["price"]
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total Qnty: ${mydata["totalQuantity"]}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Total Price: ${mydata["totalPrice"]} /=tk",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
