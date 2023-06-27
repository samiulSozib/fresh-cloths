import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth/pages/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../base/bottomnav.dart';
import '../newpages/new_dashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController phoneController = TextEditingController();

  // Future sendData() async {
  //   final db = await FirebaseFirestore.instance.collection("User-info").add({
  //     "mailAddress": "",
  //     "Name": "",
  //     "address": "",
  //     "phoneNumber": "",
  //   });
  // }

  Future<bool?> signInWithGoogle() async {
    bool result = false;
    final box = GetStorage();

    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection("User-info").doc(user!.email).set({
            "name": "",
            "uid": user.uid,
            "phone": "",
            "email": user.email,
          });
          box.write('email', user.email);
          box.write('name', "noname");
          print(box.read('email'));
          print(box.read('name'));
        }
        result = true;
        box.write('email', "already_signged_in");
        box.write("userKey", user!.uid.toString());

        Get.to(() => BottomNavPage());
      }
      return result;
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.10, vertical: 40),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.050),
              child: Image.asset(
                "assets/images/logo.png",
                height: 200,
                width: screenWidth,
              ),
            ),
            Text(
              "Welcome to Our Digital Dhopa Shop",
              style: GoogleFonts.robotoSlab(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            // SizedBox(
            //   height: screenHeight * 0.20,
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         signInWithGoogle();
            //       });
            //     },
            //     child: Text("Sign in with Google")),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                setState(() {
                  signInWithGoogle();
                });
              },
            )
          ],
        ),
      ),
    ));
  }
}
