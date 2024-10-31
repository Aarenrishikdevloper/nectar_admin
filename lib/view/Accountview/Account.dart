import 'package:admin/view/Accountview/Promo%20code/Promocodeview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Comom_widget/Account_row.dart';
import '../../commons/themedata.dart';
import '../login/Login.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset('assets/img/u1.png', width: 60,
                          height: 60,),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [

                                     Text(
                                          "Admin",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700

                                      ),


                                    ),

                                  SizedBox(width: 8,),
                                  Icon(
                                      Icons.edit,
                                      color: Tcolor.primarytext,
                                      size: 18
                                  )
                                ],
                              ),

                               Text("admin@test.com", style: TextStyle(
                                    color: Tcolor.secoundarytext,
                                    fontSize: 16),)

                            ],
                          )
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.black26, height: 1,),
                Accountrow(
                  title: "Promo Code",
                  icon: "assets/img/a_promocode.png",
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Promocodeview()));
                  },
                ),
                Accountrow(
                  title: "Notifications",
                  icon: "assets/img/a_noitification.png",
                  onClick: () {},
                ),
                Accountrow(
                  title: "Help",
                  icon: "assets/img/a_help.png",
                  onClick: () {},

                ),
                Accountrow(
                  title: "About",
                  icon: "assets/img/a_about.png",
                  onClick: () {},

                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () async{

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            Get.off(()=>Login());




                        },
                        height: 60,
                        minWidth: double.maxFinite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19)
                        ),
                        elevation: 0.1,
                        color: const Color(0xffF2F3F2),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Log Out", style: TextStyle(
                                    color: Tcolor.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),),

                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Image.asset(
                                "assets/img/logout.png", width: 20,
                                height: 20,),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                )


              ],
            ),
          ),
        )
      );
  }
}

