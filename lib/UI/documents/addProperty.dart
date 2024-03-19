import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/documents/employe%20menus/add_employee.dart';
import 'package:verify/UI/documents/employe%20menus/employee_list.dart';
import 'package:verify/UI/documents/property%20menus/add_tenant.dart';
import 'package:verify/UI/documents/property%20menus/flat_list.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/utils/message_handler.dart';

import '../../utils/constant.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key,required this.id,}) : super(key: key);
  final int id;
  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  late DocumentationBloc bloc;
  ValueNotifier<String?> type = ValueNotifier(null);
  List<String> status = [
    'FLAT',
    'SHOP',
    'SHOWROOM',
    'WAREHOUSE',
    'FLOOR',
    'BASEMENT',
    'ROOFS',
    'HOMES',
  ];
  selectStatus(data) {
    status = data;
  }

  List<String> status2 = [
    'EMPLOYEE',
    'SERVANT',
    'WORKER',
    'CUSTOMER',
    'STUDENTS',
  ];
  selectStatus2(data) {
    status2 = data;
  }

  @override
  void initState() {
    bloc = context.read<DocumentationBloc>();
    super.initState();
    bloc.DocumentationStream.stream.listen((event) {
      if(event == "done"){
        if(widget.id == 0){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Provider.value(
                    value: bloc,
                    child: AddTenant(type: type.value ?? ""),
                  ),
            ),
          );
        }
        if(widget.id == 1){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Provider.value(
                    value: bloc,
                    child: AddEmployee(type: type.value ?? ""),
                  ),
            ),
          );
        }
      }
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Text(widget.id==0?"Add Property Field":"Add Employee Field",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 25
          ),
          ),
          const SizedBox(height: 20,),
          const SizedBox(height: 50,),
          if(widget.id==0)Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: DropdownButtonFormField<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF4F5F7)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF2F2F2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 10),
                hintText: "Select Field",
                hintStyle:
                const TextStyle(color: Colors.black54, fontSize: 15),
              ),
              onChanged: (String? data) {
                type.value = data?? "";
                selectStatus(data!);
              },
              items: status.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if(widget.id==1)Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: DropdownButtonFormField<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF4F5F7)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF2F2F2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 10),
                hintText: "Select Field",
                hintStyle:
                const TextStyle(color: Colors.black54, fontSize: 15),
              ),
              onChanged: (String? data) {
                type.value = data?? "";
                selectStatus2(data!);
              },
              items: status2.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: () {
              // print(type.value);
              if(type.value != null){
                if(widget.id == 0){
                  bloc.addPropertyType(type.value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Provider.value(
                            value: bloc,
                            child: AddTenant(type: type.value ?? ""),
                          ),
                    ),
                  );
                }
                if(widget.id == 1){
                  bloc.addEmployeeType(type.value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Provider.value(
                            value: bloc,
                            child: AddEmployee(type: type.value ?? ""),
                          ),
                    ),
                  );
                }
              }
              else{
                bloc.showMessage(MessageType.error("Field cannot empty!"));
              }
            },
            child: Container(
              height: 45,
              width: 0.7.sw,
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.red),
              child:
              ValueListenableBuilder(
                valueListenable: bloc.topListLoader,
                builder: (context, bool loading, child) {
                  if(loading){
                    return Center(child: CircularProgressIndicator(color: Colors.white,));
                  }
                  return  Center(
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
              ),
            ),
          ),
          // SizedBox(height: 10,),
          // if(widget.id == 0)
          // Expanded(child: Provider.value(value: bloc,child: FlatList(data: bloc.tenantList,type: bloc.type.value,show: true,))),
          // if(widget.id == 1)
          //   Expanded(
          //     child: Provider.value(value: bloc,child: EmployeeList(data: bloc.employeeList,type: bloc.type.value,show: true,),),
          //   ),
        ],
      ),
    );
  }
}
