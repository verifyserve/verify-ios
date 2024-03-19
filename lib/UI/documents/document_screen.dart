import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/documents/Document/ServantTab.dart';
import 'package:verify/UI/documents/addProperty.dart';
import 'package:verify/UI/documents/employe%20menus/employee_list.dart';
import 'package:verify/UI/documents/property%20menus/Main/OwnerDetails_Page.dart';
import 'package:verify/UI/documents/property%20menus/flat_list.dart';
import 'package:verify/UI/home/home_screen.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/data/model/showEmployeeType.dart';
import 'package:verify/data/repository/DocumentationRepository.dart';
import 'package:verify/utils/constant.dart';
import 'package:verify/utils/message_handler.dart';
import 'package:http/http.dart' as http;

import '../../data/model/docpropertySlider.dart';
import 'Document/documenttab.dart';

class Catid{
  final int id;
  final String Owner_Name;
  final String Owner_Number;
  final String Owner_Email;
  final String Tenant_num;
  Catid({required this.id,required this.Owner_Name,required this.Owner_Number,required this.Owner_Email,required this.Tenant_num});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(id: json['Subid'],Owner_Name: json['Owner_Name'],Owner_Number: json['Owner_Number'],Owner_Email: json['Owner_Email'],Tenant_num: json['Owner_Number']);

  }
}

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {

  late DocumentationBloc bloc;

  int pageIndex = 0;
  // List<String> status = [
    // 'FLAT',
    // 'SHOP',
    // 'SHOWROOM',
    // 'WAREHOUSE',
    // 'FLOOR',
    // 'BASEMENT',
    // 'ROOFS',
    // 'HOMES',
  // ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
  }

  @override
  void initState() {
    bloc = DocumentationBloc(context.read<DocumentationRepository>());
    super.initState();
    bloc.DocumentationStream.stream.listen((event) {
      if(event=="POP"){
        Navigator.pop(context);
        // bloc.init();
        // bloc.showDocument();
        // bloc.showTenant(bloc.status.value.first);
      }
    });
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.topListList();
    bloc.showDocument();
    bloc.showEmployeeData();
    // bloc.init();
    init();
    _loaduserdata();
  }

  String _data = '';

  List ownerdata = [];

  Future<List<Catid>> fetchData(id) async{
    var url=Uri.parse("https://verifyserve.social/WebService2.asmx/Show_Ownerdetail_TenantProfile?number=$_data");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      ownerdata=json.decode(responce.body);
      return ownerdata.map((data) => Catid.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  //For Documentation Main Slider
  Future<List<DocumentMainModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowDocumentimg'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentMainModel(
          dimage: item['Dimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
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

            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
            //     HomeScreen()),(Route<dynamic> route) => false);

            Navigator.pop(context,true);
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
        // actions: [
        //   if (pageIndex == 1 || pageIndex == 0)
        //     GestureDetector(
        //       onTap: () async {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   Provider.value(
        //                     value: bloc,
        //                     child: AddProperty(
        //                       id: pageIndex,
        //                     ),
        //                   ),
        //           ),
        //         );
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.only(top: 5, right: 5),
        //         child: Column(
        //           children: [
        //             // const SizedBox(height:5),
        //             const Icon(
        //               PhosphorIcons.plus_bold,
        //               color: Colors.white,
        //               size: 30,
        //             ),
        //             Text(
        //               pageIndex == 0 ? "Property Field" : "Employee Field",
        //               textAlign: TextAlign.center,
        //               style: const TextStyle(color: Colors.white, fontSize: 10),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        // ],
      ),
      body: ValueListenableBuilder(
          valueListenable: number,
          builder: (context, String num,__) {
          return ValueListenableBuilder(
              valueListenable: bloc.topListLoader,
              builder: (context, bool loading, _) {
                if (loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  FutureBuilder<List<DocumentMainModel>>(
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
                                      "https://www.verifyserve.social/upload/${item.dimage}",
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
                            itemCount: bloc.topList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async{
                                  pageIndex = index;
                                  print("${pageIndex} ${bloc.type.value}");
                                  if(index == 1){
                                    if(bloc.showEmployeeLists.value.isNotEmpty){
                                      bloc.type.value = bloc.showEmployeeLists.value.first.pname?? "";
                                      bloc.showEmployeeIndex.value = 0;
                                      print("objectss ${bloc.showEmployeeLists.value.first.pname}");
                                      print(bloc.type.value);
                                      await bloc.showEmployee(bloc.showEmployeeLists.value.first.pname ?? "");
                                    }
                                  }

                                  /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FlatDetails(iidd: abc.data![len].id.toString()))

                                  );*/

                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          pageIndex == index ? Colors.red : Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    bloc.topList[index].stCname ?? "",
                                    style: TextStyle(
                                        color: pageIndex == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                 if (pageIndex == 2)
                    const SizedBox(
                      height: 10,
                    ),
                  if (pageIndex == 2)
                        Container(
                          child: FutureBuilder<List<Catid>>(
                              future: fetchData(""+1.toString()),
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
                                       // Lottie.asset("assets/images/no data.json",width: 450),
                                        Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  return  Expanded(
                                    child: ListView.builder(
                                      //itemCount: abc.data!.length,
                                        itemCount: abc.data!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (BuildContext context,int len){
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Owner_details(iidd: abc.data![len].id.toString(), num: abc.data![len].Tenant_num.toString()))
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(0.6),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
                                                            height: 75.h,
                                                            width: 120.w,
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
                                                              width: 140,
                                                              child: Text(" Name:- "+
                                                                  abc.data![len].Owner_Name,
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
                                                            Text(" Number:- "+
                                                                abc.data![len].Owner_Number,
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
                                                              width: 140,
                                                              child: Text(" Email:- "+
                                                                  abc.data![len].Owner_Email,
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
                                                              'Owner',
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


                                          );

                                        }),

                                  );
                                }
                              }
                              ),
                        ),

                  if (pageIndex == 0)
                    const SizedBox(
                      height: 20,
                    ),
                  if (pageIndex == 0)
                    Expanded(
                      child: Column(
                        children: [
                          // ValueListenableBuilder(
                          //     valueListenable: bloc.showPropertyList,
                          //     builder:
                          //         (context, List<ShowEmployeeType> propertyList, _) {
                          //       return Container(
                          //         padding: const EdgeInsets.symmetric(horizontal: 20),
                          //         height: 55,
                          //         decoration: BoxDecoration(
                          //             borderRadius: const BorderRadius.only(
                          //                 topLeft: Radius.circular(40),
                          //                 topRight: Radius.circular(40)),
                          //             color: Colors.white.withOpacity(0.8)),
                          //         child: ListView.builder(
                          //           itemCount: propertyList.length,
                          //           scrollDirection: Axis.horizontal,
                          //           itemBuilder: (context, index) {
                          //             return Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 GestureDetector(
                          //                   onTap: () async {
                          //                     bloc.showPropertyIndex.value = index;
                          //                     bloc.type.value = propertyList[index].pname ?? "";
                          //                     await bloc.showTenant(propertyList[index].pname);
                          //                   },
                          //                   child: Container(
                          //                       padding: const EdgeInsets.symmetric(vertical: 10),
                          //                       margin: const EdgeInsets.only(right: 20),
                          //                       child:
                          //                       ValueListenableBuilder(
                          //                         valueListenable: bloc.showPropertyIndex,
                          //                         builder: (context, int? propertyIndex, child) {
                          //                           return Text(propertyList[index].pname ?? "",
                          //                           style: TextStyle(
                          //             color:propertyIndex == index ? Colors.red : Colors.black,
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500));
                          //                         },),
                          //                 ),),
                          //               ],
                          //             );
                          //           },
                          //         ),
                          //       );
                          //     }),
                          ValueListenableBuilder(
                            valueListenable: bloc.status,
                            builder: (context,List<String> loading,_) {
                              return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      height: 5,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40)),
                                          color: Colors.black),
                                      child: ListView.builder(
                                        itemCount: loading.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  bloc.showPropertyIndex.value = index;
                                                  bloc.type.value = loading[index] ?? "";
                                                  await bloc.showTenant(loading[index]);
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    margin: const EdgeInsets.only(right: 20),
                                                    child:
                                                    ValueListenableBuilder(
                                                      valueListenable: bloc.showPropertyIndex,
                                                      builder: (context, int? propertyIndex, child) {
                                                        return Text(loading[index] ?? "",
                                                        style: TextStyle(
                                                            color:propertyIndex == index ? Colors.red : Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500));
                                                        },),
                                              ),),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                            }
                          ),
                          ValueListenableBuilder(valueListenable: bloc.tenantLoader, builder: (context, bool loading, child) {
                           if(loading){
                             return Expanded(child: Container(
                               width: 1.sw,
                               color: Colors.white,
                               child: const Center(child: CircularProgressIndicator(color: Colors.black,)),
                             ));
                           }
                            return Expanded(
                              child: Provider.value(value: bloc,
                                child:
                                FlatList()
                                ,),
                            );
                          },),
                        ],
                      ),
                    ),


                  if (pageIndex == 1)
                    const SizedBox(
                      height: 20,
                    ),
                  if (pageIndex == 1)
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          backgroundColor: Colors.black,
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20), color: Colors.grey),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                      color: Colors.red[500],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    tabs: [
                                      Tab(text: 'Documents'),
                                      Tab(text: 'Servant'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(children: [
                                    DocumentTab(),
                                    ServantTab()
                                  ]
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )

                    ),
                    // Expanded(
                    //   child: Container(
                    //     height: 1.sw,
                    //     decoration: BoxDecoration(
                    //         borderRadius: const BorderRadius.only(
                    //             topLeft: Radius.circular(40),
                    //             topRight: Radius.circular(40)),
                    //         color: Colors.white.withOpacity(0.9)),
                    //     child: Column(
                    //       children: [
                    //         SizedBox(
                    //           height: 55,
                    //           child: TabBar(
                    //             isScrollable: true,
                    //             controller: _tabController,
                    //             tabs: const [
                    //               Text("EMPLOYEE",
                    //                   style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400)),
                    //               Text("SERVENT",
                    //                   style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400)),
                    //               Text("WORKER",
                    //                   style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400)),
                    //               Text("CUSTOMER",
                    //                   style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400)),
                    //               Text("STUDENTS",
                    //                   style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400)),
                    //             ],
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: SizedBox(
                    //             height: 1.sh,
                    //             child: TabBarView(
                    //               controller: _tabController,
                    //               children: const [
                    //                 EmployeeList(),
                    //                 EmployeeList(),
                    //                 EmployeeList(),
                    //                 EmployeeList(),
                    //                 EmployeeList(),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                ],
              );
            }
          );
        }
      ),
      /*floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(pageIndex == 1||pageIndex == 0)FloatingActionButton(

            onPressed: () async{
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  AddProperty(id: pageIndex,)),
              );
              },
              backgroundColor: const  Color(0xFF009FE3),
            child: const Icon(
              PhosphorIcons.plus,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),*/
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _data = prefs.getString('login_number') ?? '';
    });


  }

}
