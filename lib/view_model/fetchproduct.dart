import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/Order.dart';
import '../models/Product.dart';
import 'package:http/http.dart' as http;
class fetchproduct extends GetxController{
  Rx<List<Product>> product = Rx([]);
  final baseuri = constants.baseurl;

  final isloading = false.obs;

  void fetchdata() async{


    try{
      isloading.value = true;
      utils.showHUD();
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "$baseuri/admin/getproducts?sellerId=${userId}";
      final res = await http.get(Uri.parse(uri),);

      if(res.statusCode == 200){
        var data = json.decode(res.body);

        product.value=(data['products'] as List).map((model)=>Product.fromJson((model))).toList();



      } else{
        Get.snackbar("Error", "Something went wrong");
      }


    }catch(e){
      print(e);
      Get.snackbar("Error", "data detching failed",);
      print(e);
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
      String uri = "${baseuri}/admin/products?prod_Id=${Id}";
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