import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verify/UI/realEstate/youtube_player.dart';
import 'package:verify/bloc/realEstateBloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../data/model/realestateSlider.dart';
import '../../utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=ntb61YXCBF8'
];

class Catid {
  final int id;
  final String Building_Name;
  final String Building_Address;
  final String Building_Location;
  final String Building_image;
  final String Longitude;
  final String Latitude;
  final String Rent;
  final String Verify_price;
  final String BHK;
  final String sqft;
  final String tyope;
  final String floor_ ;
  final String maintence ;
  final String buy_Rent ;
  final String Building_information;
  final String Parking;
  final String balcony;
  final String facility;
  final String Furnished;
  final String kitchen;
  final String Baathroom;
  final String Ownername;
  final String Owner_number;
  final String Caretaker_name;
  final String Price;
  final String Caretaker_number;
  final String Details;
  final String youtube;

  Catid(
      {required this.id, required this.Building_Name, required this.Building_Address, required this.Building_Location, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.sqft, required this.tyope, required this.floor_, required this.maintence, required this.buy_Rent,
        required this.Building_information,required this.balcony,required this.Parking,required this.facility,required this.Furnished,required this.kitchen,required this.Baathroom,required this.Ownername,required this.Owner_number,
        required this.Caretaker_name, required this.Price ,required this.Caretaker_number, required this.Details, required this.youtube});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['PVR_id'],
        Building_Name: json['Building_information'],
        Building_Address: json['Address_'],
        Building_Location: json['Place_'],
        Building_image: json['Realstate_image'],
        Longitude: json['Longtitude'],
        Latitude: json['Latitude'],
        Rent: json['Property_Number'],
        Verify_price: json['Gas_meter'],
        BHK: json['Bhk_Squarefit'],
        sqft: json['City'],
        tyope: json['Typeofproperty'],
        floor_: json['floor_'],
        maintence: json['maintenance'],
        buy_Rent: json['Buy_Rent'],
        Building_information: json['Building_information'],
        balcony: json['balcony'],
        Parking: json['Parking'],
        facility: json['Lift'],
        Furnished: json['Furnished'],
        kitchen: json['kitchen'],
        Baathroom: json['Baathroom'],
        Ownername: json['Ownername'],
        Owner_number: json['Owner_number'],
        Caretaker_name: json['Water_geyser'],
        Price: json['Price'],
        Caretaker_number: json['CareTaker_number'],
        Details: json['Details'],
        youtube: json['Security_guard']);
  }
}



class RealEstateDetaill extends StatefulWidget {
  final String iid;
  RealEstateDetaill({super.key, required this.iid});

  @override
  State<RealEstateDetaill> createState() => _RealEstateDetaillState();
}

class _RealEstateDetaillState extends State<RealEstateDetaill> {

  //late TabController _tabController;

  final TextEditingController _Bidprice = TextEditingController();

  Future<void> fetchdata(iid,number,propertyid,title,amount,bidprice) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/AddRealstateBuyer?buyer_id=$iid&buyer_number=$number&property_id=$propertyid&property_title=$title&property_amount=$amount&make_an_offer=$bidprice'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  Future<List<Catid>> fetchData1() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_proprty_realstate_by_originalid?PVR_id=${widget.iid}');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> openYouTubeVideo(String videoId) async {
    final url = '$videoId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20,),
          // Add your content for the bottom sheet here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 5,top: 20),
                  child: Text('Enter Your Demand',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _Bidprice,
                  decoration: InputDecoration(
                      hintText: "Enter Your Demand For Search Property",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 40,),

              Center(
                child: Container(
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
                      //fetchdata(iidd,num, bloc.buyRentDetailsData.first.tPid, bloc.buyRentDetailsData.first.tital, bloc.buyRentDetailsData.first.priceh, _Bidprice.text);
                      Navigator.pop(context);

                      Fluttertoast.showToast(
                          msg: "We will contact you soon!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    }, child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
                  ),
                  ),

                ),
              ),

              Container(
                  padding: EdgeInsets.only(left: 5,top: 20),
                  child: Center(child: Text('Enter Your Bid Amount Our Team Contact You with in 24 Hours on Your Register Mobile Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),))),

            ],
          ),
        );
      },
    );
  }

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://youtu.be/ntb61YXCBF8");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    //_tabController = TabController(length: 2, vsync: ,);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //For Real Estate Slider
  Future<List<RealEstateSlider>> fetchCarouselData(id) async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Image_under_Realestatet?id_num=${id}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return RealEstateSlider(
          rimg: item['imagepath'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _shareProduct(BuildContext context) async {

    final result = await fetchData1();

    //final String text = 'Check out this Property: ${result.first.Building_information}& com.verifyapzotech.verify://product/details?id=${widget.iid}';
    final String text = 'Check out this Property in Verify Real Estate: https://theverify.in/FlatDetail.html?PVR_id=${widget.iid}';
    Share.share(text);


  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          actions:  [
            GestureDetector(
              onTap: () async {
                _shareProduct(context);
              },
              child: const Icon(
                PhosphorIcons.share,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // CachedNetworkImage(
                  //   imageUrl:
                  //   "http://www.verifyserve.social/upload/${bloc.buyRentDetailsData.first.imagesh}",
                  //   width: 1.sw,
                  //   height: 0.3.sh,
                  //   fit: BoxFit.fill,
                  //   placeholder: (context, url) => Image.asset(
                  //     AppImages.loading,
                  //     width: 1.sw,
                  //     height: 0.3.sh,
                  //     fit: BoxFit.fill,
                  //   ),
                  //   errorWidget: (context, error, stack) =>
                  //       Image.asset(
                  //         AppImages.imageNotFound,
                  //         width: 1.sw,
                  //         height: 0.3.sh,
                  //         fit: BoxFit.fill,
                  //       ),
                  // ),
                  /*Image.network(
                          "http://www.verifyserve.social/upload/${bloc.buyRentDetailsData.first.imagesh}",
                          width: 1.sw,
                          height: 0.3.sh,
                          fit: BoxFit.fill,
                        ),*/
                  FutureBuilder<List<RealEstateSlider>>(
                    future: fetchCarouselData(widget.iid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('No data available.'));
                      } else {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height:  0.3.sh,
                            enlargeCenterPage: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                          ),
                          items: snapshot.data!.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 0),
                                  width: 1.sw,
                                  height:  0.3.sh,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      //'https://verifyserve.social/uploads/IMG-20240802-WA0008.jpg',
                                      "https://www.verifyserve.social/${item.rimg}",
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Image.asset(
                                        AppImages.loading,
                                        fit: BoxFit.fill,
                                      ),
                                      errorWidget: (context, error, stack) =>
                                          Image.asset(
                                            AppImages.imageNotFound,
                                            fit: BoxFit.fill,
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

                  FutureBuilder<List<Catid>>(
                      future: fetchData1(),
                      builder: (context,abc){
                        if(abc.connectionState == ConnectionState.waiting){
                          return Center(child: Text(""));
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
                                Text("",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              ],
                            ),
                          );
                        }
                        else {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: abc.data!.length,
                              itemBuilder: (BuildContext context,int len) {
                                if('${abc.data![len].youtube}' == "V"){
                                  return Center(child: Text(""));
                                }
                                else {
                                  return Container(
                                    padding: EdgeInsets.only(left: 10,top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Positioned(
                                            top: 30,
                                            left: 20,
                                            child: GestureDetector(
                                                onTap: () {
                                                  //Navigator.pop(context);
                                                  openYouTubeVideo('${abc.data![len].youtube}');
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: Icon(
                                                    PhosphorIcons.youtube_logo,
                                                    color: Colors.white,

                                                  ),
                                                )
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                }

                              }
                          );
                        }

                      }
                  ),


                ],
              ),
              SizedBox(
                height: 10,
              ),
              /*FutureBuilder<List<Catid>>(
                  future: fetchData1(),
                  builder: (context,abcd){
                    if(abcd.connectionState == ConnectionState.waiting){
                      return Center(child: Text(""));
                    }
                    else if(abcd.hasError){
                      return Text('${abcd.error}');
                    }
                    else if (abcd.data == null || abcd.data!.isEmpty) {
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
                    *//*else {
                      return
                        Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: videoUrls.length,
                            itemBuilder: (BuildContext context,int len) {
                              final videoID = YoutubePlayer.convertUrlToId(videoUrls[len]);

                              return InkWell(
                                  onTap: (){
                                    openYouTubeVideo('${abc.data![len].youtube}');
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PLayerScreen(videoId: videoID)));
                                  },
                                  child:
                                  Image.network(YoutubePlayer.getThumbnail(videoId: videoID!)));
                            }
                      ),
                        );
                    }*//*

                  }

              ),*/

              FutureBuilder<List<Catid>>(
                  future: fetchData1(),
                  builder: (context,abc){
                    if(abc.connectionState == ConnectionState.waiting){
                      return Center(child: Text(""));
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
                    else {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: abc.data!.length,
                          itemBuilder: (BuildContext context,int len) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: 10,),

                                  Text(
                                    "${abc.data![len].tyope}  ${abc.data![len].BHK} For ${abc.data![len].buy_Rent} in  ${abc.data![len].Building_Location}" ,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1, color: Colors.cyanAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.cyanAccent.withOpacity(0.5),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                // Icon(Iconsax.sort_copy,size: 15,),
                                                //SizedBox(width: 10,),
                                                Text(""+abc.data![len].Building_Location/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.5
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            width: 10,
                                          ),

                                          Container(
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1, color: Colors.lightGreenAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.lightGreenAccent.withOpacity(0.5),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                // Icon(Iconsax.sort_copy,size: 15,),
                                                //SizedBox(width: 10,),
                                                Text("For "+abc.data![len].buy_Rent/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.5
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    "Building Information",
                                    style: TextStyle(color: Colors.orange, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 280,
                                                child: Text(""+abc.data![len].Building_information,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 15,
                                                  style: TextStyle(
                                                      fontSize: 14,

                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    abc.data![len].facility ?? "",
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(width: 2,),
                                      Text("Floor | Maintaince Cost",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Text(""+abc.data![len].floor_+"  |  "+abc.data![len].maintence+" Maintaince Cost",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(width: 2,),
                                      Text("Kitchen | Bathroom",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Text(""+abc.data![len].kitchen+" Kitchen  |  "+abc.data![len].Baathroom+" Bathroom",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 2,),
                                      Text("Furnished | Furnished Details",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Text(""+abc.data![len].Furnished+"  |  "+abc.data![len].Details,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black,
                                              border: Border.all(width: 1, color: Colors.tealAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.tealAccent.withOpacity(0.9),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.house_fill,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      abc.data![len].tyope ?? "",
                                                      style:
                                                      TextStyle(color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black,
                                              border: Border.all(width: 1, color: Colors.purpleAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.purpleAccent.withOpacity(0.9),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.house_fill,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      abc.data![len].BHK ?? "",
                                                      style:
                                                      TextStyle(color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black,
                                              border: Border.all(width: 1, color: Colors.indigoAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.indigoAccent.withOpacity(0.9),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.house_fill,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      abc.data![len].Parking +" Parking",
                                                      style:
                                                      TextStyle(color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black,
                                              border: Border.all(width: 1, color: Colors.indigoAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.indigoAccent.withOpacity(0.9),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [


                                                  Container(
                                                    child: Text(
                                                      abc.data![len].id.toString() +"",
                                                      style:
                                                      TextStyle(color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 2,),
                                      Text("Balcony Details",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Text(""+abc.data![len].balcony,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),




                                  /*SizedBox(
                                  height: 40,
                                  child: TabBar(
                                    controller: _tabController,
                                    tabs: [
                                      Text("Specifications",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)),
                                      Text("Details",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 0.5.sw,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white.withOpacity(0.1),
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            abc.data![len].tyope ?? "",
                                                            style:
                                                            TextStyle(color: Colors.white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white.withOpacity(0.1),
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            abc.data![len].BHK ?? "",
                                                            style:
                                                            TextStyle(color: Colors.white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),


                                        *//*Padding(
                                            padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                            child: Text(
                                              bloc.buyRentDetailsData.first.speci ?? "",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),*//*
                                      ),
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                          child: Text(
                                            abc.data![len].Building_information ?? "",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                ],
                              ),
                            );
                          }
                      );
                    }

                  }
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
            child: FutureBuilder<List<Catid>>(
                future: fetchData1(),
                builder: (context,abc){
                  if(abc.connectionState == ConnectionState.waiting){
                    return Center(child: Text(""));
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
                  else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: abc.data!.length,
                        itemBuilder: (BuildContext context,int len) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.withOpacity(0.9),
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                        blurStyle: BlurStyle.outer
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.red),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(horizontal: 10,vertical: 10)),

                                  ),
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                  child: const Text(
                                    "Interested",
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                                ),
                              )

                            ],
                          );
                        }
                    );
                  }

              }
            ),
          ),
        ),
      ),
    );
  }
}
