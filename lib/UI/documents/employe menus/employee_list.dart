import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/documents/addProperty.dart';
import 'package:verify/UI/documents/employe%20menus/add_employee.dart';
import 'package:verify/UI/documents/employe%20menus/employee_details.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/data/model/showAddedEmployee.dart';
import 'package:verify/data/model/showAddedTenant.dart';
import 'package:verify/utils/constant.dart';

import '../property menus/flat_details.dart';

class EmployeeList extends StatefulWidget {
  final List<ShowAddedEmployee> data;
  final String type;
  final bool? show;
  const EmployeeList({Key? key, required this.data, required this.type, this.show}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late DocumentationBloc bloc;
  List<String> gridImages = [
    AppImages.documents,
    AppImages.notification,
    AppImages.realEstate,
    AppImages.vehicle,
    AppImages.insurance,
    AppImages.services,
    AppImages.jobs,
    AppImages.itAndDesigner,
    AppImages.consultantAndLowers,
    AppImages.hotels,
    AppImages.eventsAndWeeding,
    AppImages.trucksAndJcb,
  ];

  @override
  void initState() {
    bloc = context.read<DocumentationBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: widget.show != null ? Colors.black : null,
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("object ${widget.data[index].eeid}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Provider.value(value: bloc,child: EmployeeDetails(id: '${widget.data[index].eeid}',),)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: widget.show == null ? Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.data[index].employeeName ??"",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "From ${widget.data[index].employeeJoiningdate}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "₹ ${widget.data[index].employeeSalary}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Work as : ${widget.data[index].employeeWork}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          /*Container(
                            height: 65.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.white)
                            ),
                            child: ClipOval(
                                // borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "http://www.verifyserve.social/upload/${widget.data[index].employeeImage}",
                                // width: 35,
                                // height: 35,
                                fit: BoxFit.fill,
                              ),),
                          ),*/
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl:
                              "http://www.verifyserve.social/upload/${widget.data[index].employeeImage}",
                              height: 65.h,
                              width: 80.w,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Image.asset(
                                AppImages.loading,
                                height: 65.h,
                                width: 80.w,
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, error, stack) =>
                                  Image.asset(
                                    AppImages.imageNotFound,
                                    height: 65.h,
                                    width: 80.w,
                                    fit: BoxFit.fill,
                                  ),
                            ),
                            /*FadeInImage.assetNetwork(
                              image: "http://www.verifyserve.social/upload/${widget.data[index].employeeImage}",
                              height: 65.h,
                              width: 80.w,
                              fit: BoxFit.fill,
                              placeholder: AppImages.loading,
                              imageErrorBuilder: (context, error, stack) => Image.asset(
                                AppImages.imageNotFound,
                                height: 65.h,
                                fit: BoxFit.fill,
                                width: 80.w,
                              ),
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton:widget.show != null ? const SizedBox():Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 10)),

                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Provider.value(
                            value: bloc,
                            child: AddProperty(
                              id: 1,
                            ),
                          ),
                    ),
                  );
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) =>  Provider.value(value: bloc,child: AddEmployee(type: widget.type,),)));
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(width: 5,),
                    Text("Add ",style: TextStyle(fontSize: 15),),
                  ],
                ),),
            ],
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
