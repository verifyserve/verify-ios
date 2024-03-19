import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../utils/constant.dart';

class HotelRoomDetails extends StatefulWidget {
  const HotelRoomDetails({super.key});

  @override
  State<HotelRoomDetails> createState() => _HotelRoomDetailsState();
}

class _HotelRoomDetailsState extends State<HotelRoomDetails> {

  final List<ReusableWidget> albumswidget = [
    ReusableWidget(image: 'assets/images/photo.png', name: 'Top Photos'),
    ReusableWidget(image: 'assets/images/photo.png', name: 'Rooms'),
  ];

  bool readMore= false;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(0),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
              child: Image(
                image: AssetImage('assets/images/banq.png'),
                height: 260.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('House In Hotel, Basi Bahuddin Nagar, Noida',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 20,),
                  Text('Address',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  Text('BS-100,Sector 70, Near Pan Oasis Society Gate No.4,Noida',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 5,),
                  Text('112011',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 10,),
                  Divider(height: 2,color: Colors.red.withOpacity(0.8),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prices',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('₹ 850',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                SizedBox(height: 10,),
                                Text('per veg plate',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('₹ 999',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                SizedBox(height: 10,),
                                Text('per non-veg plate',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Event Area Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Treebo Trend House In Hall',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(PhosphorIcons.house_simple,color: Colors.redAccent,),
                            SizedBox(width: 5,),
                            Text('Indoor',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                            Spacer(),
                            Icon(PhosphorIcons.armchair,color: Colors.redAccent,),
                            SizedBox(width: 5,),
                            Text('Seats',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                            Spacer(),
                            Icon(PhosphorIcons.person_simple_walk,color: Colors.redAccent,),
                            SizedBox(width: 5,),
                            Text('Floating',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Photo Albums',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 20,),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      itemCount: albumswidget.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if(index == 0){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StragerGridFirst()));
                            }
                            else if(index == 1){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StragerGridSecond()));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage(albumswidget[index].image)
                                ),
                                SizedBox(height: 5,),
                                Text(albumswidget[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              ],
                            ),
                          ),
                        );
                      },),
                  ),
                  SizedBox(height: 10,),
                  Text('About The Venue',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 10,),
                  Text('Treebo Trend House Inn, situated in Sector-70 is 3-star rated property that is perfect for corporate travelers, families, couples and medical tourists. Delhi’s Indira Gandhi International Airport is 35 km from the hotel and is the closest airport. The Nizamuddin Railway Station is 20 km from the hotel. Noida City Centre Metro Station which is 6.8 km and is the closest stations to the hotel. Treebo Trend House In has a total of 12 Oak (Standard) and 13 Maple (Deluxe) rooms. Each room is equipped with an AC, a television with DTH or cable connection, intercom facilities, mini fridge, and an attached bathroom with running hot and cold water. Guests can also enjoy Treebo’s signature complimentary breakfast, WiFi and branded toiletries. Additional amenities provided by the hotel include in-house laundry service, the provision of a heater on request and an ironing board (on request), a stocked pantry, excellent room service, and a travel desk. The 1200 sq ft banquet hall which can host 100 guests is an added benefit for all those looking for a place to host any event. The in-house restaurant serves delicious North Indian, Chinese and Continental cuisines.',style: TextStyle(color: Colors.white),
                    maxLines: readMore ? 30 : 5,
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
                  Text('Venue Info',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.air_outlined,color: Colors.blue,size: 20,),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Air Conditioning',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              Text('Yes',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.set_meal,color: Colors.red,size: 20,),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Cuisines Allowed',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              Text('Veg & Non Veg',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(PhosphorIcons.money,color: Colors.yellow.shade800,size: 20,),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Payment & Booking',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              Text('Advance for booking is 80%',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                              Text('Payment on event date 20%',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade600,fontFamily: 'Poppins',letterSpacing: 0),),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black, // Change color as needed
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 2, color: Colors.red.withOpacity(0.8)),
                  ),
                  child: SizedBox(
                      width: 130,
                      child: Text('View Contact',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 2, color: Colors.red.withOpacity(0.8)),
                  ),
                  child: SizedBox(
                      width: 130,
                      child: Text('Check Availability',textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReusableWidget extends StatelessWidget {

  final String image;
  final String name;

  const ReusableWidget({super.key,required this.image,required this.name});

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
          Text(name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
        ],
      ),
    );
  }
}

//For Staggered Grid
class BackGroundTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icondata;

  BackGroundTile({required this.backgroundColor, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Icon(icondata, color: Colors.white),
    );
  }
}

// class StragerGrid extends StatefulWidget {
//   const StragerGrid({super.key});
//
//   @override
//   State<StragerGrid> createState() => _StragerGridState();
// }
//
// class _StragerGridState extends State<StragerGrid> {
//
//   List<String> imageListGrid = [
//     'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
//     'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
//     'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
//     'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
//     'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(12),
//         child:  StaggeredGridView.countBuilder(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 12,
//             itemCount: imageListGrid.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(15))
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(15)),
//                   child: FadeInImage.memoryNetwork(
//                     placeholder: kTransparentImage,
//                     image: imageListGrid[index],fit: BoxFit.cover,),
//                 ),
//               );
//             },
//             staggeredTileBuilder: (index) {
//               return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
//             }),
//       ),
//     );
//   }
// }

class StragerGridFirst extends StatelessWidget {
  const StragerGridFirst({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imageListGrid = [
      'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
      'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
      'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
      'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
      'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
    ];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12),
        child:  StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: imageListGrid.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageListGrid[index],fit: BoxFit.cover,),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }),
      ),
    );
  }
}

class StragerGridSecond extends StatelessWidget {
  const StragerGridSecond({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imageListGrid = [
      'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
      'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
      'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
      'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
      'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
      'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    ];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12),
        child:  StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: imageListGrid.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageListGrid[index],fit: BoxFit.cover,),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }),
      ),
    );
  }
}






