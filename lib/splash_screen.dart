import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth/pages/dashboard.dart';
import 'package:phone_auth/pages/loginpage.dart';
import 'package:lottie/lottie.dart';

import 'base/bottomnav.dart';
import 'newpages/new_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  checkData() async {
    var userMail = await box.read('email');

    if (userMail == null) {
      Get.to(() => LoginPage());
    } else {
      Get.to(() => BottomNavPage());
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () => checkData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.150,
          ),
          // LottieBuilder.asset("assets/files/mylotie.json"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: screenWidth,
            ),
          ),
          Text(
            "Wecome to Digital dhopa shop",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.050,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Fresh Clothes",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    ));
  }
}
