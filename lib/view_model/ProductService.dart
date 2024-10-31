import 'dart:convert';
import 'dart:io';
import 'package:admin/view/Product/Home.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:admin/commons/constants.dart';
import 'package:admin/models/nutitionmodel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../commons/utils.dart';
import '../models/Product.dart';

class Productservice extends GetxController {
  final nutritionList = <NutritionModel>[].obs;
  Rx<List<Product>> product = Rx([]);
  final selectImage = Rx<File?>(null);
  final productImage = RxList<File?>([]);
  final baseuri = constants.baseurl;
  final isloading = false.obs;
  Rx<List<dynamic>>Images = Rx([]);
  Rx<List<NutritionModel>> nutritionListEdit = Rx([]);

  void actionNewNutrition(String value, String name) {
    if (value.isEmpty) {
      return;
    }
    if (name.isEmpty) {
      return;
    }
    nutritionList.add(NutritionModel(

        nutritionName: name,
        nutritionValue: value


    ));
  }

  void removenutrition(NutritionModel obj) {
    nutritionList.remove(obj);
  }

  Future<bool> CreateProduct(String name, String details, String unitname,
      String Unitvalue, String price, List<Map<String, dynamic>>nutritionlist,

      String cat, String?nutritionweight) async {
    isloading.value = true;
    try {
      final token = await utils.getToken() as String;
      List<File>newImages = [];
      print(token);
      final userId = utils.verifyJwt(token);
      String uri = '${baseuri}/admin/product?userId=${userId}';
      var url = Uri.parse(uri);
      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = name;
      request.fields['details'] = details;
      request.fields['price'] = price;
      request.fields['unitname'] = unitname;
      request.fields['unitvalue'] = Unitvalue;
      request.fields['nutrition'] = jsonEncode(nutritionlist);
      request.fields['category'] = cat;
      request.fields['nutritionweight'] = nutritionweight ?? "0";
      request.fields['userId'] = userId;



      for (var image in Images.value) {

          newImages.add(File(image));

      }
      for(var image in newImages){
        var imagefile = await http.MultipartFile.fromPath("images", image.path);
        request.files.add(imagefile);
      }


      var res = await request.send();
      var responsebody = await http.Response.fromStream(res);
      if (responsebody.statusCode == 201) {
        Get.snackbar("Sucessfull", "Product Added Sucessfully");

        nutritionList.clear();
        productImage.clear();


        return true;
      } else {
        Get.snackbar("Error", "Something went wrong");

        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
      return false;
    } finally {
      isloading.value = false;
    }
  }

  Future<bool> UpdateProduct(String name, String details, String unitname,
      String Unitvalue, String price,String id, List<Map<String, dynamic>>nutritionlist,
      String cat, String?nutritionweight) async {

    try {
      isloading.value = true;
      List<String>existingImageLinks = [];
      List<File>newImages = [];
      final token = await utils.getToken() as String;
      print(token);
      final userId = utils.verifyJwt(token);
      String uri = '${baseuri}/admin/product?prodId=${id}';
      var url = Uri.parse(uri);
      var request = http.MultipartRequest('PUT', url);
      request.fields['name'] = name;
      request.fields['details'] = details;
      request.fields['price'] = price;
      request.fields['unitname'] = unitname;
      request.fields['unitvalue'] = Unitvalue;
      request.fields['nutrition'] = jsonEncode(nutritionlist);
      request.fields['category'] = cat;
      request.fields['nutritionweight'] = nutritionweight ?? "0";
      request.fields['userId'] = userId;



      for (var image in Images.value) {
        if(image is String && image.startsWith('https')){
          existingImageLinks.add(image);
        }else{
          newImages.add(File(image));
        }
      }
      request.fields['existimgImageUrls'] = jsonEncode(existingImageLinks);
      for(var image in newImages){
        var imagefile = await http.MultipartFile.fromPath("images", image.path);
        request.files.add(imagefile);
      }


      var res = await request.send();
      var responsebody = await http.Response.fromStream(res);
      if (responsebody.statusCode == 201) {
        Get.snackbar("Sucessfull", "Product Updated Sucessfully");

        nutritionList.clear();
        Images.value.clear();


        return true;
      } else {
        Get.snackbar("Error", "Something went wrong");

        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
      return false;
    } finally {
      isloading.value = false;
    }
  }

}
