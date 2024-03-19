import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:verify/UI/vehicle/History/reciver.dart';

import '../../../utils/constant.dart';
import 'History.dart';

class VehcileHistory extends StatefulWidget {
  const VehcileHistory({super.key});

  @override
  State<VehcileHistory> createState() => _VehcileHistoryState();
}

class _VehcileHistoryState extends State<VehcileHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              SizedBox(height: 15,),
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
                    Tab(text: 'Recent Alerts'),
                    Tab(text: 'Incoming Alerts'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Recent(),
                  ReciverHistory()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}