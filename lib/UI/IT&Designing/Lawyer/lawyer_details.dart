import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constant.dart';
import 'enquiry_form.dart';

class LawyerDetails extends StatefulWidget {
  const LawyerDetails({super.key});

  @override
  State<LawyerDetails> createState() => _LawyerDetailsState();
}

class _LawyerDetailsState extends State<LawyerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
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
      body: Container(
        padding: EdgeInsets.only(top: 10,right: 10,left: 10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "",
                                  height: 130.h,
                                  width: 130.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    AppImages.loading,
                                    height: 130.h,
                                    fit: BoxFit.cover,
                                    width: 130.w,
                                  ),
                                  errorWidget: (context, error, stack) =>
                                      Image.asset(
                                        AppImages.imageNotFound,
                                        height: 120.h,
                                        fit: BoxFit.fill,
                                        width: 130.w,
                                      ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: AssetImage('assets/images/V.png'),height: 20,),
                                  Text('Adv. Om Narayan Pandey',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                  Text('Pratap Nagar / Mayur Vihar',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                  Text('10 AM to 9 PM',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.green.shade500,fontFamily: 'Poppins',letterSpacing: 0),),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image(image: AssetImage('assets/images/lawyer.png'),height: 20,),
                                      SizedBox(width: 5,),
                                      Text('Supreme Court',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                    ],
                                  ),

                                  SizedBox(width: 10,),
                                  Text.rich(
                                      TextSpan(
                                          text: 'Since - ',
                                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: "2007",
                                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade400,fontFamily: 'Poppins',letterSpacing: 0),
                                            )
                                          ]
                                      )),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnquiryForm()));
                            },
                            style: ElevatedButton.styleFrom(fixedSize:  Size(MediaQuery.of(context).size.width, 30),backgroundColor: Colors.red),
                            child: const Text('Send Enquiry',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                          )
                        ],
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
