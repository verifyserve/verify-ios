import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/bloc/realEstateBloc.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';

class CommercialDetail extends StatefulWidget {
  final String id;
  CommercialDetail({super.key, required this.id});

  @override
  State<CommercialDetail> createState() => CommercialDetailState();
}

class CommercialDetailState extends State<CommercialDetail>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late RealEstateBloc bloc;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");
  ValueNotifier<String>id=ValueNotifier("");

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
    id.value = preferences.getString("id") ?? '';
  }

  @override
  void initState() {
    bloc = context.read<RealEstateBloc>();
    super.initState();
    bloc.commercialDetails(widget.id);
    _tabController = TabController(length: 2, vsync: this);
    init();
  }

  final TextEditingController _Bidprice = TextEditingController();

  Future<void> fetchdata(iid,number,propertyid,amount,bidprice) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/AddRealstateBuyer?buyer_id=$iid&buyer_number=$number&property_id=$propertyid&property_title=Commercial_RealEstate&property_amount=$amount&make_an_offer=$bidprice'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
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
                  child: Text('Enter Your Bid Amount',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

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
                  controller: _Bidprice,
                  decoration: InputDecoration(
                      hintText: "Enter Your Bid Amount For this Property",
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
                child: ValueListenableBuilder(
                    valueListenable: id,
                    builder: (context, String iidd,__) {
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
                                  //data = _email.toString();
                                  fetchdata(iidd,num, bloc.commercialDetailsData.first.id, bloc.commercialDetailsData.first.price, _Bidprice.text);
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

                            );


                          }
                      );
                    }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ValueListenableBuilder(
            valueListenable: bloc.buyRentDetailLoader,
            builder: (context, bool loading, child) {
              if (loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                          "http://www.verifyserve.social/upload/${bloc.commercialDetailsData.first.img}",
                          width: 1.sw,
                          height: 0.3.sh,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Image.asset(
                            AppImages.loading,
                            width: 1.sw,
                            height: 0.3.sh,
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, error, stack) =>
                              Image.asset(
                                AppImages.imageNotFound,
                                width: 1.sw,
                                height: 0.3.sh,
                                fit: BoxFit.fill,
                              ),
                        ),
                        /*Image.network(
                          "http://www.verifyserve.social/upload/${bloc.commercialDetailsData.first.imagesh}",
                          width: 1.sw,
                          height: 0.3.sh,
                          fit: BoxFit.fill,
                        ),*/
                        Positioned(
                            top: 20,
                            left: 10,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bloc.commercialDetailsData.first.title ?? "",
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
                              Text(
                                "${bloc.commercialDetailsData.first.location} ${bloc.commercialDetailsData.first.filterlocation}" ??
                                    "",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            bloc.commercialDetailsData.first.shortdis ?? "",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Facilities",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: SingleChildScrollView(
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
                                          Icon(
                                            PhosphorIcons.house_fill,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            bloc.commercialDetailsData.first.rtype ?? "",
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
                                          Icon(
                                            PhosphorIcons.bed_fill,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            bloc.commercialDetailsData.first.bhk ?? "",
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
                                          Icon(
                                            PhosphorIcons.armchair_fill,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            bloc.commercialDetailsData.first.furnished ?? "",
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
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                    child: Text(
                                      bloc.commercialDetailsData.first.specification ?? "",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                    child: Text(
                                      bloc.commercialDetailsData.first.details ?? "",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: bloc.buyRentDetailLoader,
            builder: (context,bool loading,_) {
              if(loading){
                return SizedBox();
              }
              return SizedBox(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ ${bloc.commercialDetailsData.first.price ?? ""}",
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 10)),
                        ),
                        onPressed: () {
                          _showBottomSheet(context);
                        },
                        child: const Text(
                          "Submit an offer",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
