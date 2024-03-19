import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../utils/constant.dart';
import 'Main/ShowPropertyTenant.dart';

class Catid{
  final int id;
  final String PropertyAddress;
  final String Society;
  final String Place;
  final String City;
  Catid({required this.id,required this.PropertyAddress,required this.Society,required this.Place,required this.City});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(id: json['DPS_id'],PropertyAddress: json['PropertyAddress'],Society: json['Society'],Place: json['Place'],City: json['City']);

  }
}

class FlatDetails extends StatefulWidget {
  const FlatDetails({super.key});

  @override
  State<FlatDetails> createState() => _FlatDetailsState();
}

class _FlatDetailsState extends State<FlatDetails> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
  }


  Future<List<Catid>> fetchData(id) async {
    ValueListenableBuilder(
        valueListenable: number,
        builder: (context, String num, __) {
          return Text(
            num,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          );
        }
    );
    var url = Uri.parse(
        "https://verifyserve.social/WebService2.asmx/Show_Property_Documaintation?number=2&property_type=Flat");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occurred!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.black,
      title: Image.asset(AppImages.verify, height: 55),),

        body: Container(
          width: double.infinity,
          child: FutureBuilder<List<Catid>>(
              future: fetchData("" + 1.toString()),
              builder: (context, abc) {
                if (abc.hasData) {
                  return ListView.builder(
                      itemCount: abc.data!.length,
                      // itemCount: 1,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int len) {
                        return GestureDetector(

                          onTap: () {
                            //  int itemId = abc.data![len].id;
                            //int iiid = abc.data![len].PropertyAddress
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    ShowProperty(
                                        iidd: abc.data![len].id.toString()))

                            );
                          },

                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Property',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child: Text(
                                              abc.data![len].PropertyAddress,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(height: 5,),

                                          SizedBox(
                                            width: 140,
                                            child: Text(
                                              abc.data![len].Society,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            abc.data![len].Place,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              // fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            abc.data![len].City,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              // fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          SizedBox(height: 5,)
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          ClipRRect(
                                            borderRadius: const BorderRadius
                                                .all(Radius.circular(5)),
                                            child: Container(
                                              width: 100,
                                              height: 90,
                                              child: Image.asset(
                                                  AppImages.verify, height: 55),
                                            ),
                                          ),

                                          Container(
                                            child: ValueListenableBuilder(
                                                valueListenable: number,
                                                builder: (context, String num,
                                                    __) {
                                                  return Container(
                                                    height: 50,
                                                    width: 200,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 50),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                15)),
                                                        color: Colors.red
                                                            .withOpacity(0.8)
                                                    ),


                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor: Colors
                                                              .red
                                                      ),
                                                      onPressed: () {
                                                        //data = _email.toString();
                                                        fetchData(num);
                                                      },
                                                      child: Text("Submit",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,),
                                                      ),
                                                    ),

                                                  );
                                                }
                                            ),
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                        );
                      });
                }
                else if (abc.hasError) {
                  return Text(abc.error.toString());
                }
                return const LinearProgressIndicator(
                  color: Colors.black87,
                );
              }
          ),
        )
    );
  }
}