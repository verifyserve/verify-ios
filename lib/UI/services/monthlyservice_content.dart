import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/servicesBloc.dart';
import '../../utils/constant.dart';

class MonthlyContent extends StatefulWidget {
  final String type;
  const MonthlyContent({Key? key, required this.type}) : super(key: key);

  @override
  State<MonthlyContent> createState() => _MonthlyContentState();
}

class _MonthlyContentState extends State<MonthlyContent> {

  late ServiceBloc bloc;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>id=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();

    init();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("name")??'';
    id.value=preferences.getString("id")??'';
    number.value=preferences.getString("phone")??'';

  }

  List<String> timing = [
    "09 AM to 12 PM",
    "03 PM to 06 PM",
    "06 PM to 09 PM",
  ];
  List<String> date = [
    "Urgently Today",
    "Tomorrow",
    "Day After Tomorrow",
    "Customize",
  ];

  String? dropdownValue;

  String pickedDate = "Urgently Today";
  ValueNotifier<String?> selectedDate = ValueNotifier(null);
  int? pageIndex2 = 0;
  int? pageIndex1 = 0;
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  ValueNotifier<int> timingIndex = ValueNotifier(0);
  ValueNotifier<int> dateIndex = ValueNotifier(0);

  final TextEditingController _Address = TextEditingController();

  final TextEditingController _Longitude = TextEditingController();
  final TextEditingController _Latitude = TextEditingController();

  String long = '';
  String lat = '';
  String full_address = '';

  Future<void> fetchdata(Service_type,booktime,Address_book,location_book,bookperson_name,bookperson_number,bookperson_id) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Book_Service_Monthneed?Service_type=$Service_type&booktime=$booktime&Address_book=$Address_book&location_book=$location_book&bookperson_name=$bookperson_name&bookperson_number=$bookperson_number&bookperson_id=$bookperson_id'));

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
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected Service',style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    Text("("+ widget.type +")",style: TextStyle(fontSize: 22,color: Colors.grey[500],fontWeight: FontWeight.w500),),
                    SizedBox(height: 20,),
                    const Text(
                      "Select Suitable time",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ValueListenableBuilder(
                        valueListenable: timingIndex,
                        builder: (context,int time,_ ) {
                          return GridView.count(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            padding: EdgeInsets.zero,
                            // crossAxisSpacing: 1,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.h,
                            children: List.generate(
                                timing.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      timingIndex.value = index;
                                      print("${timing[timingIndex.value]}");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: time == index
                                              ? Colors.white
                                              : Colors.grey,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Text(
                                        timing[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: time == index
                                                ? FontWeight.w500
                                                : FontWeight.w400),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Text.rich(
                          TextSpan(
                              text: 'Note:-',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' Enter Address manually or get your current Address from one tap on location icon.',
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade400,fontFamily: 'Poppins',letterSpacing: 0),
                                )
                              ]
                          )),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('Proper Address',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              controller: _Address,
                              decoration: InputDecoration(
                                  hintText: "Your Address",
                                  prefixIcon: Icon(
                                    PhosphorIcons.map_pin,
                                    color: Colors.black54,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                            hoverColor: Colors.white,
                            onTap: ()async {

                              double latitude = double.parse(long.replaceAll(RegExp(r'[^0-9.]'),''));
                              double longitude = double.parse(lat.replaceAll(RegExp(r'[^0-9.]'),''));

                              placemarkFromCoordinates(latitude, longitude).then((placemarks) {
                                var output = 'No results found.';
                                if (placemarks.isNotEmpty) {
                                  output = placemarks.reversed.last.street.toString()+', '+placemarks.reversed.last.locality.toString()+', '
                                      +placemarks.reversed.last.subLocality.toString()+', '+placemarks.reversed.last.administrativeArea.toString()+', '
                                      +placemarks.reversed.last.subAdministrativeArea.toString()+', '+placemarks.reversed.last.country.toString()+', '
                                      +placemarks.reversed.last.postalCode.toString();
                                }

                                setState(() {
                                  full_address = output;

                                  _Address.text = full_address;

                                  print('Your Current Address:- $full_address');
                                });
                              });

                            },
                            child: Image.asset('assets/images/Homeaddress.png',height: 35,width:35,))
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 1, color: Colors.white),
                              // boxShadow: K.boxShadow,
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  PhosphorIcons.map_pin_line,
                                  color: Colors.white,
                                ),
                              ),
                              padding: EdgeInsets.only(right: 10,left: 0),
                              hint: const Text('Select Location',style: TextStyle(color: Colors.white),),
                              value: dropdownValue,
                              dropdownColor: Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(30),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['Dwarka Mor, New Delhi', 'Uttam Nagar, New Delhi', 'SultanPur, New Delhi', 'Hauz Khas, New Delhi']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: (){
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.blue,
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(height: 20,),
                    Visibility(
                      visible: false,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          // boxShadow: K.boxShadow,
                        ),
                        child: TextField(
                          controller: _Longitude,
                          decoration: InputDecoration(
                              hintText: "Enter Longitude",
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Colors.black54,
                              ),
                              hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    //const SizedBox(height: 20,),
                    Visibility(
                      visible: false,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          // boxShadow: K.boxShadow,
                        ),
                        child: TextField(
                          controller: _Latitude,
                          decoration: InputDecoration(
                              hintText: "Enter Latitude",
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Colors.black54,
                              ),
                              hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ValueListenableBuilder(
                        valueListenable: name,
                        builder: (context, String naam,__) {
                        return ValueListenableBuilder(
                            valueListenable: number,
                            builder: (context, String num,__) {
                            return ValueListenableBuilder(
                                valueListenable: id,
                                builder: (context, String iid,__) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () {

                                      fetchdata(widget.type, timing[timingIndex.value], _Address.text, dropdownValue, naam, num, iid);

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

                                      // bloc.addSlot(
                                      //   // id: widget.service?.id,
                                      //     tittle: widget.service?.scname,
                                      //     day: pickedDate,
                                      //     time: timing[timingIndex.value],
                                      //     Address: _Address.text,
                                      //     Location: dropdownValue,
                                      //     Longitude: _Longitude.text,
                                      //     Latitude: _Latitude.text
                                      // );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.red),
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white),
                                      )
                                    ),
                                  ),
                                );
                              }
                            );
                          }
                        );
                      }
                    ),
                    const SizedBox(height: 10,),
                    // ValueListenableBuilder(
                    //     valueListenable: bloc.mainGridLoader,
                    //     builder: (context, bool loading,__) {
                    //       if (loading == true) {
                    //         return const Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colors.white,
                    //           ),
                    //         );
                    //       }
                    //       return ValueListenableBuilder(
                    //           valueListenable: bloc.subSer,
                    //           builder: (context, List<SubService>data,__) {
                    //             if(data==null){
                    //               return const Center(
                    //                   child: Text(
                    //                     "No data found",
                    //                     style: TextStyle(color: Colors.white),
                    //                   ));
                    //             }
                    //             return ListView.builder(
                    //               itemCount: data.length,
                    //               physics: ScrollPhysics(),
                    //               shrinkWrap: true,
                    //               itemBuilder: (context, index) {
                    //                 return GestureDetector(
                    //                   onTap: () {
                    //                     Navigator.of(context).push(MaterialPageRoute(
                    //                         builder: (context) => Provider.value(
                    //                           value: bloc,
                    //                           child: ServicesDetailScreen(data[index].id),
                    //                         )
                    //                     ));
                    //                   },
                    //                   child: Container(
                    //                       padding:
                    //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //                       margin: const EdgeInsets.only(right: 10),
                    //                       decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.circular(10)),
                    //                       child: Container(
                    //                         padding: const EdgeInsets.symmetric(
                    //                             horizontal: 10, vertical: 10),
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.circular(10),
                    //                           border: Border.all(color: Colors.white),
                    //                           color: Colors.black,
                    //                         ),
                    //                         child: Row(
                    //                           crossAxisAlignment: CrossAxisAlignment.start,
                    //                           children: [
                    //                             Expanded(
                    //                               child: Column(
                    //                                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   Text(
                    //                                     data[index].title??"",
                    //                                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Text(
                    //                                     data[index].experience??"",
                    //                                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Text(
                    //                                     data[index].address??"",
                    //                                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Text(
                    //                                     data[index].filterlocation??"",
                    //                                     style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400,fontSize: 12),
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             const SizedBox(
                    //                               width: 5,
                    //                             ),
                    //                             SizedBox(
                    //                               height: 120.h,
                    //                               width: 110.w,
                    //                               child: ClipRRect(
                    //                                 borderRadius: const BorderRadius.all(Radius.circular(5)),
                    //                                 child: CachedNetworkImage(
                    //                                   imageUrl:
                    //                                   "http://www.verifyserve.social/upload/${data[index].subimg}",
                    //                                   // height: 60.h,
                    //                                   // width: 120.w,
                    //                                   fit: BoxFit.cover,
                    //                                   placeholder: (context, url) =>
                    //                                       Image.asset(
                    //                                         AppImages.loading,
                    //                                         // height: 60.h,
                    //                                         // width: 120.w,
                    //                                         fit: BoxFit.cover,
                    //                                       ),
                    //                                   errorWidget:
                    //                                       (context, error, stack) =>
                    //                                       Image.asset(
                    //                                         AppImages.imageNotFound,
                    //                                         // height: 60.h,
                    //                                         // width: 120.w,
                    //                                         fit: BoxFit.cover,
                    //                                       ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       )),
                    //                 );
                    //               },
                    //             );
                    //           }
                    //       );
                    //     }
                    // ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
