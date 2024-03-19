import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/vehicle/vehicleHome.dart';
import 'package:verify/bloc/vehicleBLoc.dart';
import 'package:verify/data/model/parkingAlert.dart';
import 'package:verify/data/repository/vehicleRepository.dart';

import '../../utils/constant.dart';

class ParkingNotification extends StatefulWidget {
  const ParkingNotification({Key? key}) : super(key: key);

  @override
  State<ParkingNotification> createState() => _ParkingNotificationState();
}

class _ParkingNotificationState extends State<ParkingNotification> {
  late VehicleBloc bloc;
  @override
  void initState() {
    bloc = VehicleBloc(context.read<VehicleRepository>());
    super.initState();
    bloc.parkingList();
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
      body: ValueListenableBuilder(
          valueListenable: bloc.isLoading,
          builder: (context, bool loading, __) {
            if (loading == true) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                 const Row(
                    children: [
                      Icon(PhosphorIcons.warning,color: Colors.red,),
                      SizedBox(width: 3,),
                      Text(
                        "Parking Alert !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3,),
                   Row(
                     children: [
                       Expanded(
                         child: Text(
                          "Could you please relocate your vehicle from that spot?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                  ),
                       ),
                       const SizedBox(width: 20,)
                     ],
                   ),
                  const SizedBox(height: 10,),
                  ValueListenableBuilder(
                      valueListenable: bloc.parkingLists,
                      builder: (context,List<ParkingAlerts>parkingList,__){
                        if(parkingList==null){
                          return const Center(
                            child:Text(
                                "No Notification found",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount:parkingList.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      margin: const EdgeInsets.only(bottom: 10,top: 10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              blurRadius: 5,
                                              spreadRadius: 2)
                                        ],
                                        color: Colors.grey.withOpacity(0.15),
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child:Stack(
                                        children: [
                                          Row(
                                            children: [
                                              const Expanded(child: Row()),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                decoration:  const BoxDecoration(
                                                  color:Color(0xFFD41817),
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                ),
                                                child: const Text(
                                                  "Parking Alert",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(height: 15,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      parkingList[index].carNo ?? "",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                          letterSpacing: 1,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15,),
                                            ],
                                          ),
                                          // const SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        );
                      }
                  )
                ],
              ),
            );
          }),
    );
  }
}
