import 'dart:ui';


import 'package:admin/view/Accountview/Account.dart';
import 'package:admin/view/CategorytabScreen.dart';
import 'package:admin/view/OrderTabscreen/OrdertabScreen.dart';
import 'package:admin/view/Type.dart';
import 'package:admin/view/offer/OfferTabScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons/themedata.dart';
import '../Product/Home.dart';


class maintabview extends StatefulWidget {
  const maintabview({super.key});

  @override
  State<maintabview> createState() => _maintabviewState();
}

class _maintabviewState extends State<maintabview> with SingleTickerProviderStateMixin{
  TabController?controller;
  int selectedTab = 0;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller = TabController(length: 4, vsync: this);
    controller?.addListener((){
      setState(() {
        selectedTab = controller!.index;
      });
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
         const Home(),

          const Offertabscreen(),
          const Ordertabscreen(),
          const Account(),

        ],


      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(15),
              topRight:Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                  color:Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, -2)

              )
            ]
        ),
        child:BottomAppBar(
            color:Colors.transparent,
            elevation: 0,
            child:TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: Tcolor.primary,
              labelStyle: TextStyle(
                color:Tcolor.primarytext,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: Tcolor.primarytext,
              unselectedLabelStyle: TextStyle(
                  color: Tcolor.primarytext,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
              tabs: [
                Tab(
                    text: "Shop",
                    icon:Image.asset(
                      "assets/img/store_tab.png", width: 25, height: 25,
                      color: selectedTab == 0 ?Tcolor.primary : Tcolor.primarytext,
                    )
                ),

                Tab(


                      text: "Offers",
                      icon:Image.asset(
                        "assets/img/cart_tab.png", width: 25, height: 25,
                        color: selectedTab == 1 ?Tcolor.primary : Tcolor.primarytext,


                      )




                ),
                Tab(
                    text: "Orders",
                    icon:Image.asset(
                      "assets/img/a_order.png", width: 25, height: 25,
                      color: selectedTab == 2 ?Tcolor.primary : Tcolor.primarytext,
                    )
                ),
                Tab(
                    text: "Account",
                    icon:Image.asset(
                      "assets/img/account_tab.png", width: 25, height: 25,
                      color: selectedTab == 3 ?Tcolor.primary : Tcolor.primarytext,
                    )
                ),

              ],
            )
        ) ,
      ),
    );
  }
}
