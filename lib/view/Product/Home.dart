import 'package:admin/Comom_widget/Product_cell.dart';
import 'package:admin/commons/themedata.dart';
import 'package:admin/view/Product/ProductAdd.dart';
import 'package:admin/view/offer/offer_add.dart';
import 'package:admin/view_model/ProductService.dart';
import 'package:admin/view_model/fetchproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final service = Get.put(fetchproduct());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<fetchproduct>();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text("Product List", style: TextStyle(
            color: Tcolor.primarytext,
            fontSize: 20,
            fontWeight: FontWeight.w700
        )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Get.off(() => Productadd());
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
            return productCell(pobj: pobj, onpressed: () {
              service.delete(pobj.id as String);
            },onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferAdd(obj:pobj,)));
            },);
          },
        );
      }),
    );
  }
}
