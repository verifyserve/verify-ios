import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/vehicle/vehicleHome.dart';
import 'package:verify/bloc/vehicleBLoc.dart';
import 'package:verify/utils/constant.dart';
import 'package:vibration/vibration.dart';

class ParkingAlert extends StatefulWidget {
   const ParkingAlert({super.key});

  @override
  State<ParkingAlert> createState() => _ParkingAlertState();
}

class _ParkingAlertState extends State<ParkingAlert> {
  ValueNotifier<bool> timerRunning = ValueNotifier(true);
  ValueNotifier<int> time = ValueNotifier(15);

  @override
  void initState() {
    super.initState();
    timer();
    Vibration.vibrate(duration: 15000);
  }

  @override
  void dispose(){
    super.dispose();
    Vibration.cancel();
    time.dispose();
    //...
  }

  timer(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(time.value > 0){
        time.value--;
        print("object $time");
      }
      else{
        timer.cancel();
        timerRunning.value = false;
      }
      print("timer");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const VehicleHome()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Image.asset(AppImages.verify, height: 55),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
        body: ValueListenableBuilder(
          valueListenable: timerRunning,
          builder: (context,bool timerRunning,_){
            if(timerRunning){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30,),
                      const Text("Parking alert is being sent",
                        style: TextStyle(color: Colors.white,fontSize: 18),),
                      const SizedBox(height: 20,),
                      ValueListenableBuilder(
                        valueListenable: time,
                        builder: (context,int timeLeft,_) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.red,
                            child: Text("00:${timeLeft.toString().padLeft(2, '0')}",style: const TextStyle(
                              fontSize: 24,
                              fontWeight:FontWeight.w600,
                              letterSpacing: 0.5,
                            ),),
                          );
                        }
                      ),
                      const Spacer(),
                      Image.asset(AppImages.documents),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  const Text("You can call or Drop a message to the Owner",
                  style: TextStyle(color: Colors.white,fontSize: 18),),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(PhosphorIcons.phone_call_fill,color: Colors.blue,size: 30,),
                        Icon(PhosphorIcons.whatsapp_logo_fill,color: Colors.green,size: 35,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}