
import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:get/get.dart';

import '../commons/constants.dart';
import '../commons/utils.dart';

class Promocodeservie extends GetxController{
  final selectStartdate = DateTime.now().obs;
  final selectEnddate = DateTime.now().obs;
  final  selectedType = "Fixed".obs;
  final baseuri = constants.baseurl;
  final isloading = false.obs;

  Future<bool>addpromo(String Promocode, String title, String desc, String Price, String min_oder_price, String max_disc )async{
    try{
      isloading.value = true;
      final token = await utils.getToken();
      print(token);
      final userId = utils.verifyJwt(token!);
      final uri = '${baseuri}/admin/promo';
      var body = jsonEncode({
        "Prmocode":Promocode,
        "title":title,
        "desc":desc,
        "offerprice":double.parse(Price),
        "userId":userId,
        "max_order_amount":double.parse(min_oder_price),
        "max_dis_amount":double.parse(max_disc),
        "startdate":selectStartdate.value.toIso8601String(),
        "enddate":selectEnddate.value.toIso8601String(),
        "type":selectedType.value
      });

      final res = await http.post(Uri.parse(uri), body:body,headers:{'Content-Type': 'application/json'} );
      if(res.statusCode == 200){
        Get.snackbar("Sucessfully added", "Sucessfully added ");
        return true;
      }else{
        Get.snackbar("Error", "Something Went wrong");
        return false;

      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went wrong");
      return false;

    }finally{
      isloading.value = false;
    }

  }
  Future<bool>UpdatePromo(String Promocode, String title, String desc, String Price, String min_oder_price, String max_disc, String Id )async{
    try{
      isloading.value = true;
      final token = await utils.getToken();
      print(token);
      final userId = utils.verifyJwt(token!);
      final uri = '${baseuri}/admin/promo?id=${Id}';
      var body = jsonEncode({
        "Prmocode":Promocode,
        "title":title,

        "desc":desc,
        "offerprice":double.parse(Price),
        "userId":userId,
        "max_order_amount":double.parse(min_oder_price),
        "max_dis_amount":double.parse(max_disc),
        "startdate":selectStartdate.value.toIso8601String(),
        "enddate":selectEnddate.value.toIso8601String(),
        "type":selectedType.value
      });

      final res = await http.patch(Uri.parse(uri), body:body,headers:{'Content-Type': 'application/json'} );
      if(res.statusCode == 200){
        Get.snackbar("Sucessfully Updated", "Sucessfully Updated ");
        return true;
      }else{
        Get.snackbar("Error", "Something Went wrong");
        return false;

      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went wrong");
      return false;

    }finally{
      isloading.value = false;
    }

  }
}