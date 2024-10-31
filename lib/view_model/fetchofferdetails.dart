import 'dart:convert';

import 'package:get/get.dart';
import "package:http/http.dart" as http;
import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/Orderdetailmodel.dart';

class fetchofferdetails extends GetxController{
  final baseuri = constants.baseurl;
  final Orderdetails = Rxn<OrderDetailModel>();
  final isloading = false.obs;


  Future<void> getorderDetails(String id)async{
    try{
      utils.showHUD();
      isloading.value = true;
      final uri = '${baseuri}/admin/orderdetails?orderId=${id}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        final data = json.decode(res.body)['order'];
        print(data);
        Orderdetails.value = OrderDetailModel.fromJson(data);



      }else{

        Get.snackbar("Error", "Something Went Wrong");
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      utils.hideHud();
      isloading.value = false;
    }
  }
  Future<void>updstestatus(String Status, String id)async{
    try{
      isloading.value = true;
      final uri = '${baseuri}/admin/order?id=${id}';
      var body = jsonEncode({
        "status":Status,
      });
      final res = await http.patch(Uri.parse(uri),headers:{ 'Content-Type': 'application/json',}, body:body);
      if(res.statusCode == 200){
        Orderdetails.value!.orderStatus = Status;
        Get.back();
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      isloading.value = false;
    }
  }

}