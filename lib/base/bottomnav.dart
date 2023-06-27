import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth/admin/admin_dashboard.dart';

import '../newpages/my_order.dart';
import '../newpages/mydemo.dart';
import '../newpages/new_dashboard.dart';
import '../newpages/view_my_cart.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  List pages = [
    NewUserDashBoard(),
    ViewMyCart(),
    MyDemoPAGE(),
  ];

  int selectedIndex = 0;
  final auth = FirebaseAuth.instance;

  final database = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          extendBody: true,
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: screenHeight * 0.070,
                  // ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('User-info')
                        .where("uid", isEqualTo: auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      box.write("userKey", auth.currentUser!.uid.toString());
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            var finalData = snapshot.data!.docs[i];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: screenHeight * .10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3498db),
                                    ),
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      height: 150,
                                      width: screenWidth,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.020,
                                  ),
                                  Text(
                                    "Name : " + finalData["name"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Text(
                                  //     "Mail Name:  ${auth.currentUser!.displayName}"),
                                  Text(
                                    "Phone : " + finalData["phone"],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Email : ${auth.currentUser!.email}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blue,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Update Profile",
                                              style: GoogleFonts.acme(
                                                fontSize: screenHeight * 0.022,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.010,
                  ),

                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(AdminDashboard());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Admin Area",
                                  style: GoogleFonts.acme(
                                    fontSize: screenHeight * 0.022,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.white,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.white,
            // centerTitle: true,
            title: Row(
              children: [
                Text(
                  "Fresh",
                  style: GoogleFonts.robotoSlab(
                    fontSize: screenWidth * 0.060,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3498db),
                  ),
                ),
                Text(
                  "Clothes",
                  style: GoogleFonts.robotoSlab(
                    fontSize: screenWidth * 0.040,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.sort,
                    color: Colors.black,
                    size: screenWidth * 0.080,
                  ));
            }),
            elevation: 0.0,
          ),
          body: pages[selectedIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: selectedIndex,

            backgroundColor: Colors.transparent,
            // height: 70,
            color: Color(0xff3498db),
            items: [
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                CupertinoIcons.shopping_cart,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                CupertinoIcons.person,
                size: 30,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          )),
    );
  }
}
