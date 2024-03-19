import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../utils/constant.dart';
import 'monthlyservice_content.dart';

class hhhhhhlllllllppp{
  final String name;
  final String image;
  hhhhhhlllllllppp({required this.name,required this.image});
  factory hhhhhhlllllllppp.FromJson(Map<String,dynamic>json){
    return hhhhhhlllllllppp(name: json['name_'],
    image: json['Viimg']);

  }
}


class MonthlyTab extends StatefulWidget {
  const MonthlyTab({super.key});

  @override
  State<MonthlyTab> createState() => _MonthlyTabState();
}

class _MonthlyTabState extends State<MonthlyTab> {

  Future<List<hhhhhhlllllllppp>> fetchData() async {
    var url = Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Show_Service_Monthneed");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => hhhhhhlllllllppp.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 5,left: 5,top: 10),
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<hhhhhhlllllllppp>>(
                  future: fetchData(),
                  builder: (context, abc) {
                    if(abc.hasData){
                      return ListView.builder(
                          physics:const ScrollPhysics(),
                          itemCount: abc.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, len) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MonthlyContent(type: abc.data![len].name.toString(),)
                                ));
                              },
                              child: Container(
                                width: 1.sw,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  border:
                                  Border.all(color: Colors.white.withOpacity(0.8)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "https://www.verifyserve.social/upload/"+abc.data![len].image,
                                        height: 60.h,
                                        width: 120.w,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Image.asset(
                                          AppImages.loading,
                                          height: 60.h,
                                          fit: BoxFit.cover,
                                          width: 120.w,
                                        ),
                                        errorWidget: (context, error, stack) =>
                                            Image.asset(
                                              AppImages.imageNotFound,
                                              height: 60.h,
                                              fit: BoxFit.cover,
                                              width: 120.w,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        abc.data![len].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          // fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      PhosphorIcons.caret_right_bold,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    return const CircularProgressIndicator(
                      color: Colors.black87,
                    );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
