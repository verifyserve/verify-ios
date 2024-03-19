import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/notificationBloc.dart';
import 'package:verify/data/repository/notificationRepository.dart';

import '../../../data/model/showNotification.dart';
import '../../../utils/constant.dart';

class SentHistoryNotification extends StatefulWidget {
  const SentHistoryNotification({Key? key}) : super(key: key);

  @override
  State<SentHistoryNotification> createState() => _SentHistoryNotificationState();
}

class _SentHistoryNotificationState extends State<SentHistoryNotification> {
  late NotificationBloc bloc;
  @override
  void initState() {
    bloc=NotificationBloc(context.read<NotificationRepository>());
    super.initState();
    bloc.recentNotification();
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(
                child:Container(
                  padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                  decoration: BoxDecoration(
                    color:Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                  ),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Notification History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 5,
                      ),
                      ValueListenableBuilder(
                        valueListenable: bloc.showNotiLoader,
                        builder: (context, bool loading,__) {
                          if (loading == true) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return ValueListenableBuilder(
                              valueListenable: bloc.recentNot,
                              builder: (context, List<ShowNotification>data,__) {
                                if(data==null){
                                  return const Center(
                                      child:Text(
                                        "No Notification History found",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                  );
                                }
                              return Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 20),
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return GestureDetector(
                                        onTap: () {

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            margin: const EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    blurRadius: 5,
                                                    spreadRadius: 2)
                                              ],
                                              color: Colors.white.withOpacity(0.8),
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            ),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        data[index].nname ?? "",
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data[index].nDate} ${data[index].nTime}",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black54,
                                                          fontSize: 10
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Text(
                                                  data[index].nDes ?? "",
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      fontSize: 11
                                                  ),
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_on,color: Colors.blue,size: 20,),
                                                    const SizedBox(width: 3,),
                                                    Text(
                                                      data[index].nLocation ??"",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontFamily: "Poppins",
                                                          fontSize: 11
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              );
                            }
                          );
                        }
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
