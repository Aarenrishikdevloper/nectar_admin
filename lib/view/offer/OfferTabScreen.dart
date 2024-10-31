import 'package:admin/Comom_widget/OfferCell.dart';
import 'package:admin/commons/themedata.dart';
import 'package:admin/view/offer/offer_edit.dart';
import 'package:admin/view_model/fetchoffer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Comom_widget/Product_cell.dart';

class Offertabscreen extends StatefulWidget {
  const Offertabscreen({super.key});

  @override
  State<Offertabscreen> createState() => _OffertabscreenState();
}

class _OffertabscreenState extends State<Offertabscreen> {
  final service = Get.put(fetchoffer());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<fetchoffer>();
  }
  @override
  void initState() {
    service.fetchdata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        elevation:0,
        backgroundColor:Colors.transparent ,
        title:Text(
          "Offer List",
          style:TextStyle(
            color:Tcolor.primarytext,
            fontWeight:FontWeight.w700,
            fontSize:20,

          ),
        ),
      ),
      backgroundColor:Colors.white ,
      body: Obx(() {
        return GridView.builder(
          itemCount: service.product.value.length,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            var pobj = service.product.value[index];
            return OffercellCell(pobj: pobj, onpressed: () {
               service.delete(pobj.id);
            },onTap:(){
              Get.to(()=>OfferEdit(item:pobj));
            },);
          },
        );
      }),

    );
  }
}
