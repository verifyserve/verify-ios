import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/services/servicesDetailScreen.dart';
import 'package:verify/bloc/servicesBloc.dart';
import 'package:verify/data/model/services.dart';
import 'package:verify/utils/constant.dart';

import '../../data/model/subService.dart';
import '../../data/repository/servicesRepository.dart';
import '../../utils/message_handler.dart';

class ServicesContentsScreen extends StatefulWidget {
  final Service? service;
  const ServicesContentsScreen(this.service, {Key? key}) : super(key: key);

  @override
  State<ServicesContentsScreen> createState() => _ServicesContentsScreenState();
}

class _ServicesContentsScreenState extends State<ServicesContentsScreen> {
  late ServiceBloc bloc;
  List<String> timing = [
    "09 AM to 12 PM",
    "12 PM to 03 PM",
    "03 PM to 06 PM",
    "06 PM to 09 PM",
  ];
  List<String> date = [
    "Urgently Today",
    "Tomorrow",
    "Day After Tomorrow",
    "Customize",
  ];
  // List<String> need = [
  //   "Daily",
  //   "Monthly",
  // ];

  String? dropdownValue;

  String pickedDate = "Urgently Today";
  ValueNotifier<String?> selectedDate = ValueNotifier(null);
  int? pageIndex2 = 0;
  int? pageIndex1 = 0;
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  ValueNotifier<int> timingIndex = ValueNotifier(0);
  ValueNotifier<int> dateIndex = ValueNotifier(0);
  ValueNotifier<int> needd = ValueNotifier(0);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    bloc=context.read<ServiceBloc>();
    super.initState();
    bloc.subService(widget.service!.id);
    _getCurrentLocation();
    init();
  }
  init()async {
    preferences = await SharedPreferences.getInstance();
    name.value = preferences.getString("name") ?? '';
    number.value=preferences.getString("phone") ?? '';
  }

  final TextEditingController _Address = TextEditingController();
  final TextEditingController _Location = TextEditingController();
  final TextEditingController _Longitude = TextEditingController();
  final TextEditingController _Latitude = TextEditingController();

  String long = '';
  String lat = '';
  String full_address = '';



  Future<void> _getCurrentLocation() async {
    // Check for location permissions
      if (await _checkLocationPermission()) {
        // Get the current location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          long = '${position.latitude}';
          lat = '${position.longitude}';
          _Longitude.text = long;
          _Latitude.text = lat;
        });
      } else {
        // If permissions are not granted, request them
        await _requestLocationPermission();
      }
  }

  Future<bool> _checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Permission granted, try getting the location again
      await _getCurrentLocation();
    } else {
      // Permission denied, handle accordingly
      print('Location permission denied');
    }
  }

  bool isMonthlySelected = false;
  bool isDailySelected = false;
  bool isChecked = false;

  String Months = 'Month';
  String Days = 'Day';

  bool _isLoading = false;

  DateTime currentDate = DateTime.now();

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
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Selected Service',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.lightBlueAccent),
                      ),
                      child: Text("${widget.service!.scname}",style: TextStyle(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.w500),)),
                  const SizedBox(height: 20,),
                  const Text(
                    "Select Suitable time",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
                  const SizedBox(height: 20,),
                  const Text(
                    "Select Suitable Day",
                    // "${widget.service?.scname}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ValueListenableBuilder(
                    valueListenable: dateIndex,
                    builder: (context, int dates,_) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics:

                        const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        padding: EdgeInsets.zero,
                        // crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 4.2.h,
                        children: List.generate(
                            timing.length,
                                (index) {
                              return GestureDetector(
                                onTap: () async {
                                  dateIndex.value = index;
                                  if(dateIndex.value == 3){
                                    DateTime? date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:DateTime(DateTime.now().year - 2),
                                        lastDate: DateTime(DateTime.now().year + 2)
                                    );
                                   pickedDate = DateFormat("dd-MM-yyyy").format(date ?? DateTime.now());
                                   selectedDate.value = pickedDate;
                                  }else{
                                    pickedDate = date[dateIndex.value];
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: dates == index
                                          ? Colors.white
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child:
                                  ValueListenableBuilder(valueListenable: selectedDate, builder: (context, String? data, child) {
                                    return  Text(
                                      index == 3 ? data ?? "Customize" : date[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: dates == index
                                              ? FontWeight.w400
                                              : FontWeight.w400),
                                    );
                                  },),

                                ),
                              );
                            }),
                      );
                    }
                  ),
                  const SizedBox(height: 10,),

                  /*const Text(
                    "Your Preference (Optional)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),*/

                  //const SizedBox(height: 10,),
                  // ValueListenableBuilder(
                  //     valueListenable: dateIndex,
                  //     builder: (context,int time,_ ) {
                  //       return GridView.count(
                  //         shrinkWrap: true,
                  //         physics:
                  //         const NeverScrollableScrollPhysics(),
                  //         crossAxisCount: 3,
                  //         padding: EdgeInsets.zero,
                  //         // crossAxisSpacing: 1,
                  //         mainAxisSpacing: 10,
                  //         childAspectRatio: 2.h,
                  //         children: List.generate(
                  //             need.length,
                  //                 (index) {
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                   needd.value = index;
                  //                   print("${need[needd.value]}");
                  //                 },
                  //                 child: Container(
                  //                   padding: const EdgeInsets.symmetric(
                  //                       horizontal: 1, vertical: 18),
                  //                   margin: const EdgeInsets.only(right: 10),
                  //                   decoration: BoxDecoration(
                  //                       color: time == index
                  //                           ? Colors.white
                  //                           : Colors.grey,
                  //                       borderRadius: BorderRadius.circular(10)),
                  //                   child: Text(
                  //                     need[index],
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                         fontWeight: time == index
                  //                             ? FontWeight.w500
                  //                             : FontWeight.w400),
                  //                   ),
                  //                 ),
                  //               );
                  //             }),
                  //       );
                  //     }
                  // ),
                  // const SizedBox(height: 20,),

                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildOptionCheckbox(
                            'Monthly',
                            PhosphorIcons.calendar,
                            isMonthlySelected, () {
                              setState(() {
                                isMonthlySelected = !isMonthlySelected;
                                isDailySelected = false; // Unselect other option
                                print(isMonthlySelected);
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          buildOptionCheckbox(
                            'Daily',
                            PhosphorIcons.calendar_check,
                            isDailySelected,
                                () {
                              setState(() {
                                isDailySelected = !isDailySelected;
                                isMonthlySelected = false; // Unselect other option
                                isChecked = isDailySelected as bool;
                                print(isChecked);
                              });
                            },
                          ),

                        ],
                      ),
                      // SizedBox(height: 20),if (isMonthlySelected)
                      //   Text(Months,style: TextStyle(color: Colors.white),)else if (isDailySelected)
                      //     Text(Days,style: TextStyle(color: Colors.white),)
                    ],
                  ),*/

                  const SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      child: Text('Address',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                  SizedBox(height: 5,),

                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomRight: Radius.circular(0),bottomLeft: Radius.circular(0)),
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



                  SizedBox(height: 5,),

                  InkWell(
                    onTap: ()async {

                      double latitude = double.parse(long.replaceAll(RegExp(r'[^0-9.]'),''));
                      double longitude = double.parse(lat.replaceAll(RegExp(r'[^0-9.]'),''));

                      placemarkFromCoordinates(latitude, longitude).then((placemarks) {

                        var output = 'Unable to fetch location';
                        if (placemarks.isNotEmpty) {

                          output = placemarks.reversed.last.street.toString()+', '+placemarks.reversed.last.locality.toString()+', '
                              +placemarks.reversed.last.subLocality.toString()+', '+placemarks.reversed.last.administrativeArea.toString()+', '
                              +placemarks.reversed.last.subAdministrativeArea.toString()+', '+placemarks.reversed.last.country.toString()+', '
                              +placemarks.reversed.last.postalCode.toString();
                        }

                        // _isLoading
                        //     ? Center(child: CircularProgressIndicator())
                        //     :

                        setState(() {
                          full_address = output;

                          _Address.text = full_address;

                          print('Your Current Address:- $full_address');
                        });

                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(0),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                            blurStyle: BlurStyle.outer// changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(child: Text('Get Current Location',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1),)),
                    ),
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

                  ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, String _name,__) {
                      return Visibility(
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
                      );
                    }
                  ),

                  const SizedBox(height: 40,),
                  ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, String _name,__) {
                      return ValueListenableBuilder(
                          valueListenable: number,
                          builder: (context, String _numb,__) {
                          return GestureDetector(
                            onTap: () {
                              bloc.addSlot(
                                // id: widget.service?.id,
                                tittle: widget.service?.scname,
                                day: pickedDate,
                                time: timing[timingIndex.value],
                                Address: _Address.text,
                                Location: dropdownValue,
                                Longitude: _Longitude.text,
                                Latitude: _Latitude.text,
                                Type_of_requirement: 'Type_of_requirement'/*'${isMonthlySelected ? 'For Month' : isDailySelected ? 'Only For A Day' : 'Nothing Selected'}'*/,
                                customer_name: _name,
                                booking_time: '${currentDate.day}-${currentDate.month}-${currentDate.year}',
                                customer_number: _numb
                              );

                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child:ValueListenableBuilder(
                                valueListenable: bloc.mainGridLoader,
                                builder: (context, bool loading,_) {
                                  if(loading){
                                    return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                  }
                                  return const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Icon(Icons.comment),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),
                                      Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white),
                                      )
                                    ],
                                  );
                                }
                              ),
                            ),
                          );
                        }
                      );
                    }
                  ),
                  const SizedBox(height: 10,),
                  /*ValueListenableBuilder(
                    valueListenable: bloc.mainGridLoader,
                    builder: (context, bool loading,__) {
                      if (loading == true) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return ValueListenableBuilder(
                        valueListenable: bloc.subSer,
                        builder: (context, List<SubService>data,__) {
                          if(data==null){
                            return const Center(
                                child: Text(
                                  "No data found",
                                  style: TextStyle(color: Colors.white),
                                ));
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Provider.value(
                                        value: bloc,
                                        child: ServicesDetailScreen(data[index].id),
                                      )
                                  ));
                                },
                                child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.black,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index].title??"",
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data[index].experience??"",
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data[index].address??"",
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data[index].filterlocation??"",
                                                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400,fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            height: 120.h,
                                            width: 110.w,
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                "http://www.verifyserve.social/upload/${data[index].subimg}",
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                      AppImages.loading,
                                                      // height: 60.h,
                                                      // width: 120.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                errorWidget:
                                                    (context, error, stack) =>
                                                    Image.asset(
                                                      AppImages.imageNotFound,
                                                      // height: 60.h,
                                                      // width: 120.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        }
                      );
                    }
                  ),*/
                ],
              ),
            ),
          ],
        ),
      )
      /*Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("We Service all Brands",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              Image.asset(AppImages.documents),
              const SizedBox(height: 10,),
              const Text("AC services and Repair",style: TextStyle(fontSize: 16,color: Colors.white),),
              const SizedBox(height: 5,),
              const Text("4.85 (5.9 M Bookings)",style: TextStyle(fontSize: 10,color: Colors.white),),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const ServicesDetailScreen()));
                      },
                      child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              color: Colors.black,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "What is Lorem Ipsum?",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 7,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    AppImages.static1,
                                    height: 120.h,
                                    width: 80.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
  Widget buildOptionCheckbox(
      String label,
      IconData icon,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.w500,fontFamily: 'Poppins',letterSpacing: 1
              ),
            ),
          ],
        ),
      ),
    );
  }
}