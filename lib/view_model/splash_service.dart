import 'package:admin/view/Maintabview/Maintabview.dart';
import 'package:admin/view/Product/Home.dart';
import 'package:admin/view/login/Welcome.dart';
import 'package:get/get.dart';


import '../commons/utils.dart';

class SplashService extends GetxController {
  void navigatewelcomescreen() async {
    await Future.delayed(Duration(seconds: 3));
    final token = await utils.getToken();

    if (token != null) {
      Get.offAll(() => const maintabview());
    } else {
      Get.offAll(() => const Welcome());
    }
  }
}
