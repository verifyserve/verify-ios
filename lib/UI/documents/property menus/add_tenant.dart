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
import 'dart:convert';

import '../../../utils/constant.dart';
import '../../../utils/message_handler.dart';
import '../../widgets/appTextField.dart';

class AddTenant extends StatefulWidget {
  final String type;
  const AddTenant({Key? key, required this.type}) : super(key: key);

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  late DocumentationBloc bloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController Addres = TextEditingController();
  TextEditingController floorno = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController Tanentname = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController rent = TextEditingController();
  TextEditingController AboutTanent = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hometown = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String dateTime = DateFormat("dd-mm-yyyy").format(DateTime.now());
  // ValueNotifier<String?> propertyImage = ValueNotifier(null);
  // ValueNotifier<String?> tenantImage = ValueNotifier(null);

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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Add Tenant",
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Tanentname.text = value;
                        },
                        controller: Tanentname,
                        title: "Tenant Name",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          email.text = value;
                        },
                        controller: email,
                        title: "Email",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Addres.text = value;
                        },
                        controller: Addres,
                        title: "Address",
                        maxLines: 5,
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          floorno.text = value;
                        },
                        controller: floorno,
                        title: "Floor No",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          rent.text = value;
                        },
                        controller: rent,
                        title: "Rent Price",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          Number.text = value;
                        },
                        controller: Number,
                        title: "Number",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          state.text = value;
                        },
                        controller: state,
                        title: "State",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          hometown.text = value;
                        },
                        controller: hometown,
                        title: "Hometown",
                        showTitle: true,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      AppTextField(
                        onFieldSubmitted: (value) {
                          AboutTanent.text = value;
                        },
                        controller: AboutTanent,
                        title: "About Tenant",
                        showTitle: true,
                        maxLines: 5,
                        validate: true,
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Start Date", style: TextStyle(fontSize: 13,color: Colors.white)),
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
                      //     // DateTime? dt = await showDatePicker(
                      //     //   context: context,
                      //     //   initialDate: DateTime.now(),
                      //     //   firstDate: DateTime.now(),
                      //     //   lastDate: DateTime.now().add(const Duration(days: 30)),
                      //     // );
                      //
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
                          propertyImage.value = base64Encode(bytes);
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
                                  child: Row(
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
                                          "Upload Property image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ValueListenableBuilder(valueListenable: propertyImage, builder: (context, String? data, child) {
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
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async{
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          final bytes = io.File(image?.path ?? "").readAsBytesSync();
                          tenantImage.value = base64Encode(bytes);
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
                                  child: Row(
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
                                          "Upload Tenant image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ValueListenableBuilder(valueListenable: tenantImage, builder: (context, String? data, child) {
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
                            print("${Tanentname.text} ${state.text} ${rent.text} ${widget.type} ${Number.text} ${hometown.text} ${floorno.text} ${Addres.text} ${AboutTanent.text} ${email.text}");
                            bloc.addTenant(
                              Tanentname: Tanentname.text,
                              // TanentImg: tenantImage.value ?? "",
                              state: state.text,
                              rent: rent.text,
                              propetrytype: widget.type,
                              // PropertyImg: propertyImage.value ?? "",
                              Number: Number.text,
                              hometown: hometown.text,
                              floorno: floorno.text,
                              date: dateTime,
                              Address: Addres.text,
                              AboutTanent: AboutTanent.text,
                              email: email.text,
                            );
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 1.sw,
                          // margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.red),
                          child:
                          ValueListenableBuilder(
                            valueListenable: bloc.topListLoader,
                            builder: (context, bool loading, child) {
                              if(loading){
                                return const Center(child: CircularProgressIndicator(color: Colors.white,),);
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
            ),
          ],
        ),
      ),
    );
  }
}
