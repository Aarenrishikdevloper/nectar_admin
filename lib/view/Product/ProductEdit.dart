import 'dart:io';

import 'package:admin/models/Product.dart';
import 'package:admin/models/nutitionmodel.dart';
import 'package:admin/view/Maintabview/Maintabview.dart';
import 'package:admin/view/Product/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Comom_widget/Buttons.dart';
import '../../Comom_widget/Dropdown.dart';
import '../../Comom_widget/ImagepickerView.dart';
import '../../Comom_widget/lineInput.dart';
import '../../Comom_widget/popout.dart';
import '../../commons/constants.dart';
import '../../commons/themedata.dart';
import '../../view_model/ProductService.dart';

class Productedit extends StatefulWidget {
  final Product item;

  const Productedit({super.key, required this.item});

  @override
  State<Productedit> createState() => _ProducteditState();
}

class _ProducteditState extends State<Productedit> {
  late TextEditingController productname = TextEditingController(
      text: widget.item.name);
  late TextEditingController productdesc = TextEditingController(
      text: widget.item.desc);
  late TextEditingController unitname = TextEditingController(
      text: widget.item.unitName);
  late TextEditingController unitvalue = TextEditingController(
      text: widget.item.unitValue);
  late TextEditingController price = TextEditingController(
      text: widget.item.price.toString());
  late TextEditingController Nutriongram = TextEditingController(
      text: widget.item.nutritionweight);
  late TextEditingController nutrivaluecontroller = TextEditingController();
  late TextEditingController nutrinamecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late String? selected = widget.item.Cat as String;
  final productservice = Get.put(Productservice());
  XFile?selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productservice.Images.value.addAll(widget.item.image as Iterable);
    var filterNutrition = widget.item.nutrition!.where((nutrition) =>
    nutrition.ProductId == widget.item.id).toList();
    productservice.nutritionList.value = filterNutrition;
    print(productservice.nutritionListEdit.value);
    print(filterNutrition);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Edit Product", style: TextStyle(
            color: Tcolor.primarytext,
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),),
        leading: IconButton(
          onPressed: () {
            productservice.nutritionListEdit.value.clear();
            productservice.Images.value.clear();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: Image.asset("assets/img/back.png", width: 20, height: 20,),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                lineInput(
                  title: "Product Name",
                  placeholder: "Enter Name",
                  controller: productname,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Please enter a valid product name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                lineInput(
                  title: "Product Details",
                  placeholder: "Enter Details",
                  controller: productdesc,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Please enter a valid product name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                Dropdown(
                  title: "Category",
                  placeholder: "Select Category",
                  valueList: constants.groceryCategories,
                  selectValue: selected,
                  didChange: (value) {
                    setState(() {
                      selected = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 15,),
                lineInput(
                  title: "Unit Name",
                  placeholder: "Enter Unit name",
                  controller: unitname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Unit name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                lineInput(
                  title: "Unit Value",
                  placeholder: "Enter Unit Value",
                  controller: unitvalue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Unit Value is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                lineInput(
                  title: "Nutrition Weight",
                  placeholder: "Enter Nutrition Weight",
                  keyboardType: TextInputType.number,
                  controller: Nutriongram,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 15,),

                lineInput(
                  title: "Price",
                  placeholder: "Enter Price",
                  keyboardType: TextInputType.number,
                  controller: price,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Price is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    Text(
                      "Nutrition List",
                      style: TextStyle(
                          color: Tcolor.primarytext,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),
                    ),


                  ],

                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      child: lineInput(
                        title: "Nutritional Name",
                        placeholder: "Enter Name",
                        controller: nutrinamecontroller,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 8,),
                    SizedBox(
                      width: 120,
                      child: lineInput(
                        title: "Value",
                        placeholder: "Value",
                        controller: nutrivaluecontroller,
                        validator: (value) {
                          return null;
                        },
                      ),

                    ),
                    SizedBox(width: 8,),
                    InkWell(
                      onTap: () {
                        productservice.actionNewNutrition(
                            nutrivaluecontroller.text,
                            nutrinamecontroller.text);
                        nutrinamecontroller.clear();
                        nutrivaluecontroller.clear();
                      },

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
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Obx(() {
                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var obj = productservice.nutritionList[index];
                      print(obj.nutritionName);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [


                             Row(
                              children: [
                                Expanded(
                                  child: Text(
                                  obj.nutritionName ?? '',
                                    style: TextStyle(
                                        color: Tcolor.primarytext,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Text(obj.nutritionValue ?? '', style: TextStyle(
                                    color: Tcolor.primarytext,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),),
                                IconButton(onPressed: () {
                                  productservice.removenutrition(obj);
                                }, icon: Icon(Icons.delete, color: Colors.red))
                              ],
                            ),


                          Container(
                            width: double.maxFinite,
                            height: 1,
                            color: Color(0xffE2E2E2),
                          )
                        ]
                        ,
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 5,),
                    itemCount: productservice.nutritionList.length,
                  );
                }),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Product Image", style: TextStyle(
                        color: Tcolor.primarytext,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, PopoutLayout(child: Imagepickerview(
                          didSelect: (newimage) {
                            productservice.Images.value.add(
                                File(newimage).path);
                            productservice.Images.refresh();
                          },)));
                      },

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
                    )
                  ],
                ),
                const SizedBox(height: 8,),


                Obx(() {
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1

                      ),
                      itemCount: productservice.Images.value.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 2)
                                    ]
                                ),
                                child:
                                Obx(() {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: productservice.Images
                                        .value![index] is String &&
                                        productservice.Images.value[index]
                                            .startsWith('https')
                                        ? CachedNetworkImage(
                                      imageUrl: productservice.Images
                                          .value![index] as String,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.file(
                                      File(productservice.Images.value![index]),
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                })


                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    productservice.Images.value!.removeAt(
                                        index);
                                    productservice.Images.refresh();
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                            )
                          ],
                        );
                      });
                }),


                SizedBox(height: 25,),
                Obx(() {
                  return RoundButton(
                    Title: productservice.isloading.value == false
                        ? "Update"
                        : "Updating...",
                    onpresed: () async {
                      if (_formkey.currentState?.validate() ?? false) {
                        final result = await productservice.UpdateProduct(productname.text, productdesc.text, unitname.text, unitvalue.text, price.text, widget.item.id as String,   productservice.nutritionList.value.map((item) =>
                        ({
                          'name': item.nutritionName,
                          'value': item.nutritionValue,

                        })).toList(), selected!, Nutriongram.text, );
                        if(result){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>maintabview()));
                        }
                      }

                    },
                    bgcolor: productservice.isloading.value == false ? Tcolor
                        .primary : Tcolor.disablecolor,
                  );
                }),
                SizedBox(height: 25,)

              ],
            ),
          ),)
        ,

      )
      ,
    );
  }
}

