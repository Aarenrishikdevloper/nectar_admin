import 'dart:convert';

import 'package:admin/models/Offer.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import '../commons/constants.dart';
import '../commons/utils.dart';

class fetchoffer extends GetxController{
  Rx<List<Offer>> product = Rx([]);
  final baseuri = constants.baseurl;
  final isloading = false.obs;
  void fetchdata() async{


    try{
      isloading.value = true;
      utils.showHUD();
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseuri}/admin/offer?userId=${userId}";
      final res = await http.get(Uri.parse(uri),);

      if(res.statusCode == 200){
        var data = json.decode(res.body);
        print(data);

        product.value=(data['offer'] as List).map((model)=>Offer.fromJson((model))).toList();



      } else{
        Get.snackbar("Error", "Something went wrong");
      }


    }catch(e){
      print(e);
      Get.snackbar("Error", "data detching failed",);
    }finally{
      isloading.value = false;
      utils.hideHud();
    }

  }
  void delete(String Id) async{


    try{
      isloading.value = true;
      final token = await utils.getToken();
      product.value.removeWhere((item) => item.id == Id);
      //refressing the ui
      product.refresh();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseuri}/admin/offer?id=${Id}";
      final res = await http.delete(Uri.parse(uri), );

      if(res.statusCode == 200) {

        Get.snackbar("Product Removed", "Deleted Sucessfully");
        product.value.removeWhere((item) => item.id == Id);
        //refressing the ui
        product.refresh();


      } else{
        Get.snackbar("Error", "Something went wrong");
      }


    }catch(e){
      print(e);
      Get.snackbar("Error", "data detching failed",);
    }finally{
      isloading.value = false;
      utils.hideHud();
    }

  }
}