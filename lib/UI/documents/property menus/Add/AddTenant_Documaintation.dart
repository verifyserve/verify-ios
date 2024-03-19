import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/constant.dart';
import '../../../home/home_screen.dart';
import '../../NewDocumaintation.dart';
import '../../document_screen.dart';

class Add_Property extends StatefulWidget {
  const Add_Property({super.key});

  @override
  State<Add_Property> createState() => _Add_PropertysState();
}

class _Add_PropertysState extends State<Add_Property> {

  final TextEditingController _propertyName = TextEditingController();
  final TextEditingController _propertyAddress = TextEditingController();
  final TextEditingController _Socity = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _landmark = TextEditingController();
  final TextEditingController _propertytype = TextEditingController();
  final TextEditingController _name = TextEditingController();
  late TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();

  Future<void> fetchdata(propertyName,propertyadd,socity,plce,city,landmark,name,email,mobile,propertytype) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Property_Documaintation?Property_Name=$propertyName&Property_Address=$propertyadd&Society=$socity&Place=$plce&City=$city&Near_Landmark=$landmark&Owner_Name=$name&Owner_Number=$mobile&Owner_Email=$email&Property_type=Flat'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  String? dropdownValue,dropdownValue_dob,dropdownValue_gender;

  String email22 = '';
  String name222 = '';
  var data = '';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

  /*void navigateToFormPage(BuildContext context) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => FlatList(data: [],)));
  }*/

  @override
  void initState() {
    super.initState();
    init();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("name")??'';
    email.value=preferences.getString("email")??'';
    number.value=preferences.getString("phone")??'';

  }

  void handleSubmit(BuildContext context) {
    // Add your form submission logic here

    // Pop the current route and return to the previous page (the home page)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.black,
      title: Image.asset(AppImages.verify, height: 55),),
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
                  child: Text('Property Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _propertyName,
                  decoration: InputDecoration(
                      hintText: "Enter Property Name",
                      prefixIcon: Icon(
                        PhosphorIcons.house_line,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //Property Address Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Property Address',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _propertyAddress,
                  decoration: InputDecoration(
                      hintText: "Enter Property Address",
                      prefixIcon: Icon(
                        PhosphorIcons.map_pin,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //Property Society Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Society',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _Socity,
                  decoration: InputDecoration(
                      hintText: "Enter Society Name",
                      prefixIcon: Icon(
                        PhosphorIcons.buildings,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //Property Place Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Property Place',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _place,
                  decoration: InputDecoration(
                      hintText: "Enter Property Place",
                      prefixIcon: Icon(
                        PhosphorIcons.map_pin_line,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //Property City Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('City',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _city,
                  decoration: InputDecoration(
                      hintText: "Enter City Name",
                      prefixIcon: Icon(
                        Icons.location_city_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              // Property Near Landmark Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Near Landmark',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                    controller: _landmark,
                  decoration: InputDecoration(
                      hintText: "Enter Near Landmark",
                      prefixIcon: Icon(
                        PhosphorIcons.bookmark_simple,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //// Property name Text Feild
             /* Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Owner Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: "Enter Owner Name",
                      prefixIcon: Icon(
                        PhosphorIcons.timer,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //// Property Property Type Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Owner Email',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Enter Owner Email",
                      prefixIcon: Icon(
                        PhosphorIcons.timer,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              //// Property Property Type Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Owner Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _number,
                  decoration: InputDecoration(
                      hintText: "Enter Owner Number",
                      prefixIcon: Icon(
                        PhosphorIcons.timer,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),*/

              //// Property Property Type Text Feild
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Property Type',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _propertytype,
                  decoration: InputDecoration(
                      hintText: "Enter Property Type",
                      prefixIcon: Icon(
                        Icons.category_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 40,),


              
              /*Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, String name,__) {
                        return Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        );
                      },

                  ),
                  ValueListenableBuilder(
                      valueListenable: email,
                      builder: (context, String email2,__) {
                        return Text(
                          email2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        );
                      }
                  ),
                  ValueListenableBuilder(
                      valueListenable: number,
                      builder: (context, String num,__) {
                        return Text(
                          num,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        );
                      }
                  ),
                ],
              ),*/

              Center(
                child:  ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, String n,__) {
                    return ValueListenableBuilder(
                        valueListenable: email,
                        builder: (context, String e,__) {
                        return ValueListenableBuilder(
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

                                  fetchdata(_propertyName.text,_propertyAddress.text, _Socity.text, _place.text, _city.text, _landmark.text, n, e, num, _propertytype.text);

                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DocumentScreen(),), (route) => route.isFirst);

                                }, child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
                              ),
                              ),

                            );
                          }
                        );
                      }
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
     // _data = prefs.getString('phone') ?? '';
    });
  }
}
