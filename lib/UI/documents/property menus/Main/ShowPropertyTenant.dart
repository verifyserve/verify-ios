import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../data/model/doctenantSlider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../utils/constant.dart';
import '../Add/add_tenant_servant.dart';
import 'TenantDetails.dart';


class Catid {
  final int id;
  final String Tenant_Name;
  final String Tenant_Number;
  final String Tenant_Rented_Date;
  final String Tenant_Rented_Amount;
  final String Subid;

  Catid(
      {required this.id,required this.Tenant_Name, required this.Tenant_Number, required this.Tenant_Rented_Date, required this.Tenant_Rented_Amount, required this.Subid});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['TUP_id'],
        Tenant_Name: json['Tenant_Name'],
        Tenant_Number: json['Tenant_Number'],
        Tenant_Rented_Date: json['Tenant_Rented_Date'],
        Tenant_Rented_Amount: json['Tenant_Rented_Amount'],
        Subid: json['Subid']);
  }
}

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

class ShowProperty extends StatefulWidget {
  final String iidd;
  const ShowProperty({Key? key, required this.iidd}) : super(key: key);

  State<ShowProperty> createState() => _ShowPropertyState();
}

class _ShowPropertyState extends State<ShowProperty> {
 // late DocumentationBloc bloc;
  List<String> tittle = ["Your Tenant"];
  int? pageIndex=0;
  List<String> gridImages = [
    AppImages.documents,
    AppImages.notification,
    AppImages.realEstate,
    AppImages.vehicle,
    AppImages.insurance,
    AppImages.services,
    AppImages.jobs,
    AppImages.itAndDesigner,
    AppImages.consultantAndLowers,
    AppImages.hotels,
    AppImages.eventsAndWeeding,
    AppImages.trucksAndJcb,
  ];

  @override
  void initState() {
  //  bloc = context.read<DocumentationBloc>();
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
       // isLoading = false;
      });

    });

    init();

  }

  Future<List<Catid>> fetchData(id, owner_num) async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/show_RealEstate_by_subid_ownernumber?Owner_Number=$owner_num&Subid=$id");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Servant>> fetchData1(id) async {
    var url = Uri.parse("https://verifyserve.social/WebService2.asmx/Show_Servant_Detailspage?id="+id);
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Servant.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  //For Tenant Slider
  Future<List<DocumentTenantModel>> fetchCarouselData(id) async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowPropertyImages?Pid=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentTenantModel(
          pimage: item['Pimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");


  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
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
          SizedBox(height: 15,),

          /*FutureBuilder<List<DocumentTenantModel>>(
            future: fetchCarouselData(widget.iidd),
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
                     // Lottie.asset("assets/images/no data.json",width: 450),
                      Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                    ],
                  ),
                );
              }
              else{
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
                              "https://www.verifyserve.social/upload/${item.pimage}",
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
          // bool isLoading = true;
          const SizedBox(height: 20,),*/

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
                      //bloc.yourInfo(widget.data.dTPid);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(left: 10,),
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
          if(pageIndex == 0)
            Expanded(
            child: ValueListenableBuilder(
                valueListenable: number,
                builder: (context, String num,__) {
                return FutureBuilder<List<Catid>>(
                    future: fetchData(widget.iidd, num),
                    builder: (context,abc){
                      if(abc.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      else if(abc.hasError){
                        return Text('${abc.error}');
                      }
                      else if (abc.data == null || abc.data!.isEmpty) {
                        // If the list is empty, show an empty image
                        return Center(
                          child: Column(
                            children: [
                              //Lottie.asset("assets/images/no data.json",width: 450),
                              Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                            ],
                          ),
                        );
                      }
                      else{
                        return ListView.builder(
                            itemCount: abc.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context,int len){
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => details(iidd: abc.data![len].id.toString(), tenant_numm: abc.data![len].Tenant_Number.toString(), subbb_id: abc.data![len].Subid.toString())),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                  child:  Container(
                                                    child: Image.asset(AppImages.tenantprofile,width: 140,height: 100,fit: BoxFit.fill),
                                                  ),
                                                ),
                                                // SizedBox(height: 5,),
                                                // Container(
                                                //   padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(5),
                                                //     border: Border.all(width: 1, color: Colors.green),
                                                //     boxShadow: [
                                                //       BoxShadow(
                                                //           color: Colors.green.withOpacity(0.5),
                                                //           blurRadius: 10,
                                                //           offset: Offset(0, 0),
                                                //           blurStyle: BlurStyle.outer
                                                //       ),
                                                //     ],
                                                //   ),
                                                //   child: Row(
                                                //     children: [
                                                //       Text(""+abc.data![len].type.toUpperCase(),
                                                //         style: TextStyle(
                                                //             fontSize: 12,
                                                //             color: Colors.black,
                                                //             fontWeight: FontWeight.w500,
                                                //             letterSpacing: 0.5
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.user_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Tenant Name",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 140,
                                                  child: Text(
                                                    abc.data![len].Tenant_Name.toUpperCase(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.mobile_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Contact",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Text('+91 '+abc.data![len].Tenant_Number,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.calendar_1_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Date",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 130,
                                                  child: Text(''+abc.data![len].Tenant_Rented_Date,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.money_3_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Rent Amt.",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.currency_rupee_rounded,size: 10,color: Colors.black),
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(''+abc.data![len].Tenant_Rented_Amount,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.green,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );

                            });
                      }
                    }

                );
              }
            ),
          ),
          if(pageIndex == 1)const SizedBox(height: 10,),
          if(pageIndex == 1)
            Expanded(
            child: FutureBuilder<List<Servant>>(
                future: fetchData1(widget.iidd),
                builder: (context,ser){
                  if(ser.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(ser.hasError){
                    return Text('${ser.error}');
                  }
                  else if (ser.data == null || ser.data!.isEmpty) {
                    // If the list is empty, show an empty image
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/images/no data.json",width: 450),
                          Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                        ],
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                        itemCount: ser.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int len){
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              child:  Container(
                                                child: Image.asset(AppImages.servant,width: 120,fit: BoxFit.fill),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.user_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Servant Name",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 140,
                                                  child: Text(''+ser.data![len].Servant_Name.toUpperCase(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.mobile_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Mobile",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text("+91 ",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.red,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    Text(
                                                      ''+ser.data![len].Servant_Number,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.timer_1_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Working Hour's",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 140,
                                                  child: Text(
                                                    ''+ser.data![len].Work_Timing,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(AppImages.work,width: 12,fit: BoxFit.fill,color: Colors.red),
                                                    SizedBox(width: 2,),
                                                    Text("Occupation",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 140,
                                                  child: Text(
                                                    ser.data![len].Servant_Work,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400),),
                                                ),


                                              ],
                                            ),


                                          ],
                                        ),

                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }
            ),

          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Add_Tenant_Servant()));
        },
      ),
    );
  }

}