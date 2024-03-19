import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Main/ShowPropertyTenant.dart';

class ServantDetails extends StatefulWidget {
  const ServantDetails({super.key});

  @override
  State<ServantDetails> createState() => _ServantDetailsState();
}

class _ServantDetailsState extends State<ServantDetails> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
    _loaduserdata();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    number.value=preferences.getString("phone")??'';
  }

  String data1 = '';

  String? dropdownValue,dropdownValue_dob,dropdownValue_gender;

 // TimeOfDay? _firstTime;
  //TimeOfDay? _secondTime;

  String? _selectedTime,_selectedEndtime;

  String workTime = '';

  final TextEditingController _Servent_name = TextEditingController();
  final TextEditingController _Servent_number = TextEditingController();
  final TextEditingController _Servent_work = TextEditingController();
  TextEditingController _Work_timing = TextEditingController();

  Future<void> fetchdata(Servent_name,Servent_number,Servent_work,Work_timing,no) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/DocumaintationPropertyServent?Servent_name=$Servent_name&Servent_number=$Servent_number&Servent_work=$Servent_work&Work_timing=$Work_timing&Owner_number=$no&Subid=$data1'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  Future<void> _showStartTime() async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);

        workTime = '${_selectedTime} to ${_selectedEndtime}';

        _Work_timing.text = workTime;

      });
    }
  }

  Future<void> _showEndTime() async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedEndtime = result.format(context);

        workTime = '${_selectedTime} to ${_selectedEndtime}';

        _Work_timing.text = workTime;

      });
    }
  }

  // Future<void> _selectTime(BuildContext context, bool isStartTime) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (picked != null && (isStartTime ? selectedEndTime : selectedStartTime) == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(" select ${isStartTime ? 'end' : 'start'} time first."),
  //       ),
  //     );
  //   } else if (picked != null) {
  //     setState(() {
  //       if (isStartTime) {
  //         selectedStartTime = picked;
  //       } else {
  //         selectedEndTime = picked;
  //       }
  //       if (selectedStartTime != null && selectedEndTime != null) {_Work_timing.text =
  //       "${selectedStartTime!.format(context)} - ${selectedEndTime!.format(context)}";
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Servant Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              // Container(
              //   padding: EdgeInsets.all(1),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(15),
              //     // boxShadow: K.boxShadow,
              //   ),
              //   child: DropdownButtonFormField<String>(
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       prefixIcon: Icon(
              //         PhosphorIcons.identification_badge_light,
              //         color: Colors.black54,
              //       ),
              //     ),
              //     padding: EdgeInsets.only(right: 10,left: 0),
              //     hint: const Text('Select ID Card'),
              //     value: dropdownValue,
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         dropdownValue = newValue!;
              //       });
              //     },
              //     items: <String>['Aadhaar Card', 'Driving License', 'Voter Id Card']
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _Servent_name,
                  decoration: InputDecoration(
                      hintText: "Enter Servant Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Servant Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                    controller: _Servent_number,
                  decoration: InputDecoration(
                      hintText: "Enter Servant Number",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Servant Work',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                    controller: _Servent_work,
                  decoration: InputDecoration(
                      hintText: "Enter Servant Work",
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Work Timing',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        _showStartTime();
                      },
                      child: Text('Select Start Time'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        _showEndTime();
                      },
                      child: Text('Select End Time'),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _Work_timing,
                  // onTap: () async{
                  //   TimeOfDay? pickedTime =  await showTimePicker(
                  //     initialTime: TimeOfDay.now(),
                  //     context: context,
                  //   );
                  //
                  //   if(pickedTime != null ){
                  //     print(pickedTime.format(context));   //output 10:51 PM
                  //     DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                  //     //converting to DateTime so that we can further format on different pattern.
                  //     print(parsedTime); //output 1970-01-01 22:53:00.000
                  //     String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                  //     print(formattedTime); //output 14:59:00
                  //     //DateFormat() is from intl package, you can format the time on any pattern you need.
                  //
                  //     setState(() {
                  //       _Work_timing.text = ; //set the value of text field.
                  //     });
                  //   }else{
                  //     print("Time is not selected");
                  //   }
                  // },
                  decoration: InputDecoration(
                      hintText: "Enter Work Timing",
                      prefixIcon: Icon(
                        PhosphorIcons.timer,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 40,),

              Center(
                child: ValueListenableBuilder(
                    valueListenable: number,
                    builder: (context, String num,__) {
                      return Container(
                        height: 50,
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.red.withOpacity(0.8)
                        ),

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                          ),
                          onPressed: (){
                            //data = _email.toString();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ShowProperty(iidd: data1),), (route) => route.isFirst);

                            fetchdata(_Servent_name.text, _Servent_number.text, _Servent_work.text, _Work_timing.text, num);
                          }, child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
                        ),
                        ),

                      );
                    }
                ),
              ),

              SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data1 = prefs.getString('id_Document') ?? '';
    });


  }

}
