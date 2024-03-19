import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/constant.dart';
import 'hoteldetails.dart';

class LocationVenueDetailed extends StatefulWidget {
  const LocationVenueDetailed({super.key});

  @override
  State<LocationVenueDetailed> createState() => _LocationVenueDetailedState();
}

class _LocationVenueDetailedState extends State<LocationVenueDetailed> {

  bool readMore= false;

  String? dropdownValuelocation,dropdownValuebudget,dropdownValueguest;

  final List<ReusableRow> locationvenuesdetails = [
    ReusableRow(image: 'assets/images/crowne.jpg', name: 'Crowne Plaza', location: 'District Centre, 13 B, Mayur Vihar, New Delhi, Delhi 110091', price: '₹850-₹1200', rating: '4.6'),
    ReusableRow(image: 'assets/images/imperial feast.png', name: 'The Royal Imperial Feast', location: 'Opposite Bathla Apartment, I.P.Extension, Patparganj, Delhi, 110092', price: '₹850-₹999', rating: '4.4'),
    ReusableRow(image: 'assets/images/radddison.png', name: 'Radisson Blu Hotel', location: 'Plot 4, Centre, Sector 13, Dwarka, New Delhi, Delhi, 110075', price: '₹850-₹1300', rating: '4.5'),
    ReusableRow(image: 'assets/images/itc.png', name: 'ITC Maurya', location: 'Akhaura Block, Bapu dham, Chanakyapuri, New Delhi, Delhi 110021', price: '₹750-₹1100', rating: '4.3'),
    ReusableRow(image: 'assets/images/seven.jpeg', name: 'Seven Seas Hotel', location: '12, M2K Rd, Mangalam Place, Sector 3, Rohini, New Delhi, Delhi, 110085', price: '₹850-₹1100', rating: '4.3'),
  ];

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.red.withOpacity(0.8)
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,color: Colors.white,size: 20,),
                  SizedBox(width: 10),
                  Text('South Delhi',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  Spacer(),
                  Text('Edit',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20,left: 20,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Best Wedding Venues In South Delhi',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  Text('(3410 Found)',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 10,),
                  Text('Verify.com is there to help you out with a list of best wedding venues in South Delhi to match your requirement.',style: TextStyle(color: Colors.white),
                    maxLines: readMore ? 10 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      child: Text(readMore ? "Read less" :
                      "Read more",style: TextStyle(color: Colors.red.withOpacity(0.8),fontSize: 13,letterSpacing: 0.8),),
                      onTap: (){
                        setState(() {
                          readMore = !readMore;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Fluttertoast.showToast(
                              msg: "Filter",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 14.0
                          );
                        },
                          child: Icon(Icons.filter_alt_outlined,color: Colors.white,size: 30,)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.red.withOpacity(0.8)),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              padding: EdgeInsets.only(right: 10,left: 10),
                              hint: const Text('Location',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              value: dropdownValuelocation,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValuelocation = newValue!;
                                });
                              },
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,overflow: TextOverflow.ellipsis),
                              dropdownColor: Colors.grey,
                              items: <String>['Saket','Malviya Nagar','Hauz Khas','Green Park','Vasant Vihar'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.red.withOpacity(0.8)),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              padding: EdgeInsets.only(right: 10,left: 10),
                              hint: const Text('Budget',style:TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              value: dropdownValuebudget,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValuebudget = newValue!;
                                });
                              },
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,overflow: TextOverflow.ellipsis),
                              dropdownColor: Colors.grey,
                              items: <String>['2L-3L','3L-5L','5L-7L','7L-10L','10L +']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.red.withOpacity(0.8)),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              padding: EdgeInsets.only(right: 10,left: 10),
                              hint: const Text('Guests',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              value: dropdownValueguest,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueguest = newValue!;
                                });
                              },
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,overflow: TextOverflow.ellipsis),
                              dropdownColor: Colors.grey,
                              items: <String>['200','500','1,000','2,000','5,000 +']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: locationvenuesdetails.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 300,
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                          ),
                          child: InkWell(
                            onTap: (){
                              if(index == 0){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HotelRoomDetails()));
                              }
                              else if(index == 1){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HotelRoomDetails()));
                              }
                              else if(index == 2){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HotelRoomDetails()));
                              }
                              else if(index == 3){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HotelRoomDetails()));
                              }
                              else if(index == 4){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HotelRoomDetails()));
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                                      child: Image(
                                        image: AssetImage(locationvenuesdetails[index].image),
                                        height: 200.h,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                       top: 20,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 13,right: 10,top: 2,bottom: 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(20)),
                                            color: Colors.red.withOpacity(0.8)
                                          ),
                                          child: Text('MOST POPULAR',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0)),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0,),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              child: Text(locationvenuesdetails[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                          SizedBox(height: 5,),
                                          SizedBox(
                                              width: 200,
                                              child: Text(locationvenuesdetails[index].location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                          SizedBox(height: 10,),
                                          Text.rich(
                                              TextSpan(
                                                  text: locationvenuesdetails[index].price,
                                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text: ' Per Plate (Veg & Non Veg)',
                                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),
                                                    )
                                                  ]
                                              )),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(PhosphorIcons.star_fill,color: Colors.yellow,size: 15,),
                                      SizedBox(width: 5,),
                                      Text(locationvenuesdetails[index].rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {

  final String image;
  final String name;
  final String location;
  final String price;
  final String rating;

  const ReusableRow({super.key,required this.image,required this.name,required this.location,required this.price,required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image(
            image: AssetImage(image),
            height: 150.h,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 0,),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 150,
                      child: Text(name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                  SizedBox(height: 5,),
                  SizedBox(
                      width: 150,
                      child: Text(location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                  SizedBox(height: 10,),
                  Text.rich(
                      TextSpan(
                          text: price,
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                          children: <InlineSpan>[
                            TextSpan(
                              text: ' Per Day',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),
                            )
                          ]
                      ))
                ],
              ),
              Spacer(),
              Icon(PhosphorIcons.star_fill,color: Colors.yellow,size: 15,),
              SizedBox(width: 5,),
              Text(rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
            ],
          ),
        )
      ],
    );
  }
}