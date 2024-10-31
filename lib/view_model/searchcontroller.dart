import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/Product.dart';

class Searchcontroller extends GetxController {

  final baseurl = constants.baseurl;
  final isloading = false.obs;
  Rx<List<Product>> searchresult = Rx([]);
  Rx<List<Product>> catproduct = Rx([]);

  Future<void> searchquery(String query) async {

    try {
      if (query.isEmpty) {
        searchresult.value.clear();
        return;
      }
      utils.showHUD();
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);

      String uri = "${baseurl}/admin/search?searchterm=${query}?sellearId=${userId}";
      final res = await http.get(Uri.parse(uri));
      if (res.statusCode == 200) {
        var data = json.decode(res.body);


        searchresult.value = (data['search'] as List)
            .map((model) => Product.fromJson(model)).toList();

        print(searchresult);
      } else {
        Get.snackbar("Error", "something went Wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "something went Wrong");
      print(e);
    } finally {
      utils.hideHud();
      isloading.value = false;
    }
  }
}