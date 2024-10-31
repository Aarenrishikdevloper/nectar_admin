import 'dart:io';

import 'package:admin/commons/themedata.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepickerview extends StatefulWidget {
  final Function(String) didSelect;
  const Imagepickerview({super.key, required this.didSelect});

  @override
  State<Imagepickerview> createState() => _ImagepickerviewState();
}

class _ImagepickerviewState extends State<Imagepickerview> {
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Container(
      width:media.width * 0.9,
      height:media.width * 0.7,
      padding:EdgeInsets.all(15),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(15),
        boxShadow:const[
          BoxShadow(color:Colors.black54, blurRadius:4,spreadRadius:4)
        ]
      ),
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,

        children: [
          Text(
            "Image Picker",
            style:TextStyle(
              fontWeight:FontWeight.bold,
              fontSize:20,
              color:Tcolor.primarytext,
            ),
          ),
          SizedBox(height:media.width*0.04,),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:TextButton(
                  onPressed:(){
                    getImageCamera();
                  },
                  child:Icon(
                    Icons.camera_alt,
                    size:100,
                    color:Tcolor.primarytext
                  )

                ),
              ),
              Expanded(
                child:TextButton(
                    onPressed:(){
                      getImageGallery();
                    },
                    child:Icon(
                        Icons.image,
                        size:100,
                        color:Tcolor.primarytext
                    )

                ),
              ),


            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:Text(
                  "Take Photo",
                  textAlign:TextAlign.center,
                  style:TextStyle(
                      color:Tcolor.primarytext,
                      fontSize:17
                  ),
                ),

              ),
              Expanded(
                child:Text(
                  "Gallery",
                  textAlign:TextAlign.center,
                  style:TextStyle(
                      color:Tcolor.primarytext,
                      fontSize:17
                  ),
                ),
              )
            ],

          ),
          SizedBox(
            height:media.width*0.01,

          ),
          Expanded(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child:Text(
                    "Close",
                    style:TextStyle(
                      color:Tcolor.primary,
                      fontSize:20,
                      fontWeight:FontWeight.w600
                    ),
            
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Future getImageCamera()async{
    try{
      final pickedfile = await picker.pickImage(source:ImageSource.camera);
      if(pickedfile != null){
        widget.didSelect(pickedfile!.path);

        Navigator.pop(context);
      }
      print(pickedfile);
    }catch(err){
      debugPrint(err.toString());
    }
  }
  Future getImageGallery()async{
    try{
      final pickedFile = await picker.pickImage(source:ImageSource.gallery);
      if(pickedFile != null){
        widget.didSelect(pickedFile.path);
        Navigator.pop(context);
      }
    }catch(err){
      debugPrint(err.toString());
    }
  }
}
