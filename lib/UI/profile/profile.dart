import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/authBloc.dart';
import '../../data/model/showVehicle.dart';
import '../../data/repository/AuthRepository.dart';
import '../../utils/constant.dart';
import '../auth/login.dart';
import '../widgets/appTextField.dart';
import '../widgets/top_snackbar/top_snack_bar.dart';
import 'add_vehicle.dart';
import 'edit_profile.dart';

class Catid{
  //final int id;
  final String Vname;
  final String Vemail;
  final String Vmobile;
  final String Locationhai;
  Catid({required this.Vname,required this.Vemail,required this.Vmobile,required this.Locationhai});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(Vname: json['Vname'],Vemail: json['Vemail'],Vmobile: json['Vmobile'],Locationhai: json['Locationhai']);

  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController vName = TextEditingController();
  TextEditingController vEmail = TextEditingController();
  TextEditingController vMobile = TextEditingController();
  TextEditingController vehicleNo = TextEditingController();
  TextEditingController locationHai = TextEditingController();
  late AuthBloc bloc;

  @override
  void initState() {
    bloc = AuthBloc(context.read<AuthRepository>());
    super.initState();
    bloc.profile();
    init();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");
  ValueNotifier<String>vehicle=ValueNotifier("");
  ValueNotifier<String>location=ValueNotifier("");

  init()async{
    preferences=await SharedPreferences.getInstance();
    id.value=preferences.getString("id")??'';
    name.value=preferences.getString("name")??'';
    email.value=preferences.getString("email")??'';
    number.value=preferences.getString("phone")??'';
    vehicle.value=preferences.getString("vehicleNo")??'';
    location.value=preferences.getString("location")??'';
  }

  ShowVehicleModel? showVehicleModel;

  bool isSigningOut = false;

  Future<void> backpress(id) async{
    final responce = await http.get(Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Delete_Account_by_id?Uid=$id"));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  Future<List<ShowVehicleModel>> ShowVehicleNumbers(id) async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_Multivehicle_byid?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => ShowVehicleModel.fromJson(e)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Catid>> fetchData(id) async {
    final url = Uri.parse('https://verifyserve.social/WebService1.asmx/Profile?Email=avjit@gmail.com');
    final response = await http.get(url);
    final responce=await http.get(url,);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  // final List<String> vehiclenumbers = [
  //   'HR36JK1010',
  //   'RJ35MK3535',
  //   'HM17PN7070',
  //   'JK27LK5555',
  //   'DL20HG9090',
  // ];

  //Website Link
  _launchURL() async {
    final Uri url = Uri.parse('https://theverify.in/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  _launchURL_one() async {
    final Uri url = Uri.parse('https://theverify.in/contact.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  bool _isDeleting = false;

  //Delete api
  Future<void> DeleteVehicleNumbers(itemId) async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Delete_vehiclework?id=$itemId');
    final response = await http.get(url);
   // await Future.delayed(Duration(seconds: 1));
    if (response.statusCode == 200) {
      setState(() {
        _isDeleting = false;
        ShowVehicleNumbers(id);
        //showVehicleModel?.vehicleNo;
      });
      print(response.body.toString());
      print('Item deleted successfully');
    } else {
      print('Error deleting item. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  // final String apiUrl = 'https://verifyserve.social/WebService3_ServiceWork.asmx/Delete_vehiclework?id='; // Replace with your API endpoint
  //
  // Future<void> deleteItem(String itemId) async {
  //   final response = await http.delete(
  //     Uri.parse('$apiUrl/$itemId'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       // Add any additional headers if required
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Item deleted successfully
  //     print('Item deleted successfully');
  //   } else {
  //     // Error deleting item
  //     print('Error deleting item. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Row(
        //     children: [
        //       SizedBox(
        //         width: 3,
        //       ),
        //       Icon(
        //         PhosphorIcons.caret_left_bold,
        //         color: Colors.white,
        //         size: 30,
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: name,
            builder: (context, String _name,__) {
            return ValueListenableBuilder(
                valueListenable: email,
                builder: (context, String _email,__) {
                return ValueListenableBuilder(
                    valueListenable: number,
                    builder: (context, String _number,__) {
                    return ValueListenableBuilder(
                        valueListenable: vehicle,
                        builder: (context, String _vehicleNumber,__) {
                        return ValueListenableBuilder(
                            valueListenable: location,
                            builder: (context, String _location,__) {
                            return Container(
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Container(
                                    //color: Colors.black,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/bg.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    height: 350,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 60,),

                                        Center(
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage('assets/images/man.png')
                                                //_imageFile == null? AssetImage('assets/images/profile.jpg'): FileImage(file(_imageFile.path)),
                                              ),
                                              // Positioned(
                                              //     bottom: 0,
                                              //     right: 10,
                                              //     child: InkWell(
                                              //       onTap: (){
                                              //         showModalBottomSheet(
                                              //           context: context,
                                              //           builder: ((builder) => bottomSheet()),
                                              //         );
                                              //       },
                                              //       child: Icon(
                                              //         Icons.camera_alt,
                                              //         color: Colors.teal,
                                              //         size: 28,
                                              //       ),
                                              //     )
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Text(_name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                        SizedBox(height: 5,),
                                        Text(_email,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                        SizedBox(height: 5,),
                                        Text(_number,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: 290,
                                      right: 0.0,
                                      left: 0.0,
                                      height: 120,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,right: 20),
                                        padding: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.grey
                                        ),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 110,
                                                      child: Text('Location :',textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1),)),
                                                  SizedBox(width: 10,),
                                                  SizedBox(
                                                      width: 170,
                                                      child: Text(_location,textAlign: TextAlign.right,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                                ],
                                              ),

                                              SizedBox(height: 12,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 110,
                                                      child: Text('Password :',textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1),)),
                                                  SizedBox(width: 10,),
                                                  Text('xxxxxxxx',textAlign: TextAlign.right,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                                ],
                                              ),// Lngitude, latitude bnana h 
                                            ]
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 420,),
                                        /*ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        return ExpandablePanel(
                                          header: Text(items[index].title),
                                          expanded: Column(
                                            children: items[index].subItems.map((subItem) => ListTile(
                                              title: Text(subItem),
                                            )).toList(),
                                          ),
                                        );
                                      },
                                    );*/
                                        // ListView(
                                        //   physics: NeverScrollableScrollPhysics(),
                                        //   shrinkWrap: true,
                                        //   children: <Widget>[
                                        //     ExpansionTile(
                                        //       title: Row(
                                        //         crossAxisAlignment: CrossAxisAlignment.center,
                                        //         mainAxisAlignment: MainAxisAlignment.start,
                                        //         children: [
                                        //           Icon(PhosphorIcons.car,color: Colors.blue),
                                        //           SizedBox(width: 5,),
                                        //           Text("Registered Vehicle's",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0)),
                                        //         ],
                                        //       ),
                                        //       children: <Widget>[
                                        //         // Display user's phone numbers here
                                        //         for (String phoneNumber in vehiclenumbers)
                                        //           ListTile(
                                        //             title: Text(phoneNumber),
                                        //           ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget> [
                                            ExpansionTile(
                                              title: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(PhosphorIcons.car,color: Colors.blue),
                                                  SizedBox(width: 8,),
                                                  Text("Registered Vehicle's",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0)),
                                                ],
                                              ),
                                              children: <Widget>[
                                                ValueListenableBuilder(
                                                    valueListenable: id,
                                                    builder: (context, String iid,__) {
                                                    return FutureBuilder(
                                                      future: ShowVehicleNumbers(iid),
                                                      builder: (context, snapshot) {
                                                        if(snapshot.connectionState == ConnectionState.waiting){
                                                          return Center(child: LinearProgressIndicator());
                                                        }
                                                        else if(snapshot.hasError){
                                                          return Text('${snapshot.error}');
                                                        }
                                                        else if (snapshot.data == null || snapshot.data!.isEmpty) {
                                                          // If the list is empty, show an empty image
                                                          return Center(
                                                            child: Column(
                                                              children: [
                                                              //  Lottie.asset("assets/images/no data.json",width: 450),
                                                                Text("No Vechile Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                        else{
                                                          return _isDeleting
                                                              ? Center(child: RefreshProgressIndicator())
                                                              :
                                                          ListView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: snapshot.data!.length,
                                                            shrinkWrap: true,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                title: Row(
                                                                  children: [
                                                                    Text('${snapshot.data![index].vehicleNo!.toUpperCase()}'),
                                                                    Spacer(),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                          color: Colors.grey.shade100
                                                                      ),
                                                                      child: IconButton(onPressed: (){
                                                                        DeleteVehicleNumbers('${snapshot.data![index].iid}');
                                                                        setState(() {
                                                                          _isDeleting = true;
                                                                        });
                                                                      }, icon: Icon(PhosphorIcons.trash,size: 20,),
                                                                        color: Colors.red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },);
                                                  }
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 15,),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddVehicle()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15,right: 18),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_box_outlined,color: Colors.pinkAccent,),
                                                SizedBox(width: 8,),
                                                Text('Add Vehicle Number',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                                Spacer(),
                                                Icon(PhosphorIcons.caret_right,size: 20,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 15,),
                                        InkWell(
                                          onTap: (){
                                            _launchURL();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15,right: 18),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                //Icon(Icons.open_in_browser,color: Colors.pinkAccent,),
                                                Image.asset("assets/images/web-link.png",width: 25,),
                                                SizedBox(width: 8,),
                                                Text('Verify Website',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                                Spacer(),
                                                Icon(PhosphorIcons.caret_right,size: 20,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 15,),
                                        InkWell(
                                          onTap: (){
                                            _launchURL_one();
                                            /*showTopSnackBar(
                                              context,
                                              const CustomSnackBar.info(
                                                message:
                                                "Coming Soon",
                                              ),);*/
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15,right: 18),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                // Icon(Iconsax.,color: Colors.pinkAccent,),
                                                Image.asset("assets/images/customer-service.png",width: 25,),
                                                SizedBox(width: 8,),
                                                Text('Help & Support',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                                Spacer(),
                                                Icon(PhosphorIcons.caret_right,size: 20,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 15,),
                                        ValueListenableBuilder(
                                            valueListenable: id,
                                            builder: (context, String _id,__) {
                                            return InkWell(
                                              onTap: (){
                                                showDialog<bool>(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Delete Account'),
                                                    content: Text('Do you want to delete this account?'),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        onPressed: () => Navigator.of(context).pop(false),
                                                        child: Text('No'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          backpress(_id);

                                                          scaffoldKey.currentState?.openEndDrawer();
                                                          setState(() {
                                                            isSigningOut = true;
                                                          });
                                                          await Future.delayed(Duration(seconds: 1));
                                                          await FirebaseMessaging.instance.deleteToken();
                                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                                          pref.clear();
                                                          Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
                                                          setState(() {
                                                            isSigningOut = false;
                                                          });

                                                },
                                                        child: Text('Yes'),
                                                      ),
                                                    ],
                                                  ),
                                                ) ?? false;
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(left: 15,right: 18),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    // Icon(Iconsax.,color: Colors.pinkAccent,),
                                                    Image.asset("assets/images/deleteaccount.png",width: 25,),
                                                    SizedBox(width: 8,),
                                                    Text('Delete Your Account',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                                    Spacer(),
                                                    Icon(PhosphorIcons.caret_right,size: 20,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        ),
                                        SizedBox(height: 15,),
                                        Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),

                                        SizedBox(height: 30,),
                                        // GestureDetector(
                                        //   onTap: (){
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) => EditProfilePage()));
                                        //   },
                                        //   child: Center(
                                        //     child: Container(
                                        //       height: 50,
                                        //       width: 200,
                                        //       margin: const EdgeInsets.symmetric(horizontal: 50),
                                        //       decoration: BoxDecoration(
                                        //           borderRadius: BorderRadius.all(Radius.circular(15)),
                                        //           color: Colors.red.withOpacity(0.8)
                                        //       ),
                                        //       child: const Center(
                                        //         child: Text("Edit Profile", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      //  SizedBox(height: 10,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        );
                      }
                    );
                  }
                );
              }
            );
          }
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 20,),
        //       const Center(
        //         child:Text(
        //           "My Profile",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w600,
        //             fontSize: 25,
        //             letterSpacing: 1.2
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 40,),
        //       AppTextField(
        //         onFieldSubmitted: (value) {
        //           vName.text = value;
        //         },
        //         controller: vName,
        //         title: "Name",
        //         showTitle: true,
        //         validate: true,
        //       ),
        //       const SizedBox(height: 10,),
        //       AppTextField(
        //         onFieldSubmitted: (value) {
        //           vEmail.text = value;
        //         },
        //         controller: vEmail,
        //         title: "Email",
        //         showTitle: true,
        //         validate: true,
        //       ),
        //       const SizedBox(height: 10,),
        //       AppTextField(
        //         onFieldSubmitted: (value) {
        //           vMobile.text = value;
        //         },
        //         controller: vMobile,
        //         title: "Mobile",
        //         showTitle: true,
        //         validate: true,
        //       ),
        //       const SizedBox(height: 10,),
        //       AppTextField(
        //         onFieldSubmitted: (value) {
        //           vehicleNo.text = value;
        //         },
        //         controller: vehicleNo,
        //         title: "Vehicle Number",
        //         showTitle: true,
        //         validate: true,
        //       ),
        //       const SizedBox(height: 10,),
        //       AppTextField(
        //         onFieldSubmitted: (value) {
        //           locationHai.text = value;
        //         },
        //         controller: locationHai,
        //         title: "Location",
        //         showTitle: true,
        //         validate: true,
        //       ),
        //       const SizedBox(height: 30,),
        //       Center(
        //         child: Container(
        //           height: 50,
        //           margin: const EdgeInsets.symmetric(horizontal: 50),
        //           decoration: BoxDecoration(
        //               borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        //               color: Colors.red.withOpacity(0.8)
        //           ),
        //           child: const Center(
        //             child: Text("Update Profile", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 0.8,fontSize: 16),),
        //           ),
        //         ),
        //       ),
        //
        //       const SizedBox(height: 20,),
        //
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

/*
class ExpandableListPage extends StatelessWidget {

  Future<List<profilevehiclw>> fetchData() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_Multivehicle_byid?id=1');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => profilevehiclw.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }
*/

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expandable List')),
      body: FutureBuilder<List<profilevehiclw>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ProfilePage(items: snapshot.data!);
          }
        },
      ),
    );
  }
}*/