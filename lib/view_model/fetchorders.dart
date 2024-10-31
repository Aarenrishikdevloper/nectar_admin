import 'dart:async';
import 'dart:convert';

import 'package:admin/models/Offer.dart';
import 'package:admin/models/Order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/Orderdetailmodel.dart';

class Fetchorders extends GetxController{
  RxList<Order>product = <Order>[].obs;
  final baseuri = constants.baseurl;
  final Orderdetails = Rxn<OrderDetailModel>();
  final isloading = false.obs;
  Timer? _pollingTimer;
  @override
  void onInit() {
    _startpolling();
    super.onInit();
  }
  void _startpolling(){
    _pollingTimer = Timer.periodic((Duration(seconds:5)), (timer){
      pollingdata();
    });
  }
  @override
  void onClose(){
    _pollingTimer?.cancel();
    super.onClose();
  }
  void fetchdata() async{


    try{
      isloading.value = true;
      utils.showHUD();
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseuri}/admin/order?sellerId=${userId}";
      final res = await http.get(Uri.parse(uri),);

      if(res.statusCode == 200){
        var data = json.decode(res.body);

        product.value=(data['order'] as List).map((model)=>Order.fromJson(model)).toList();



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

  Future<void>updstestatus(String Status, String id)async{
    try{
      isloading.value = true;
      final uri = '${baseuri}/admin/order?id=${id}';
      var body = jsonEncode({
        "status":Status,
      });
      final res = await http.patch(Uri.parse(uri),headers:{ 'Content-Type': 'application/json',}, body:body);
      if(res.statusCode == 200){
       var orders = product.firstWhere((order)=>order.id == id);
        if(orders != null){
          orders.orderStatus = Status;
        }
        Get.back();
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      isloading.value = false;
    }
  }

  void pollingdata() async{


    try{

      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseuri}/admin/order?sellerId=${userId}";
      final res = await http.get(Uri.parse(uri),);

      if(res.statusCode == 200){
        var data = json.decode(res.body);

        product.value=(data['order'] as List).map((model)=>Order.fromJson(model)).toList();



      } else{
        Get.snackbar("Error", "Something went wrong");
      }


    }catch(e){
      print(e);
      Get.snackbar("Error", "data detching failed",);
    }

  }

}
