
import 'package:admin/view/Product/ProductEdit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commons/themedata.dart';
import '../commons/utils.dart';
import '../models/Product.dart';



class productCell extends StatelessWidget {
  final Product pobj;
  final double margin;
  final double width;
  final VoidCallback onpressed;
  final VoidCallback onTap;
  const productCell(
      {super.key, required this.pobj, this.margin = 4, this.width = 180, required this.onpressed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         onTap();
      },
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: margin),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border.all(color: Tcolor.placeholder.withOpacity(0.5), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: pobj.image![0] as String,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 100,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const Spacer(),
            Text(
              pobj!.name as String,
              style: TextStyle(
                fontSize: 16,
                color: Tcolor.primarytext,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              " ${pobj!.unitValue} ${pobj!.unitName}  price ",
              style: TextStyle(
                fontSize: 14,
                color: Tcolor.secoundarytext,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                InkWell(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Productedit(item:pobj)));
                    },

                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color:Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit,
                        color:Colors.white,
                        size:20,
                      )
                    ),
                    ),
                    SizedBox(width:8),
                    InkWell(
                      onTap:onpressed,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.delete,
                            color:Colors.white,
                            size:20,
                          )
                      ),
                    )

              ],
            )
          ],
        ),
      ),
    );
  }
}
