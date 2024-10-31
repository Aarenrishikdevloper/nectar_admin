import 'package:admin/Comom_widget/Buttons.dart';
import 'package:admin/Comom_widget/lineInput.dart';
import 'package:admin/Comom_widget/line_input.dart';
import 'package:admin/models/Product.dart';
import 'package:admin/view/Maintabview/Maintabview.dart';
import 'package:admin/view_model/Offerviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dt;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../commons/themedata.dart';

class OfferAdd extends StatefulWidget {
  final Product obj;
  OfferAdd({super.key, required this.obj});

  @override
  State<OfferAdd> createState() => _OfferAddState();
}

class _OfferAddState extends State<OfferAdd> {
  final TextEditingController controller = TextEditingController();
  String formatDate(DateTime date){
    DateFormat formatter = DateFormat('MM-yyyy-dd');
    return formatter.format(date);
  }
  final pvm = Get.put(Offerviewmodel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Add Offer", style: TextStyle(
            color: Tcolor.primarytext,
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/img/back.png", width: 20, height: 20,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Obx(() {
              return Column(
                children: [
                  LineTextButton(
                    title: "Start Date",
                    placeholder: "Select Date",
                    value:formatDate(pvm.selectStartdate.value),
                    onPressed: () {
                      dt.DatePicker.showDatePicker(
                        context, showTitleActions: true,
                        minTime: DateTime.now(),
                        theme: dt.DatePickerTheme(
                            itemStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                            doneStyle: TextStyle(
                              color: Tcolor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )
                        ),
                        onChanged: (date) {
                          pvm.selectStartdate.value =date;
                        },
                        onConfirm: (date) {
                          pvm.selectStartdate.value =date;
                        },
                        currentTime: DateTime.now(),
                        locale: dt.LocaleType.en,

                      );
                    },

                  ),
                  SizedBox(height: 25,),
                  LineTextButton(
                    title: "End Date",
                    placeholder: "End Date",
                    value:formatDate(pvm.selectEnddate.value),
                    onPressed: () {
                      dt.DatePicker.showDatePicker(
                        context, showTitleActions: true,
                        minTime: DateTime.now(),
                        theme: dt.DatePickerTheme(
                            itemStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                            doneStyle: TextStyle(
                              color: Tcolor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )
                        ),
                        onChanged: (date) {
                          pvm.selectEnddate.value =date;
                        },
                        onConfirm: (date) {
                          pvm.selectEnddate.value =date;
                        },
                        currentTime: DateTime.now(),
                        locale: dt.LocaleType.en,
                      );
                    },

                  ),
                  SizedBox(height: 25,),
                  lineInput(
                    title: "Offer Price",
                    placeholder: "Enter Offer Price",
                    keyboardType: TextInputType.text,
                    controller: controller,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 25,),
                  RoundButton(Title: pvm.isloading.value == false ?"Add":"...Adding", onpresed: () async{
                    final res  = await pvm.createOffer(controller.text, widget.obj.id);
                    if(res){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>maintabview()));
              }

                  }, bgcolor:pvm.isloading.value == false?Tcolor.primary:Tcolor.disablecolor,),


                ],
              );
            }),
          ),
        ),

      ),
    );
  }
}

