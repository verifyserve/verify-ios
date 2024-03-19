import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verify/UI/eventsAndWedding/Banquet%20Hall/locationdetails.dart';
import 'package:verify/utils/constant.dart';

import 'hoteldetails.dart';

class WeddingMain extends StatefulWidget {
  const WeddingMain({super.key});

  @override
  State<WeddingMain> createState() => _WeddingMainState();
}

class _WeddingMainState extends State<WeddingMain> {

  final List<ReusableRow> venues = [
    ReusableRow(image: 'assets/images/north.jpg', location: 'North Delhi', number: '1500'),
    ReusableRow(image: 'assets/images/south.png', location: 'South Delhi', number: '40345'),
    ReusableRow(image: 'assets/images/east.jpg', location: 'East Delhi', number: '7000'),
    ReusableRow(image: 'assets/images/west.jpg', location: 'West Delhi', number: '2021'),
  ];

  final List<LocationVenues> locationvenues = [
    LocationVenues(image: 'assets/images/grand.png', name: 'The Grand New Delhi', location: 'Nelson Mandela Marg, Pocket 4, Vasant Kunj II, Vasant Kunj, New Delhi, Delhi 110070', price: '₹ 2,50,000', rating: '4.3'),
    LocationVenues(image: 'assets/images/itc.png', name: 'ITC Maurya', location: 'Akhaura Block, Bapu dham, Chanakyapuri, New Delhi, Delhi 110021', price: '₹ 3,50,000', rating: '4.3'),
    LocationVenues(image: 'assets/images/taj.png', name: 'Taj Palace', location: 'Sardar Patel Marg, Diplomatic Enclave, Chanakyapuri, New Delhi, Delhi 110021', price: '₹ 5,00,000', rating: '4.7'),
  ];

  final List<LocationVenues> westlocationvenues = [
    LocationVenues(image: 'assets/images/umrao.jpg', name: 'The Umrao', location: 'National Highway 48, Rajokri Rd, D Block, 6:Samalkha, New Delhi, Delhi 110037', price: '₹ 3,00,000', rating: '4.3'),
    LocationVenues(image: 'assets/images/radddison.png', name: 'Radisson Blu Hotel', location: 'Plot 4, Centre, Sector 13, Dwarka, New Delhi, Delhi, 110075', price: '₹ 4,50,000', rating: '4.5'),
    LocationVenues(image: 'assets/images/leela.jpg', name: 'The Leela Ambience Convention Hotel', location: 'Vishwas Nagar Extension, Vishwas Nagar, Shahdara, Delhi, 110032', price: '₹ 6,00,000', rating: '4.7'),
  ];

  final List<LocationVenues> northlocationvenues = [
    LocationVenues(image: 'assets/images/seven.jpeg', name: 'Seven Seas Hotel', location: '12, M2K Rd, Mangalam Place, Sector 3, Rohini, New Delhi, Delhi, 110085', price: '₹ 2,00,000', rating: '4.3'),
    LocationVenues(image: 'assets/images/tivoli.jpg', name: 'Tivoli Grand Resort Hotel', location: 'Main, GT Karnal Rd, opp. Sai Baba Mandir, Alipur, New Delhi, Delhi, 110036', price: '₹ 2,50,000', rating: '4.0'),
    LocationVenues(image: 'assets/images/lavanya.jpg', name: 'Lavanya Motel', location: 'G T Road, Palla Bakhtavarpur Road, Alipur, Alipur, Delhi, 110036', price: '₹ 1,50,000', rating: '4.2'),
  ];

  final List<LocationVenues> eastlocationvenues = [
    LocationVenues(image: 'assets/images/crowne.jpg', name: 'Crowne Plaza', location: 'District Centre, 13 B, Mayur Vihar, New Delhi, Delhi 110091', price: '₹ 3,50,000', rating: '4.6'),
    LocationVenues(image: 'assets/images/imperial feast.png', name: 'The Royal Imperial Feast', location: 'Opposite Bathla Apartment, I.P.Extension, Patparganj, Delhi, 110092', price: '₹ 2,50,000', rating: '4.4'),
    LocationVenues(image: 'assets/images/country.jpg', name: 'Country Inn & Suites by Radisson', location: '64/6, Site 4, Sahibabad Industrial Area Site 4, Sahibabad, Ghaziabad, Uttar Pradesh 201010', price: '₹ 5,00,000', rating: '4.5'),
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
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wedding Venues By Places',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 15,),
              Container(
                height: 180,
                child: ListView.builder(
                  itemCount: venues.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationVenueDetailed()));
                        }
                        else if(index == 1){
                          // Fluttertoast.showToast(
                          //     msg: "West Delhi",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationVenueDetailed()));
                        }
                        else if(index == 2){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationVenueDetailed()));
                        }
                        else if(index == 3){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationVenueDetailed()));
                        }
                        else if(index == 4){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationVenueDetailed()));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage(venues[index].image)
                            ),
                            SizedBox(height: 5,),
                            Text(venues[index].location,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                            SizedBox(height: 5,),
                            Text.rich(
                                TextSpan(
                                    text: venues[index].number,
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0,overflow: TextOverflow.ellipsis),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' Venues',
                                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),
                                      )
                                    ]
                                )),
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              Text('Venues in South Delhi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 15,),
              Container(
                height: 240.0. h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: locationvenues.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelRoomDetails()));
                        }
                        else if(index == 1){
                          // Fluttertoast.showToast(
                          //     msg: "West Delhi",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0
                          // );
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
                      },
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                              child: Image(
                                image: AssetImage(locationvenues[index].image),
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
                                          width: 200,
                                          child: Text(locationvenues[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                          width: 200,
                                          child: Text(locationvenues[index].location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 10,),
                                      Text.rich(
                                          TextSpan(
                                              text: locationvenues[index].price,
                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: ' Per Day',
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
                                  Text(locationvenues[index].rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15,),
              Text('Venues in West Delhi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 15,),
              Container(
                height: 240.0. h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: westlocationvenues.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelRoomDetails()));
                        }
                        else if(index == 1){
                          // Fluttertoast.showToast(
                          //     msg: "West Delhi",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0
                          // );
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
                      },
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                              child: Image(
                                image: AssetImage(westlocationvenues[index].image),
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
                                          width: 200,
                                          child: Text(westlocationvenues[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                          width: 200,
                                          child: Text(westlocationvenues[index].location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 10,),
                                      Text.rich(
                                          TextSpan(
                                              text: westlocationvenues[index].price,
                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: ' Per Day',
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
                                  Text(westlocationvenues[index].rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15,),
              Text('Venues in North Delhi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 15,),
              Container(
                height: 240.0. h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: northlocationvenues.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelRoomDetails()));
                        }
                        else if(index == 1){
                          // Fluttertoast.showToast(
                          //     msg: "West Delhi",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0
                          // );
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
                      },
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                              child: Image(
                                image: AssetImage(northlocationvenues[index].image),
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
                                          width: 200,
                                          child: Text(northlocationvenues[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                          width: 200,
                                          child: Text(northlocationvenues[index].location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 10,),
                                      Text.rich(
                                          TextSpan(
                                              text: northlocationvenues[index].price,
                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: ' Per Day',
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
                                  Text(northlocationvenues[index].rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15,),
              Text('Venues in East Delhi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
              SizedBox(height: 15,),
              Container(
                height: 240.0. h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eastlocationvenues.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelRoomDetails()));
                        }
                        else if(index == 1){
                          // Fluttertoast.showToast(
                          //     msg: "West Delhi",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0
                          // );
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
                      },
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                              child: Image(
                                image: AssetImage(eastlocationvenues[index].image),
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
                                          width: 200,
                                          child: Text(eastlocationvenues[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                          width: 200,
                                          child: Text(eastlocationvenues[index].location,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),overflow: TextOverflow.ellipsis,)),
                                      SizedBox(height: 10,),
                                      Text.rich(
                                          TextSpan(
                                              text: eastlocationvenues[index].price,
                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: ' Per Day',
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
                                  Text(eastlocationvenues[index].rating,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {

  final String image;
  final String location;
  final String number;

  const ReusableRow({super.key,required this.image,required this.location,required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(image)
          ),
          SizedBox(height: 5,),
          Text(location,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
          SizedBox(height: 5,),
          Text(number,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
        ],
      ),
    );
  }
}

class LocationVenues extends StatelessWidget {

  final String image;
  final String name;
  final String location;
  final String price;
  final String rating;

  const LocationVenues({super.key,required this.image,required this.name,required this.location,required this.price,required this.rating});

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