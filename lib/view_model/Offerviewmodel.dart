import 'dart:convert';

import 'package:get/get.dart';

import '../commons/constants.dart';
import "package:http/http.dart" as http;

import '../commons/utils.dart';
class Offerviewmodel extends GetxController{
  final selectStartdate = DateTime.now().obs;
  final selectEnddate = DateTime.now().obs;
  final baseuri = constants.baseurl;
  final isloading = false.obs;
  Future<bool>createOffer(Price, Prod_id)async{
    try{
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = '${baseuri}/admin/offer';
      var url = Uri.parse(uri);
      var body =jsonEncode({
        'id':Prod_id,
         "startdate":selectStartdate.value.toIso8601String(),
         "enddate": selectEnddate.value.toIso8601String(),
         'price':Price,
          "seller_id":userId,
      });
      final res = await http.post(url, body:body, headers:{ 'Content-Type': 'application/json',});
      if(res.statusCode == 200){
        Get.snackbar("Sucessfully offer added", "added Sucessfully");
        return true;
      }else{
        return false;
      }
    }catch(e) {
      print(e);
      Get.snackbar("error", "Something Went Wrong");
      return false;
    }finally{
      isloading.value = false;
    }


  }
  Future<bool>UpdateOffer(String Id, String Price)async{
    try{
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = '${baseuri}/admin/offer?id=${Id}';
      var url = Uri.parse(uri);
      var body =jsonEncode({

        "startdate":selectStartdate.value.toIso8601String(),
        "enddate": selectEnddate.value.toIso8601String(),
        'price':Price,
        "seller_id":userId,
      });
      final res = await http.patch(url, body:body, headers:{ 'Content-Type': 'application/json',});
      if(res.statusCode == 200){
        Get.snackbar("Sucessfully offer added", "added Sucessfully");
        return true;
      }else{
        return false;
      }
    }catch(e) {
      print(e);
      Get.snackbar("error", "Something Went Wrong");
      return false;
    }finally{
      isloading.value = false;
    }


  }
}