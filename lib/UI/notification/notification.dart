import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/notification/notification%20menus/add_notification.dart';
import 'package:verify/UI/notification/notification%20menus/event.dart';
import 'package:verify/UI/notification/notification%20menus/notification_list.dart';
import 'package:verify/UI/notification/notification%20menus/sent_notification_history.dart';
import 'package:verify/bloc/notificationBloc.dart';
import 'package:verify/data/repository/notificationRepository.dart';

import '../../utils/constant.dart';
import '../../utils/message_handler.dart';
import '../documents/property menus/flat_list.dart';
import '../services/addServiceScreen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>with SingleTickerProviderStateMixin {
  late NotificationBloc bloc;
  late TabController _tabController;

  @override
  void initState() {
    bloc = NotificationBloc(context.read<NotificationRepository>());
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    bloc.notificationStreamController.stream.listen((event) {
      if(event=="POPS"){
        Navigator.pop(context);
        bloc.showNotifi();
        bloc.recentNotification();
      }
    });
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.showNotifi();
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
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const SentHistoryNotification()),
              );
            },
            child: const Row(
              children: [
                Icon(
                  PhosphorIcons.clock_counter_clockwise,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      body:Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(
            child: Container(
              height: 1.sh,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
                  color: Colors.white.withOpacity(0.5)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: TabBar(
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      controller: _tabController, tabs: const [
                      Text("EVENT",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
                      Text("NOTIFICATION",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
                    ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 1.sh,
                      child: TabBarView(
                        controller: _tabController,
                        children:  [
                          const Event(),
                          Provider.value(value: bloc,child: const NotificationList(),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 10)),

                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Provider.value(
                            value: bloc,
                            child: const AddNotification()
                          ),
                    ),
                  );
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) =>  Provider.value(value: bloc,child: AddEmployee(type: widget.type,),)));
                },
                child: const Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(width: 5,),
                    Text("Add",style: TextStyle(fontSize: 15),),
                  ],
                ),),
            ],
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
