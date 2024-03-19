import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/documentaionBloc.dart';

import '../../../utils/constant.dart';

class EmployeeDetails extends StatefulWidget {
  final String id;
   EmployeeDetails({Key? key,required this.id}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  late DocumentationBloc bloc;

  @override
  void initState() {
    bloc = context.read<DocumentationBloc>();
    super.initState();
    print("hello ${widget.id}");
    bloc.showEmployeeDetail(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 55),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Row(
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
      body:ValueListenableBuilder(
        valueListenable: bloc.employeeLoader,
        builder: (context,bool loading,_) {
          print(bloc.employeeDetail.length);
          if(loading){
            return  Center(child: CircularProgressIndicator(color: Colors.white,),);
          }
          if(bloc.employeeDetail.isNotEmpty){
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child:  CachedNetworkImage(
                            imageUrl:
                            "http://www.verifyserve.social/upload/${bloc.employeeDetail.first}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              AppImages.loading,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, error, stack) =>
                                Image.asset(
                                  AppImages.imageNotFound,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      bloc.employeeDetail.first.employeeName ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Salary ${bloc.employeeDetail.first.employeeSalary}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin:  EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding:  EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Contact",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                            // Spacer(),
                            // Text("Edit",style: TextStyle(
                            //     color: Colors.amber,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w600
                            // ),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white54
                              ),
                              child:  Icon(Icons.phone,size: 15,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                bloc.employeeDetail.first.employeeMobile ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white54
                              ),
                              child:  Icon(Icons.email,size: 15,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                bloc.employeeDetail.first.employeeEmail ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white54
                              ),
                              child:  Icon(Icons.location_on,size: 15,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                bloc.employeeDetail.first.employeeAddress ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white54
                              ),
                              child:  Icon(Icons.calendar_month,size: 15,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                bloc.employeeDetail.first.employeeJoiningdate ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin:  EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    padding:  EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Column(
                      children: [
                        Row(
                          children: [
                            Text("About Employee",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                            //  Spacer(),
                            // Text("Edit",style: TextStyle(
                            //     color: Colors.amber,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w600
                            // ),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                bloc.employeeDetail.first.employeeAbout ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Center(child: Text("No Data Found!",style: TextStyle(color: Colors.white),));
          }
        }
      ) ,
    );
  }
}
