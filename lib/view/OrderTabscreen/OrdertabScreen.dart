import 'package:admin/view/OrderTabscreen/Orderdetailsview.dart';
import 'package:admin/view_model/fetchoffer.dart';
import 'package:admin/view_model/fetchorders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Comom_widget/Orderrow.dart';
import '../../commons/themedata.dart';

class Ordertabscreen extends StatefulWidget {
  const Ordertabscreen({super.key});

  @override
  State<Ordertabscreen> createState() => _OrdertabscreenState();
}

class _OrdertabscreenState extends State<Ordertabscreen> {
  final ordercontroller = Get.put(Fetchorders());

  @override
  void initState() {
    // TODO: implement initState
    ordercontroller.fetchdata();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<Fetchorders>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Orders List",
              style: TextStyle(
                color: Tcolor.primarytext,
                fontWeight: FontWeight.w700,
                fontSize: 20,

              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: ordercontroller.isloading.value == false ? Obx(() {
            return ordercontroller.product.value.isEmpty ? Center(
              child: Text(
                "No Any Order Place",
                style: TextStyle(
                    color: Tcolor.primarytext,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
            ) : Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemCount: ordercontroller.product.value.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = ordercontroller.product.value[index];
                  return Orderrow(item: item, Index: index, ontap: () {
                    Get.to(()=>Orderdetailsview(item:item, index:index,));
                  },);
                },

              );
            });
          }) : null

      );
    });
  }
}
