import 'package:admin/Comom_widget/Buttons.dart';
import 'package:admin/commons/utils.dart';
import 'package:admin/models/Order.dart';
import 'package:admin/view_model/fetchofferdetails.dart';
import 'package:admin/view_model/fetchorders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Comom_widget/Orderitem.dart';
import '../../commons/themedata.dart';

class Orderdetailsview extends StatefulWidget {
 final Order item;
  final int index;

  const Orderdetailsview({super.key, required this.index, required this.item});

  @override
  State<Orderdetailsview> createState() => _OrderdetailsviewState();
}

class _OrderdetailsviewState extends State<Orderdetailsview> {
  final orderdetailService = Get.put(fetchofferdetails());
 final service  = Get.put(Fetchorders());
  @override
  void initState() {
    orderdetailService.getorderDetails(widget.item.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Order Details",
            style: TextStyle(
                color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/img/back.png',
              width: 20,
              height: 20,
            ),
          ),
        ),
        body: Obx(() {
          return orderdetailService.isloading.value == false
              ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Order Id: #${widget.index + 1}",
                                style: TextStyle(
                                    color: Tcolor.primarytext,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              utils.getorderPayment((orderdetailService
                                  .Orderdetails.value?.paymentStatus)
                                  .toString()),
                              style: TextStyle(
                                  color: utils.getorderColorPayment(
                                      (orderdetailService.Orderdetails.value
                                          ?.paymentStatus)
                                          .toString()),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('yyyy-MM-dd - hh:mm a').format(
                                    orderdetailService
                                        .Orderdetails.value!.createdAt!
                                        .toLocal()),
                                style: TextStyle(
                                    color: Tcolor.secoundarytext, fontSize: 12),
                              ),
                            ),
                            Text(
                              utils.getorderstatus(orderdetailService
                                  .Orderdetails.value!.orderStatus as String),
                              style: TextStyle(
                                color: utils.getorderColor(orderdetailService
                                    .Orderdetails.value!.orderStatus as String),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (orderdetailService.Orderdetails.value?.postalcode !=
                            "")
                          Text(
                            "${orderdetailService.Orderdetails.value?.address ??
                                ""}, ${orderdetailService.Orderdetails.value
                                ?.city ?? ""}, ${orderdetailService.Orderdetails
                                .value?.state ?? ""} ${orderdetailService
                                .Orderdetails.value?.postalcode ?? ""}  ",
                            style: TextStyle(
                                color: Tcolor.secoundarytext, fontSize: 16),
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "Delivery Type: ",
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                orderdetailService
                                    .Orderdetails.value?.deliveryType as String,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Tcolor.primarytext, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "Payment Type: ",
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                orderdetailService
                                    .Orderdetails.value?.paymentType as String,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Tcolor.primarytext, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4,),

                        Obx(() {
                          return orderdetailService.isloading.value == false
                              ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            itemBuilder: (context, index) {
                              var pobj = orderdetailService
                                  .Orderdetails.value?.product![index];
                              return Orderitem(
                                item: pobj,

                              );
                            },
                            itemCount: orderdetailService
                                .Orderdetails.value?.product!.length,
                          )
                              : SizedBox();
                        }),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 2),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Amount: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(
                                            widget.item.totalPrice)} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Delivery Cost: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(
                                            widget.item.deliveryPrice)} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  children: [
                                    Text(
                                      "Discount: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(
                                            widget.item.discount.toDouble())} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),
                                SizedBox(height: 8,),
                                Container(
                                  width: double.maxFinite,
                                  height: 1,
                                  color: Colors.black12,
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text(
                                      "Total: ",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(
                                            widget.item.userPayPrice
                                                .toDouble())} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),


                              ],
                            )),
                            if(orderdetailService.Orderdetails.value!.orderStatus == "pending")
                              Padding(
                                padding:EdgeInsets.all(15),
                                child:Row(
                                  children: [
                                    Expanded(
                                      child:RoundButton(
                                         Title:orderdetailService.isloading == false ?"Accepted":"...Accepting",
                                          onpresed:(){
                                           orderdetailService.updstestatus("Accepted", widget.item.id);
                                          },
                                      )
                                    ),
                                    SizedBox(width:15,),
                                    Expanded(
                                        child:RoundButton(
                                          Title:orderdetailService.isloading == false ?"Reject":"...Rejecting",
                                          onpresed:(){
                                            orderdetailService.updstestatus("rejected", widget.item.id);
                                          },
                                          bgcolor:Colors.red,
                                        ),

                                    ),

                                  ],
                                ),
                              ),
                        if(orderdetailService.Orderdetails.value!.orderStatus  == "Accepted")
                          Padding(
                            padding:EdgeInsets.all(15),
                            child:Row(
                              children: [
                                Expanded(
                                    child:RoundButton(
                                      Title:orderdetailService.isloading.value == false ?"Delivered":"...Delivering",
                                      onpresed:(){
                                        orderdetailService.updstestatus("delivered", widget.item.id);
                                      },
                                    )
                                ),
                                SizedBox(width:15,),
                                Expanded(
                                  child:RoundButton(
                                    Title:orderdetailService.isloading.value == false ?"Order Cancel":"...Cancelling",
                                    onpresed:(){
                                      service.updstestatus("cancelled", widget.item.id);
                                    },
                                    bgcolor:Colors.red,
                                  ),

                                ),

                              ],
                            ),
                          ),

                      ],
                    ),
                  ),
                ],
              )) : SizedBox();
        })
    );
  }

}
