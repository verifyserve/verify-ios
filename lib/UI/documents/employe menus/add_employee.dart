import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'dart:io' as io;

import '../../../utils/constant.dart';
import '../../../utils/message_handler.dart';
import '../../widgets/appTextField.dart';

class AddEmployee extends StatefulWidget {
  final String type;
  const AddEmployee({Key? key, required this.type}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  late DocumentationBloc bloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController Employee_work = TextEditingController();
  TextEditingController Employee_address = TextEditingController();
  TextEditingController Employee_name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController Employee_salary = TextEditingController();
  TextEditingController Employee_about = TextEditingController();
  TextEditingController Employee_Mobile = TextEditingController();
  TextEditingController Employee_email = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String dateTime = DateFormat("dd-MM-yyyy").format(DateTime.now());
  // ValueNotifier<String?> employeeImage = ValueNotifier(null);

  @override
  void initState() {
    bloc = context.read<DocumentationBloc>();
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    super.initState();
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Add Employee",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ),
              Center(
                child: Text(
                  "Please fill all details carefully it cannot be changed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_name.text = value;
                        },
                        controller: Employee_name,
                        title: "Employee Name",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_email.text = value;
                        },

                        controller: Employee_email,
                        title: "Employee Email",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_address.text = value;
                        },
                        controller:Employee_address,
                        title: "Employee Address",
                        maxLines: 5,
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_Mobile.text = value;
                        },
                        controller: Employee_Mobile,
                        title: "Employee Mobile",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_salary.text = value;
                        },
                        controller: Employee_salary,
                        title: "Employee Salary",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_work.text = value;
                        },
                        controller: Employee_work,
                        title: "Employee Work",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Employee_about.text = value;
                        },
                        controller: Employee_about,
                        title: "Employee About",
                        showTitle: true,
                        maxLines: 5,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Joining Date", style: TextStyle(fontSize: 13,color: Colors.white)),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150.h,
                        width: 1.sw,
                        child: CupertinoDatePicker(
                          onDateTimeChanged: (dt) {
                            dateTime = DateFormat("dd-MM-yyyy").format(dt);
                            print(dateTime);
                          },
                          mode: CupertinoDatePickerMode.date,
                          maximumDate: DateTime.now(),
                          minimumDate: DateTime(1950),
                          initialDateTime: DateTime.now().subtract(const Duration(days: 1)),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     DateTime? dt = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime.now(),
                      //       lastDate: DateTime.now().add(const Duration(days: 30)),
                      //     );
                      //     if (dt != null) {
                      //       // bloc.updateStartDate(dt);
                      //     }
                      //   },
                      //   child: Container(
                      //     height: 50,
                      //     padding: const EdgeInsets.symmetric(horizontal: 20),
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey[100],
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: const Row(
                      //       children: [
                      //         Icon(PhosphorIcons.clock),
                      //         SizedBox(width: 15),
                      //         Text(
                      //           "05-09-2023",
                      //           style: TextStyle(
                      //             fontSize: 15,
                      //             color: Colors.black54,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      /* const SizedBox(height: 20,),
                      GestureDetector(
                          onTap: () async{
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            final bytes = io.File(image?.path ?? "").readAsBytesSync();
                            employeeImage.value = base64Encode(bytes);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.8.sw,
                              child: DottedBorder(
                                  color: Colors.red,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child:  Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Upload Employee image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ValueListenableBuilder(valueListenable: employeeImage, builder: (context, String? data, child) {
                                        if(data == null){
                                          return SizedBox();
                                        }
                                        return Icon(
                                          PhosphorIcons.circle_wavy_check_fill,
                                          color: Colors.green,
                                        );
                                      },),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),*/
                      const SizedBox(height: 25,),
                      GestureDetector(
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            bloc.addEmployee(
                                Employee_work:Employee_work.text,
                                 Employee_address:Employee_address.text,
                                Employee_name:Employee_name.text,
                             date:dateTime,
                             Employee_salary:Employee_salary.text,
                             Employee_about:Employee_about.text,
                             Employee_Mobile:Employee_Mobile.text,
                             Employee_email:Employee_email.text,
                              // image: employeeImage.value,
                              type: widget.type,
                            );
                          }
                        },
                        child: Container(
                            height: 45,
                            width: 1.sw,
                            // margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                color: Colors.red),
                            child:
                            ValueListenableBuilder(
                              valueListenable: bloc.topListLoader,
                              builder: (context, bool loading, child) {
                                if(loading){
                                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                }
                                return Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        // letterSpacing: 0.8,
                                        fontSize: 16),
                                  ),
                                );
                              },
                            )
                        ),
                      ),
                      const SizedBox(height: 25,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}