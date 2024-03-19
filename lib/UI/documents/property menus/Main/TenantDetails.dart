import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/model/doctenantdetailsSlider.dart';
import '../../../../data/model/pdfModel.dart';
import '../../../../data/model/tenantpdfModel.dart';
import '../../../../utils/constant.dart';
import '../../../widgets/top_snackbar/top_snack_bar.dart';
import '../../Document/pdfscreen.dart';
import '../../document_screen.dart';


class aaaa {
  final int id;
  final String Tenant_Name;
  final String Tenant_Number;
  final String Tenant_Email;
  final String About_tenant;
  final String Tenant_Rented_Date;
  final String Tenant_Rented_Amount;
  final String Tenant_WorkProfile;

  aaaa(
      {required this.id, required this.Tenant_Name, required this.Tenant_Number, required this.Tenant_Email, required this.About_tenant,
        required this.Tenant_Rented_Date, required this.Tenant_Rented_Amount, required this.Tenant_WorkProfile});

  factory aaaa.FromJson(Map<String, dynamic>json){
    return aaaa(id: json['DTR_id'],
        Tenant_Name: json['Tenant_Name'],
        Tenant_Number: json['Tenant_Number'],
        Tenant_Email: json['Tenant_Email'],
        About_tenant: json['About_tenant'],
        Tenant_Rented_Date: json['Tenant_Rented_Date'],
        Tenant_Rented_Amount: json['Tenant_Rented_Amount'],
        Tenant_WorkProfile: json['Tenant_WorkProfile'],
    );
  }
}

/*class aaaa {
  //final int id;
  final String Owner_Name;
  final String Owner_Number;
  final String Owner_Email;
  final String Property_type;
  final String PropertyAddress;
  final String Society;
  final String Place;

  aaaa(
      {required this.Owner_Name, required this.Owner_Number, required this.Owner_Email, required this.Property_type,
        required this.PropertyAddress, required this.Society, required this.Place});

  factory aaaa.FromJson(Map<String, dynamic>json){
    return aaaa(Owner_Name: json['Owner_Name'],
        Owner_Number: json['Owner_Number'],
        Owner_Email: json['Owner_Email'],
        Property_type: json['Property_type'],
        PropertyAddress: json['PropertyAddress'],
        Society: json['Society'],
        Place: json['Place']);
  }
}*/

class details extends StatefulWidget {
  final String iidd;
  const details({Key? key, required this.iidd}) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {

  /*Future<List<aaaa>> fetchData(id) async {
    var url = Uri.parse("https://verifyserve.social/WebService1.asmx/Show_Documaintation_Byid?id=$id");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }*/

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

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

  Future<void> fetchdata(document_name,Owner_name,Owner_number,Owner_email,Tenant_id) async{
    final responce = await http.get(Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Submit_Request_for_Documaintation?Document_name=$document_name&Owner_name=$Owner_name&Owner_number=$Owner_number&Owner_email=$Owner_email&Tenant_id=$Tenant_id"));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  //For Tenant Details Slider
  Future<List<DocumentTenantDetailsModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowTenantImages?Tid=3'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentTenantDetailsModel(
          timage: item['Timage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<aaaa>> fetchData(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService2.asmx/Show_Tenants_Detailspage?id=$id');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body.toString());
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<aaaa>> fetchData_delete(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService2.asmx/Delete_Tenant_byid?id=$id');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body.toString());
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  //For PDF
  TenantPdfModel? tenantPdfModel;

  Future<List<TenantPdfModel>> fetchpdf(id,owner_no) async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_Documnet_UnderTenant?Tenant_id=$id&Owner_number=$owner_no');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((e) => TenantPdfModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  List<String> tittle = ["TENANT INFO", "YOUR DOC's", "DOCUMENTS"];
  int? pageIndex=0;
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
        actions: [
          InkWell(
              onTap: (){
                fetchData_delete(widget.iidd);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DocumentScreen(),), (route) => route.isFirst);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Recent()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 7,top: 5),
                child: Row(
                  children: [
                    Icon(Icons.delete,size: 30,),
                  ],
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          FutureBuilder<List<DocumentTenantDetailsModel>>(
            future: fetchCarouselData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available.'));
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                  ),
                  items: snapshot.data!.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return  Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 320.w,
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl:
                              "https://www.verifyserve.social/upload/${item.timage}",
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
                        );
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 40,
            child: ListView.builder(
              //itemCount: 1,
              itemCount: tittle.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pageIndex = index;
                    if(pageIndex == 1){
                     // bloc.yourInfo(widget.data.dTPid);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color:
                        pageIndex == index ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      tittle[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: pageIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if(pageIndex == 0)Expanded(
              child: FutureBuilder<List<aaaa>>(
                  future: fetchData(widget.iidd),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    }
                    else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      // If the list is empty, show an empty image
                      return Center(
                        child: Column(
                          children: [
                           // Lottie.asset("assets/images/no data.json",width: 450),
                            Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                          ],
                        ),
                      );
                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int len) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Iconsax.user_octagon_copy,size: 17,color: Colors.green,),
                                            SizedBox(width: 2,),
                                            Text("Tenant Name",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey.shade50,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Icon(Iconsax.user_copy,size: 16,)),
                                                  const SizedBox(width: 5,),
                                                  Text(snapshot.data![len].Tenant_Name.toUpperCase(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey.shade50,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Image.asset(AppImages.work,width: 16,fit: BoxFit.fill,color: Colors.black)),
                                                  const SizedBox(width: 5,),
                                                  Text(snapshot.data![len].Tenant_WorkProfile,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              // const SizedBox(height: 5,),
                                              // Row(
                                              //   children: [
                                              //     Align(
                                              //       alignment: Alignment.center,
                                              //       child: Container(
                                              //           padding: EdgeInsets.all(5),
                                              //           decoration: BoxDecoration(
                                              //             color: Colors.blueGrey.shade50,
                                              //             borderRadius: BorderRadius.circular(10),
                                              //             border: Border.all(width: 1, color: Colors.blueGrey),
                                              //           ),
                                              //           child: Icon(Iconsax.message_2_copy,size: 16,)),
                                              //     ),
                                              //     const SizedBox(width: 5),
                                              //     Expanded(
                                              //       child: SizedBox(
                                              //         width: double.infinity,
                                              //         child: Text('', //snapshot.data![len].About_tenant
                                              //           textAlign: TextAlign.left,
                                              //           maxLines: 6,
                                              //           style: TextStyle(
                                              //               fontSize: 14,
                                              //               color: Colors.black,
                                              //               fontWeight: FontWeight.w400),
                                              //         ),
                                              //       ),
                                              //     )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 0,),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Iconsax.mobile_copy,size: 17,color: Colors.green,),
                                            SizedBox(width: 2,),
                                            Text("Contact Details",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey.shade50,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Icon(PhosphorIcons.phone_call,size: 20,)),
                                                  const SizedBox(width: 5,),
                                                  Text(snapshot.data![len].Tenant_Number,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.blueGrey.shade50,
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Image.asset(AppImages.email,width: 20,fit: BoxFit.fill,color: Colors.black)),
                                                  const SizedBox(width: 5,),
                                                  Text(snapshot.data![len].Tenant_Email,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 0,),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Iconsax.money_3_copy,size: 17,color: Colors.green,),
                                            SizedBox(width: 2,),
                                            Text("Rent Details",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey.shade50,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Icon(PhosphorIcons.currency_inr,size: 20,)),
                                                  const SizedBox(width: 5,),
                                                  Text("₹ "+snapshot.data![len].Tenant_Rented_Amount,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey.shade50,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(width: 1, color: Colors.blueGrey),
                                                      ),
                                                      child: Icon(Iconsax.calendar_1_copy,size: 20,)),
                                                  const SizedBox(width: 5),
                                                  Text(snapshot.data![len].Tenant_Rented_Date+" (Due Date)",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              ),
          ),
          if(pageIndex == 1)const SizedBox(height: 10,),
          if(pageIndex == 1)Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: // GestureDetector(
                //   onTap: ()async {
                //     final imageProvider =
                //         /*Image.network("http://www.verifyserve.social/upload/${data.first.addharcard}").image;*/
                //     Image.network("hhttps://verifyserve.social/upload/DJ.jpg"
                //     ).image;
                //     showImageViewer(context, imageProvider,
                //         onViewerDismissed: () {
                //           print("dismissed");
                //         });
                //   },
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: CachedNetworkImage(
                //       imageUrl:
                //       "https://verifyserve.social/upload/DJ.jpg",
                //
                //       height: 170,
                //       fit: BoxFit.cover,
                //       placeholder: (context, url) => Image.asset(
                //         AppImages.loading,
                //         height: 170,
                //         fit: BoxFit.cover,
                //       ),
                //       errorWidget: (context, error, stack) =>
                //           Image.asset(
                //             AppImages.imageNotFound,
                //             height: 170,
                //             fit: BoxFit.cover,
                //           ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20,),
                // GestureDetector(
                //   onTap: () async{
                //     final imageProvider =
                //         Image.network("https://verifyserve.social/upload/creta.jpg").image;
                //     showImageViewer(context, imageProvider,
                //         onViewerDismissed: () {
                //           print("dismissed");
                //         });
                //   },
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: CachedNetworkImage(
                //       imageUrl:
                //       "https://verifyserve.social/upload/creta.jpg",
                //
                //       height: 170,
                //       fit: BoxFit.cover,
                //       placeholder: (context, url) => Image.asset(
                //         AppImages.loading,
                //         height: 170,
                //         fit: BoxFit.cover,
                //       ),
                //       errorWidget: (context, error, stack) =>
                //           Image.asset(
                //             AppImages.imageNotFound,
                //             height: 170,
                //             fit: BoxFit.cover,
                //           ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20,),
                // GestureDetector(
                //   onTap: ()async  {
                //     final imageProvider =
                //         Image.network("https://verifyserve.social/upload/cook.jpg").image;
                //     showImageViewer(context, imageProvider,
                //       onViewerDismissed: () {
                //         print("dismissed");
                //       },
                //
                //     );
                //
                //   },
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: CachedNetworkImage(
                //       imageUrl:
                //       "https://verifyserve.social/upload/cook.jpg",
                //       height: 170,
                //       fit: BoxFit.cover,
                //       placeholder: (context, url) => Image.asset(
                //         AppImages.loading,
                //         height: 170,
                //         fit: BoxFit.cover,
                //       ),
                //       errorWidget: (context, error, stack) =>
                //           Image.asset(
                //             AppImages.imageNotFound,
                //             height: 170,
                //             fit: BoxFit.cover,
                //           ),
                //     ),
                //   ),
                // ),
                ValueListenableBuilder(
                    valueListenable: number,
                    builder: (context, String num,__) {
                      return FutureBuilder<List<TenantPdfModel>>(
                        future: fetchpdf(widget.iidd,num),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
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
                                  Center(child: Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                                ],
                              ),
                            );
                          }
                          else{
                            return Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/upload/${snapshot.data![index].documentPDF}'),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 15,left: 10,top: 15,bottom: 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            border: Border.all(width: 1, color: Colors.grey),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                              Icon(PhosphorIcons.file_pdf,color: Colors.redAccent,),
                                              SizedBox(width: 20,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: 150,
                                                      child: Text('${snapshot.data![index].documentName}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                                ],
                                              ),
                                              Spacer(),
                                              Icon(PhosphorIcons.paperclip,color: Colors.white,)
                                              // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                            ],
                                          ),
                                        )
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      );
                    }
                  ))
          ),
          if(pageIndex == 2)SizedBox(
            height: 20,
          ),
          if(pageIndex == 2)Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, String n,__) {
                    return ValueListenableBuilder(
                        valueListenable: email,
                        builder: (context, String e,__) {
                        return ValueListenableBuilder(
                            valueListenable: number,
                            builder: (context, String num,__) {
                            return Row(
                              children: [
                                Icon(Icons.play_arrow,color: Colors.white,),
                                SizedBox(width: 5,),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      fetchdata("Rent Agreement", n, e, num, widget.iidd);
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.info(
                                          message:
                                          "Query Send, we will contact you soon!",
                                        ),);
                                    },
                                    child: Text("Rent Agreement",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  ),
                                )
                              ],
                            );
                          }
                        );
                      }
                    );
                  }
                ),
              )
            ],
          ),
          if(pageIndex == 2)Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, String n,__) {
                      return ValueListenableBuilder(
                          valueListenable: email,
                          builder: (context, String e,__) {
                            return ValueListenableBuilder(
                                valueListenable: number,
                                builder: (context, String num,__) {
                                  return Row(
                                    children: [
                                      Icon(Icons.play_arrow,color: Colors.white,),
                                      SizedBox(width: 5,),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            fetchdata("Police Verification", n, e, num, widget.iidd);
                                            showTopSnackBar(
                                              context,
                                              CustomSnackBar.info(
                                                message:
                                                "Query Send, we will contact you soon!",
                                              ),);
                                          },
                                          child: Text("Police Verification",style: TextStyle(
                                              color: Colors.white
                                          ),),
                                        ),
                                      )
                                    ],
                                  );
                                }
                            );
                          }
                      );
                    }
                ),
              )
            ],
          ),
        ],
      ),

    );
  }
}
