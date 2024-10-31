import 'dart:convert';

import 'package:get/get.dart';


import '../commons/constants.dart';
import "package:http/http.dart" as http;

import '../commons/utils.dart';
import '../models/Promomodel.dart';
class fetchpromo extends GetxController{
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  Rx<List<Promo>> promo = Rx([]);

  Future<void>fetchpromocode()async{
    try{
      utils.showHUD();
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      final uri = '${baseurl}/admin/promo?sellerid=${userId}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        promo.value =(data['promo'] as List)
            .map((model)=>Promo.fromJson(model)).toList();
        print(promo.value);
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "something Went Wrong");
    }finally{
      utils.hideHud();
    }
  }


}