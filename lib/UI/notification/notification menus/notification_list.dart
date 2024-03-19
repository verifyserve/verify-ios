import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/notificationBloc.dart';
import 'package:verify/data/model/showNotification.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late NotificationBloc bloc;

  @override
  void initState() {
    bloc = context.read<NotificationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: bloc.showNotiLoader,
        builder: (context,bool loading,_) {
          if(loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return ValueListenableBuilder(
            valueListenable: bloc.showNoti,
            builder: (context,List<ShowNotification> data ,_) {
              if(data.isEmpty || data == null){
                return const Center(child: Text("No Data Found!"),);
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.only(top: 5, left: 15, right: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: "${data[index].ntype} ".toUpperCase(),
                                            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,letterSpacing: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(color: Colors.black, height: 110, width: 1,),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text("${data[index].nname}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Iconsax.location,size: 10,color: Colors.red,),
                                            SizedBox(width: 2,),
                                            SizedBox(
                                              width: 200,
                                              child: Text("${data[index].nLocation}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Iconsax.sms_copy,size: 12,color: Colors.red,),
                                            SizedBox(width: 2,),
                                            Text("Message⤵️",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width: 2,),

                                        GestureDetector(
                                          onTap: () {
                                            // Implement logic to show full text
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  title: const Text('Full Message'),
                                                  content: Text("${data[index].nDes}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400
                                                    ),),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: 200,
                                            child: Text("${data[index].nDes}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        GestureDetector(
                                          onTap: () {
                                            // Implement logic to show full text
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  title: const Text('Full Message'),
                                                  content: Text("${data[index].nDes}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400
                                                    ),),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '... Show More',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Iconsax.watch_copy,size: 12,color: Colors.red,),
                                                SizedBox(width: 2,),
                                                Text("${data[index].nTime}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 170,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Iconsax.calendar_1_copy,size: 12,color: Colors.red,),
                                                SizedBox(width: 2,),
                                                Text("${data[index].nDate}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// margin: const EdgeInsets.only(bottom: 10,top: 10),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.white,
// blurRadius: 0,
// spreadRadius: 2)
// ],
// color: Colors.white.withOpacity(0.5),
// borderRadius: const BorderRadius.all(Radius.circular(10)),
// ),
// child:  Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const SizedBox(height: 10,),
// Row(
// children: [
// Text(
// data[index].nname ?? "",
// textAlign: TextAlign.left,
// style: const TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 17
// ),
// ),
// Spacer(),
// Image(image: AssetImage('assets/images/pin.png'),width: 25,)
// ],
// ),
// const SizedBox(height: 5,),
// Text(
// data[index].nDes ?? "",
// textAlign: TextAlign.left,
// overflow: TextOverflow.ellipsis,
// maxLines: 4,
// style: const TextStyle(
// color: Colors.black54,
// fontWeight:
// FontWeight.w500,
// fontFamily: "Poppins",
// fontSize: 11
// ),
// ),
// const SizedBox(height: 20,),
// Row(
// children: [
// const Icon(Icons.location_on,color: Colors.blue,size: 20,),
// const SizedBox(width: 3,),
// Text(
// data[index].nLocation ??"",
// textAlign: TextAlign.left,
// style: const TextStyle(
// color: Colors.black54,
// fontWeight:
// FontWeight.w500,
// fontFamily: "Poppins",
// fontSize: 13
// ),
// ),
// Spacer(),
// const Icon(Icons.date_range_outlined,color: Colors.blue,size: 20,),
// const SizedBox(width: 3,),
// Text(
// "${data[index].nDate}",
// textAlign: TextAlign.left,
// style: const TextStyle(
// fontWeight: FontWeight.w400,
// color: Colors.black54,
// fontSize: 13
// ),
// ),
// Spacer(),
// const Icon(Icons.watch_later_outlined,color: Colors.blue,size: 20,),
// const SizedBox(width: 3,),
// Text(
// "${data[index].nTime}",
// textAlign: TextAlign.left,
// style: const TextStyle(
// fontWeight: FontWeight.w400,
// color: Colors.black54,
// fontSize: 13
// ),
// ),
//
// ],
// ),
// const SizedBox(height: 10,),
// ],
// ),
// ),
// ),