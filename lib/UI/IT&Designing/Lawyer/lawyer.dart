import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../utils/constant.dart';
import 'lawyer_details.dart';

class LawyerList extends StatefulWidget {
  const LawyerList({super.key});

  @override
  State<LawyerList> createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList> {

  List<String> listLawyer = [
    'Cheque Dishonour',
    'Money Recovery',
    'Property Dispute',
    'Motor Accident Claim',
    "Divorce Matter's",
    "Maintenance Claims",
    "Domestic Violence",
    "Employer Harassment",
    "Medical Negligence",
    "Criminal Proceedings",
    "Civil Suits",
    "Legal Documentation"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
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
        actions: [
          InkWell(
              onTap: (){
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Recent()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 7,top: 5),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (){
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ));
                        },
                        child: Icon(PhosphorIcons.timer,size: 30,)),
                  ],
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10,right: 10,left: 10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listLawyer.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LawyerDetails()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20,bottom: 20,right: 10,left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(listLawyer[index],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                Spacer(),
                                Icon(PhosphorIcons.caret_right,color: Colors.white)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
            ),
          ],
        ),
      ),
    );
  }
}