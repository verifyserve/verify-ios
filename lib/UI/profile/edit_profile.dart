import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/profile/profile.dart';
import 'package:verify/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");
  ValueNotifier<String>name1=ValueNotifier("");
  ValueNotifier<String>email1=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");
  ValueNotifier<String>location=ValueNotifier("");

  @override
  void initState() {
    init();
  }

  init()async {
    preferences = await SharedPreferences.getInstance();
    id.value = preferences.getString("id") ?? '';
    name1.value=preferences.getString("name")??'';
    email1.value=preferences.getString("email")??'';
    number.value=preferences.getString("phone")??'';
    location.value=preferences.getString("location")??'';
  }

  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  Future<void> fetchdata(id,name,email,mobile,location) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/Update_profile?id=$id&Name=$name&Email=$email&Mobile=$mobile&Location=$location'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [

              SizedBox(height: 50,),

              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/profile.png')
                      //_imageFile == null? AssetImage('assets/images/profile.jpg'): FileImage(file(_imageFile.path)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50,),

              ValueListenableBuilder(
                  valueListenable: name1,
                  builder: (context, String na,__) {
                  return Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      // boxShadow: K.boxShadow,
                    ),
                    child: TextField(
                      controller: name,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          labelText: 'Your Name',labelStyle: TextStyle(color: Colors.pinkAccent.shade100,fontFamily: 'Poppins',),
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.pinkAccent.shade100,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: Colors.pinkAccent.shade100,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent.shade100,
                              )
                          )),
                    ),
                  );
                }
              ),

              SizedBox(height: 20,),

              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: email,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                      labelText: 'Email Address',labelStyle: TextStyle(color: Colors.pinkAccent.shade100,fontFamily: 'Poppins',),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.pinkAccent.shade100,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent.shade100,
                          )
                      )),
                ),
              ),

              SizedBox(height: 20,),

              Container(

                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: mobile,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Contact',labelStyle: TextStyle(color: Colors.pinkAccent.shade100,fontFamily: 'Poppins',),
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.pinkAccent.shade100,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent.shade100,
                          )
                      )),
                ),
              ),

              SizedBox(height: 20,),

              Container(

                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: password,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),

                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Location',labelStyle: TextStyle(color: Colors.pinkAccent.shade100,fontFamily: 'Poppins',),
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.pinkAccent.shade100,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: Colors.pinkAccent.shade100,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent.shade100,
                          )
                      )),
                ),
              ),

              SizedBox(height: 50,),

              ValueListenableBuilder(
                  valueListenable: id,
                  builder: (context, String iid,__) {
                  return GestureDetector(
                    onTap: (){

                      fetchdata(iid, name.text, email.text, mobile.text, password.text);
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfilePage(),), (route) => route.isFirst);

                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.pinkAccent.shade100
                        ),
                        child: const Center(
                          child: Text("Update", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  );
                }
              ),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
