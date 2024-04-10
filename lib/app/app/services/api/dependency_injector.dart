import 'package:get/get.dart';
import 'app_service.dart';
import 'base_api_service.dart';

mixin Dependency {
  static void init() {
    Get.lazyPut(() => AppService(), fenix: true);
  }
}