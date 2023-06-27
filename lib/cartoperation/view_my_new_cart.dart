import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/cartoperation/controller.dart';

class ViewMyNewCart extends StatelessWidget {
  const ViewMyNewCart({super.key});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final CartController controller = Get.put(CartController());
    return SafeArea(
        child: Scaffold(
      body: Container(
          height: screenheight,
          width: screenWidth,
          child: Obx(() => controller.isFetching.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.allList.length == 0
                  ? Center(
                      child: Text("No Data Found"),
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "SL",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                        ),
                                      ),
                                      Container(
                                        height: screenheight,
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "P. Name",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                        ),
                                      ),
                                      Container(
                                        height: screenheight,
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "Qn",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                        ),
                                      ),
                                      Container(
                                        height: screenheight,
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "Price",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              flex: 15,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: controller.allList.length,
                                itemBuilder: (context, index) {
                                  int slNo = index + 1;
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Color(0xfff8f8f8)
                                          : Color(0xffefefef),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    slNo.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: Center(
                                                    child: Text(controller
                                                        .allList[index]
                                                            ["productName"]
                                                        .toString())),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Center(
                                                    child: Text(controller
                                                        .allList[index]
                                                            ["quantity"]
                                                        .toString())),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    controller.allList[index]
                                                                ["finalprice"]
                                                            .toString() +
                                                        "  ৳ ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total Price : " +
                                            controller.totalPrice.toString() +
                                            "৳ ",
                                        style: TextStyle(
                                          fontSize: screenheight * 0.022,
                                        ),
                                      ),
                                      Spacer(),
                                      VerticalDivider(
                                        indent: 20,
                                        endIndent: 20,
                                        thickness: 2,
                                        color: Colors.grey,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.saveCartData();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.amber,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "  Send  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenheight * 0.018,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() => controller.isUploading.value == true
                            ? Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            : Container())
                      ],
                    ))),
    ));
  }
}
