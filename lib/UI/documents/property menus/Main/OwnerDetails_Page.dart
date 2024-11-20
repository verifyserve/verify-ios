import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../../data/model/tenantpdfModel.dart';
import '../../../../utils/constant.dart';
import '../../Document/pdfscreen.dart';

class Servant {
  //final int id;
  final String Servant_Name;
  final String Servant_Number;
  final String Work_Timing;
  final String Servant_Work;

  Servant(
      {required this.Servant_Name, required this.Servant_Number, required this.Work_Timing, required this.Servant_Work});

  factory Servant.FromJson(Map<String, dynamic>json){
    return Servant(Servant_Name: json['Servant_Name'],
        Servant_Number: json['Servant_Number'],
        Work_Timing: json['Work_Timing'],
        Servant_Work: json['Servant_Work']);
  }
}

class aaaa {
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
        Owner_Email: json['Tenant_Rented_Amount'],
        Property_type: json['Property_Number'],
        PropertyAddress: json['PropertyAddress'],
        Society: json['Tenant_Rented_Date'],
        Place: json['FLoorr']);
  }
}

class Owner_details extends StatefulWidget {
  final String iidd;
  final String Tenant_num;
  final String Owner_Num;
  final String B_Subid;
  const Owner_details({Key? key, required this.iidd, required this.Tenant_num, required this.Owner_Num, required this.B_Subid}) : super(key: key);


  @override
  State<Owner_details> createState() => _Owner_detailsState();
}

class _Owner_detailsState extends State<Owner_details> {
  List<String> tittle = ["OWNER INFO", "DOCUMENTS", "FEILDS"];
  int? pageIndex=0;

  Future<List<TenantPdfModel>> fetchData1(O_num,T_num,subid) async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Verification_document_by_BothNumber_Subid?own_num=${O_num}&tenant_num=${T_num}&Subid=${subid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((e) => TenantPdfModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<aaaa>> fetchData(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Verify_AddTenant_Under_Property_Table?TUP_id=${id}');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
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
        children: [
          SizedBox(height: 10,),
          Image.asset(AppImages.documents),
          const SizedBox(height: 20,),
          SizedBox(
            height: 40,
            child: ListView.builder(
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
                      //itemCount: abc.data!.length,
                        itemCount: 1,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int len) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Owner Name",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          // const Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.asset(
                                                  AppImages.verify,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Contact",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          // Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.phone,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Number,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.email,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Email,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.location_on,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text("Property Type   "+snapshot.data![len].Property_type,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Property Address",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          // Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.home,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].PropertyAddress,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.home_work,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Society,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.location_on,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Place,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
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
                  FutureBuilder<List<TenantPdfModel>>(
                    future: fetchData1(widget.Owner_Num,widget.Tenant_num,widget.B_Subid),
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
                                      builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/Done_Verification/${snapshot.data![index].documentPDF}'),
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
                                                  child: Text('${snapshot.data![index].documentname}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
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
                  ))
          ),
          if(pageIndex == 2)SizedBox(
            height: 20,
          ),
          if(pageIndex == 2)Column(
            children: [
              Expanded(
                child:
                /* FutureBuilder<List<Servant>>(
                    future: fetchData1(widget.iidd,widget.num),
                    builder: (context,ser){
                      if(ser.hasData){
                        return  ListView.builder(
                            itemCount: ser.data!.length,
                            // itemCount: 1,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context,int len){
                              return GestureDetector(

                                onTap: () {

                                },

                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [

                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 5, bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Image(
                                                    image: AssetImage('assets/images/image_not_found.png'),
                                                    height: 75,
                                                    width: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(//'   '+ser.data![len].Servant_Name,
                                                        'hlo',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      //'   +91 '+ser.data![len].Servant_Number,
                                                      'hlo',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                       // '   '+ser.data![len].Work_Timing,
                                                        'hlo',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white,
                                                          // fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      //ser.data![len].Servant_Work,
                                                      'hlo',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              );

                            });
                      }
                      else if(ser.hasError){
                        return Text(ser.error.toString());

                      }
                      return const LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }

                ),*/
                Center(child: Text('Hello',style: TextStyle(color: Colors.white)),)
              ),
            ],
          ),
        ],
      ),
    );
  }
}