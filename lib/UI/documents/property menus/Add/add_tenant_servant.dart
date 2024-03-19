import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:verify/UI/documents/property%20menus/Add/servant.dart';
import 'package:verify/UI/documents/property%20menus/Add/tenant.dart';

import '../../../../utils/constant.dart';

class Add_Tenant_Servant extends StatefulWidget {
  const Add_Tenant_Servant({super.key});

  @override
  State<Add_Tenant_Servant> createState() => _Add_Tenant_ServantState();
}

class _Add_Tenant_ServantState extends State<Add_Tenant_Servant> {
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Image.asset(AppImages.verify, height: 55),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Row(
              children: [
                SizedBox(
                  width: 3,
                ),
                Icon(
                  PhosphorIcons.caret_left_bold,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(3),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.grey),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(text: 'Add Tenant'),
                    Tab(text: 'Add Servant'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  TenantDetails(),
                  ServantDetails()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// return Scaffold(
    //   backgroundColor: Colors.black,
    //   appBar: AppBar(
    //     centerTitle: true,
    //     backgroundColor: Colors.black,
    //     title: Image.asset(AppImages.verify, height: 55),
    //     leading: InkWell(
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //       child: const Row(
    //         children: [
    //           SizedBox(
    //             width: 3,
    //           ),
    //           Icon(
    //             PhosphorIcons.caret_left_bold,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   body:
    //   DefaultTabController(
    //     length: 2,
    //     child:  Scaffold(
    //       appBar: AppBar(
    //         automaticallyImplyLeading: false,
    //         bottom: TabBar(
    //           tabs: [
    //             Tab(text: 'Basic Details'),
    //             Tab(text: 'Address'),
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(
    //         children: [
    //           TenantDetails(),
    //           ServantDetails()
    //         ],
    //       ),
    //     ),
    //   )
    // );