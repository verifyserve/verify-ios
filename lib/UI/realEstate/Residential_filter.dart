import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Residential_filter extends StatefulWidget {
  const Residential_filter({super.key});

  @override
  State<Residential_filter> createState() => _Residential_filterState();
}

class _Residential_filterState extends State<Residential_filter> {

  ValueNotifier<int> timingIndex = ValueNotifier(0);

  List<String> timing = [
    "Flat",
    "Villa",
    "Farms",
    "House",
  ];

  ValueNotifier<int> bhkIndex = ValueNotifier(0);

  List<String> bhk = [
    "1 BHK",
    "2 BHK",
    "3 BHK",
    "4 BHK",
    "1 RK",
  ];

  ValueNotifier<int> buyIndex = ValueNotifier(0);

  List<String> rent = [
    "Buy",
    "Rent",
  ];

  String? _place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            ValueListenableBuilder(
                valueListenable: buyIndex,
                builder: (context,int time,_ ) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4.5.h,
                    children: List.generate(
                        rent.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              buyIndex.value = index;
                              print("${rent[buyIndex.value]}");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: time == index
                                      ? Colors.red
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                rent[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
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

            Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Choose Property Type',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: 'Poppins'),)),

            const SizedBox(height: 5,),

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
                    childAspectRatio: 3.h,
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
                                      ? Colors.red
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                timing[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
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

            Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Choose Location',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: 'Poppins'),)),

            const SizedBox(height: 5,),

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
                hint: const Text('Select Place',style: TextStyle(color: Colors.white),),
                value: _place,
                dropdownColor: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(30),
                onChanged: (String? newValue) {
                  setState(() {
                    _place = newValue!;
                  });
                },
                items: <String>['Sultanpur','Uttam Nagar','Dwarka mor','Ghitoni','Chhattarpur','Nawada','Janak Puri','Vikas Puri','Hauz Khas']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: Colors.white),),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20,),

            Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('Choose Area',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: 'Poppins'),)),

            const SizedBox(height: 5,),

            ValueListenableBuilder(
                valueListenable: bhkIndex,
                builder: (context,int time,_ ) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.h,
                    children: List.generate(
                        bhk.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              bhkIndex.value = index;
                              print("${bhk[bhkIndex.value]}");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: time == index
                                      ? Colors.red
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                bhk[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
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

            SizedBox(height: 20,),

            Container(
              height: 60,
              width: 1.sw,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed: (){

                }, child: Text("Show Property", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
