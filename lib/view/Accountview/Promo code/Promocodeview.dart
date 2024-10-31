import 'package:admin/view/Accountview/Promo%20code/Promocodeedit.dart';
import 'package:admin/view/Accountview/Promo%20code/addPromocode.dart';
import 'package:admin/view_model/Promocodeservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Comom_widget/Promocode.dart';
import '../../../commons/themedata.dart';
import '../../../view_model/fetchpromocode.dart';

class Promocodeview extends StatefulWidget {
  const Promocodeview({super.key});

  @override
  State<Promocodeview> createState() => _PromocodeviewState();
}

class _PromocodeviewState extends State<Promocodeview> {
  final service = Get.put(fetchpromo());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.fetchpromocode();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text("Promo Code", style: TextStyle(
            color: Tcolor.primarytext,
            fontSize: 20,
            fontWeight: FontWeight.w700
        )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Get.off(() => Addpromocode());
              },
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Tcolor.primary,
                    borderRadius: BorderRadius.circular(15),

                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/img/add.png",
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          )
        ],

      ),
        backgroundColor: Colors.white,
        body: Obx(() {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemBuilder: (BuildContext context, int index) {
                var pobj = service.promo.value[index];
                return(
                    Promocode_row(pobj: pobj, onTap:(){
                       Navigator.push(context, MaterialPageRoute(builder:(context)=>Promocodeedit(item:pobj,)));
                    },)
                );

              },
              itemCount:service.promo.value.length,
              separatorBuilder:(context, index)=> const Divider(color:Colors.black12, height: 1,)

          );
        })
    );
  }
}
