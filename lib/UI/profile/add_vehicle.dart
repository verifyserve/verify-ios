import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/home/home_bar.dart';
import 'package:verify/UI/profile/profile.dart';
import '../../utils/constant.dart';
import '../widgets/top_snackbar/top_snack_bar.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");

  String? Vehicle_no;

  @override
  void initState() {
    super.initState();
    init();
    fetchdata(Vehicle_no,id);
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    id.value=preferences.getString("id")??'';
    print(selectedVehicleTypes);
  }

  TextEditingController addvehiclecontroller = TextEditingController();
  final _vehicleNumberStreamController = StreamController<bool>.broadcast();

  int selectedVehicleType = 0;
  String selectedVehicleTypes = "Two Wheeler";

  Future<void> fetchdata(Vehicle_no,id) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Add_MultiVehicle?Vehicleno=$Vehicle_no&Vehicle_type=$selectedVehicleTypes&subid=$id'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);
      //SharedPreferences prefs = await SharedPreferences.getInstance();
    } else {
      print('Failed Registration');
    }
  }

  Future<void> fetchdata1(id,Vehicle_no) async{
    final responce = await http.get(Uri.parse("https://verifyserve.social/WebService1.asmx/AddVehicle_Record?name=$id&vehicle_no=$Vehicle_no"));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);
      //SharedPreferences prefs = await SharedPreferences.getInstance();
    } else {
      print('Failed Registration');
    }
  }

  //bool _validate = false;

  //bool _isValid = false;

  Widget CustomVehicleTypeButton(String assetImage, String typeName, String defaults, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedVehicleType = index;
          selectedVehicleTypes = typeName;
          print(selectedVehicleTypes);
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedVehicleType == index) ? 2.0 : 0.5,
            color: (selectedVehicleType == index)
                ? Colors.green
                : Colors.blue.shade600),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  assetImage,
                  fit: BoxFit.contain,
                  width: 60,
                  height: 80,
                ),
                Text(typeName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                Text(defaults,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey,fontFamily: 'Poppins',letterSpacing: 0),),
              ],
            ),
          ),
          if (selectedVehicleType == index)
            Positioned(
              top: 5,
              right: 5,
              child: Image.asset(
                "assets/images/tick.png",
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    addvehiclecontroller.dispose();
    _vehicleNumberStreamController.close();
    super.dispose();
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
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // SizedBox(height: 20,),
            //  Text('Add Vehicle Number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 20,),
              Text('Please, Select your vehicle type.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.pinkAccent.shade200,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 5,),
              Text('(Default type is selected)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3,right: 3),
                        child: CustomVehicleTypeButton("assets/images/bike.png",'Two Wheeler','(Default)', 0),
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3,right: 3),
                        child: CustomVehicleTypeButton("assets/images/car.png",'Four Wheeler','', 1),
                      )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3),
                    child: CustomVehicleTypeButton("assets/images/tuk.png",'Other','', 2),
                  )),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10)
                    //FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                   // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle number is required';
                    }
                    // Use a regular expression for vehicle number validation
                    String pattern = r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid vehicle number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // You can perform validation here and update the stream accordingly
                    // For simplicity, let's consider a basic validation using a regular expression
                    String pattern = r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$';
                    RegExp regex = RegExp(pattern);
                    bool isValid = regex.hasMatch(value);
                    _vehicleNumberStreamController.add(isValid);
                  },
                  controller: addvehiclecontroller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.all(12),
                      hintText: "Type Vehicle Number..",
                     // errorText: _validate ? "Field Can't Be Empty" : null,
                      suffixIcon: IconButton(
                        onPressed: addvehiclecontroller.clear,
                        icon: Icon(PhosphorIcons.x_circle,size: 20,),
                      ),
                      prefixIcon: Icon(
                        PhosphorIcons.car,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<bool>(
                stream: _vehicleNumberStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Vehicle number is valid!', style: TextStyle(color: Colors.green),),
                    );
                  } else {
                    return Text('', style: TextStyle(color: Colors.red),
                    );
                  }
                },
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: controllers.length,
              //       itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           SizedBox(height: 10,),
              //           ListTile(
              //               title: Container(
              //                 padding: const EdgeInsets.all(1),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(15),
              //                   // boxShadow: K.boxShadow,
              //                 ),
              //                 child: TextField(
              //                 controller: controllers[index],
              //                 decoration: InputDecoration(
              //                   hintText: "Vehicle Number ${index + 1}",
              //                   hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
              //                   prefixIcon: Icon(
              //                     PhosphorIcons.car,
              //                     color: Colors.black54,
              //                   ),
              //                     border: InputBorder.none
              //                 ),
              //                 ),
              //               ),
              //             trailing: index == controllers.length - 1
              //             ?Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(20)),
              //                 color: Colors.teal
              //               ),
              //               child: IconButton(
              //                 icon: Icon(Icons.add,color: Colors.white,size: 25,),
              //                 onPressed: () {
              //                   setState(() {
              //                     controllers.add(TextEditingController());
              //                   });
              //                 },
              //               ),
              //             ):
              //             Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.all(Radius.circular(20)),
              //                   color: Colors.redAccent
              //               ),
              //               child: IconButton(
              //                 icon: Icon(Icons.remove,color: Colors.white,size: 25,),
              //                 onPressed: () {
              //                   setState(() {
              //                     controllers.removeAt(index);
              //                   });
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //       },),
              // ),
              // SizedBox(height: 65,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ValueListenableBuilder(
          valueListenable: id,
          builder: (context, String idd,__) {
          return FloatingActionButton.extended(
            label: Text('Add'),
            icon: Icon(PhosphorIcons.car),
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              // setState(() {
              //   addvehiclecontroller.text.isEmpty? _validate = true : _validate = false;
              // });
              if(_formKey.currentState!.validate()){
                fetchdata(addvehiclecontroller.text,idd);
                fetchdata1(idd, addvehiclecontroller.text);
                Navigator.pop(context);
                showTopSnackBar(
                  context,
                  CustomSnackBar.info(
                    message:
                    "Vehicle number added successfully!",
                  ),);

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Vehicle number added successfully!',style: TextStyle(color: Colors.green),),
                //   ),
                // );
              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBar(),), (route) => route.isFirst);
              }
              // else{
              //   _validate = true;
              // }
            },
          );
        }
      ),
    );
  }
}