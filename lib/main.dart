import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/app/routes/app_pages.dart';
import 'app/app/services/api/dependency_injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Dependency.init();
  runApp(
    GetMaterialApp(
      title: "Product Listing",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
