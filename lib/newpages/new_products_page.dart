import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth/model/cart_model.dart';
import 'package:phone_auth/newpages/add_cart_page.dart';

import '../cartoperation/set_new_cart_page.dart';
import '../helpers/database_helper.dart';

class NewProductpage extends StatefulWidget {
  const NewProductpage({super.key});

  @override
  State<NewProductpage> createState() => _NewProductpageState();
}

class _NewProductpageState extends State<NewProductpage> {
  var _cartList;
  int _quantity = 0;
  // @override
  // initState() {
  //   setState(() {
  //     _cartList = DatabaseHelper.instance.getCartMapList();
  //   });

  //   _cartList.forEach((row) => print(row));

  //   super.initState();
  // }

  int selectedIndex = 0;
  final auth = FirebaseAuth.instance;

  final database = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      extendBody: true,
      // drawer: Drawer(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // SizedBox(
      //         //   height: screenHeight * 0.070,
      //         // ),
      //         StreamBuilder(
      //           stream: FirebaseFirestore.instance
      //               .collection('User-info')
      //               .where("uid", isEqualTo: auth.currentUser!.uid)
      //               .snapshots(),
      //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //             box.write("userKey", auth.currentUser!.uid.toString());
      //             if (snapshot.hasData) {
      //               return ListView.builder(
      //                 shrinkWrap: true,
      //                 itemCount: snapshot.data!.docs.length,
      //                 itemBuilder: (context, i) {
      //                   var finalData = snapshot.data!.docs[i];
      //                   return Padding(
      //                     padding: const EdgeInsets.all(15.0),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Container(
      //                           height: screenHeight * .10,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10),
      //                             color: Color(0xff3498db),
      //                           ),
      //                           child: Image.asset(
      //                             "assets/images/logo.png",
      //                             height: 150,
      //                             width: screenWidth,
      //                           ),
      //                         ),
      //                         Divider(
      //                           thickness: 2,
      //                           color: Colors.white,
      //                         ),
      //                         SizedBox(
      //                           height: screenHeight * 0.020,
      //                         ),
      //                         Text(
      //                           "Name : " + finalData["name"],
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                             color: Colors.black,
      //                           ),
      //                         ),
      //                         // Text(
      //                         //     "Mail Name:  ${auth.currentUser!.displayName}"),
      //                         Text(
      //                           "Phone : " + finalData["phone"],
      //                           style: TextStyle(
      //                             fontSize: 15,
      //                             color: Colors.black,
      //                           ),
      //                         ),
      //                         Text(
      //                           "Email : ${auth.currentUser!.email}",
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                             color: Colors.black,
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           height: 15,
      //                         ),
      //                         Row(
      //                           // mainAxisAlignment: MainAxisAlignment.end,
      //                           children: [
      //                             Container(
      //                                 decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   color: Colors.blue,
      //                                 ),
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.all(8.0),
      //                                   child: Text(
      //                                     "Update Profile",
      //                                     style: GoogleFonts.acme(
      //                                       fontSize: screenHeight * 0.022,
      //                                       color: Colors.white,
      //                                     ),
      //                                   ),
      //                                 )),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //               );
      //             } else {
      //               return CircularProgressIndicator();
      //             }
      //           },
      //         ),
      //         SizedBox(
      //           height: screenHeight * 0.010,
      //         ),
      //         Divider(
      //           thickness: 2,
      //           color: Colors.grey,
      //         ),
      //         Spacer(),
      //         Row(
      //           children: [
      //             Container(
      //               // width: screenWidth * 0.350,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(20),
      //                 color: Colors.blue,
      //               ),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(12.0),
      //                 child: Row(
      //                   children: [
      //                     Icon(
      //                       Icons.logout,
      //                       size: 30,
      //                       color: Colors.white,
      //                     ),
      //                     SizedBox(
      //                       width: 10,
      //                     ),
      //                     Text(
      //                       "Log Out",
      //                       style: GoogleFonts.acme(
      //                         fontSize: screenHeight * 0.022,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     // Status bar color
      //     statusBarColor: Colors.white,

      //     // Status bar brightness (optional)
      //     statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //     statusBarBrightness: Brightness.light, // For iOS (dark icons)
      //   ),
      //   backgroundColor: Colors.white,
      //   // centerTitle: true,
      //   title: Row(
      //     children: [
      //       Text(
      //         "Fresh",
      //         style: GoogleFonts.robotoSlab(
      //           fontSize: screenWidth * 0.060,
      //           fontWeight: FontWeight.w600,
      //           color: Color(0xff3498db),
      //         ),
      //       ),
      //       Text(
      //         "Clothes",
      //         style: GoogleFonts.robotoSlab(
      //           fontSize: screenWidth * 0.040,
      //           fontWeight: FontWeight.w600,
      //           color: Colors.grey,
      //         ),
      //       ),
      //     ],
      //   ),
      //   leading: Builder(builder: (context) {
      //     return IconButton(
      //         onPressed: () => Scaffold.of(context).openDrawer(),
      //         icon: Icon(
      //           Icons.sort,
      //           color: Colors.black,
      //           size: screenWidth * 0.080,
      //         ));
      //   }),
      //   elevation: 0.0,
      // ),

      // drawer: Drawer(),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text("All Mens Items"),
      //   actions: [
      //     Icon(
      //       Icons.shopping_cart,
      //       size: 30,
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(top: 10, right: 10),
      //       child: Text("150"),
      //     )
      //   ],
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Mens-Items")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => AddCartPage(
                                  productName: snapshot
                                      .data!.docs[index]["productName"]
                                      .toString(),
                                  price: snapshot.data!.docs[index]["price"]
                                      .toString(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 80,
                                        child: Image.asset(
                                            "assets/images/mens_cat.png"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 80,
                                        // color: Colors.grey,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ["productName"],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "BDT : ${snapshot.data!.docs[index]["price"]}.00",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
