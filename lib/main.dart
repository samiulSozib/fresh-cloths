import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/pages/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phone_auth/splash_screen.dart';

import 'admin/admin_dashboard.dart';
import 'newpages/new_products_page.dart';
import 'pages/dashboard.dart';
import 'pages/productpage.dart';

void main() async {
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Clothes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
