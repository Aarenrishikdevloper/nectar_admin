import 'package:admin/Comom_widget/Buttons.dart';
import 'package:admin/models/Promomodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Comom_widget/lineInput.dart';
import '../../../Comom_widget/line_input.dart';
import '../../../commons/themedata.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as dt;

import '../../../view_model/Promocodeservice.dart';
import 'Promocodeview.dart';
class Promocodeedit extends StatefulWidget {
  final Promo item;
   Promocodeedit({super.key, required this.item});

  @override
  State<Promocodeedit> createState() => _PromocodeeditState();
}

class _PromocodeeditState extends State<Promocodeedit> {
  late TextEditingController controllerPromo = TextEditingController(text:widget.item.promoCode);
  late TextEditingController controllerTitle = TextEditingController(text:widget.item.title);
  late TextEditingController controllerDesc = TextEditingController(text:widget.item.description);
  late TextEditingController controllerOffer = TextEditingController(text:widget.item.offerPrice.toString());
  late TextEditingController controllerMinprice = TextEditingController(text:widget.item.minOrderPrice.toString());
  late TextEditingController controllerMaxPrice = TextEditingController(text:widget.item.maxDiscountAmount.toString() );
  final pvm = Get.put(Promocodeservie());

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MM-yyyy-dd');
    return formatter.format(date);
  }
  @override
  void initState() {
    pvm.selectStartdate.value = widget.item.startDate;
    pvm.selectEnddate.value = widget.item.endDate;
    pvm.selectedType.value = widget.item.type;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Add Promo Code",
            style: TextStyle(
                color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Promocodeview()));
            },
            icon: Image.asset(
              "assets/img/back.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    lineInput(
                        title: "Promo Code",
                        placeholder: "Enter Promo Code",
                        controller: controllerPromo,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    lineInput(
                        title: "Title",
                        placeholder: "Enter Promo Code Title",
                        controller: controllerTitle,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    lineInput(
                        title: "Description",
                        placeholder: "Enter Promo Code Description",
                        controller: controllerDesc,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Obx(() {
                      return LineTextButton(
                        title: "Start Date",
                        placeholder: "Select Date",
                        value: formatDate(pvm.selectStartdate.value),
                        onPressed: () {
                          dt.DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            theme: dt.DatePickerTheme(
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                  color: Tcolor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                            onChanged: (date) {
                              pvm.selectStartdate.value = date;
                            },
                            onConfirm: (date) {
                              pvm.selectStartdate.value = date;
                            },
                            currentTime: DateTime.now(),
                            locale: dt.LocaleType.en,
                          );
                        },
                      );
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    Obx(() {
                      return LineTextButton(
                        title: "End Date",
                        placeholder: "End Date",
                        value: formatDate(pvm.selectEnddate.value),
                        onPressed: () {
                          dt.DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            theme: dt.DatePickerTheme(
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                  color: Tcolor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                            onChanged: (date) {
                              pvm.selectEnddate.value = date;
                            },
                            onConfirm: (date) {
                              pvm.selectEnddate.value = date;
                            },
                            currentTime: DateTime.now(),
                            locale: dt.LocaleType.en,
                          );
                        },
                      );
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Promo Code Type",
                          style: TextStyle(
                              color: Tcolor.textTittle,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Obx(() {
                          return SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      pvm.selectedType.value = "Fixed";
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                            pvm.selectedType.value == "Fixed"
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color: Tcolor.primary),
                                        const SizedBox(height: 15),
                                        Text(
                                          "Fixed",
                                          style: TextStyle(
                                              color: Tcolor.textTittle,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      pvm.selectedType.value = "Percentage";
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                            pvm.selectedType.value ==
                                                "Percentage"
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color: Tcolor.primary),
                                        const SizedBox(height: 15),
                                        Text(
                                          "Percentage(%)",
                                          style: TextStyle(
                                              color: Tcolor.textTittle,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Container(
                            width: double.maxFinite,
                            height: 1,
                            color: Color(0xffE2E2E2)),
                        SizedBox(
                          height: 25,
                        ),
                        lineInput(
                            title: "Offer Price",
                            placeholder: "Enter Offer Price",
                            controller: controllerOffer,
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        lineInput(
                            title: "Min Order Price",
                            placeholder: "Enter Min Order Price",
                            controller: controllerMinprice,
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        lineInput(
                            title: "Max Discount Amount",
                            placeholder: "Enter Max Discount Price",
                            controller: controllerMaxPrice,
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        Obx(() {
                          return RoundButton(Title: pvm.isloading.value == false
                              ? "Update"
                              : "...Updating", onpresed: ()async {
                            final res = await pvm.UpdatePromo(  controllerPromo.text, controllerTitle.text,
                                controllerDesc.text, controllerOffer.text,
                                controllerMinprice.text,
                                controllerMaxPrice.text, widget.item.id);
                            if(res){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>const Promocodeview()));
                            }
                          }, bgcolor: pvm.isloading.value == false ? Tcolor
                              .primary : Tcolor.disablecolor,);
                        })
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
