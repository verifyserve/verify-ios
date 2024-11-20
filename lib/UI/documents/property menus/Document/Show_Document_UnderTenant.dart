import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;

import '../../../../data/model/tenantpdfModel.dart';
import '../../../../utils/constant.dart';
import '../../Document/pdfscreen.dart';

class Show_Document_underTenantProperty extends StatefulWidget {
  final String Tenant_num;
  final String Owner_Num;
  final String B_Subid;
  const Show_Document_underTenantProperty({Key? key, required this.Tenant_num, required this.Owner_Num, required this.B_Subid}) : super(key: key);

  @override
  State<Show_Document_underTenantProperty> createState() => _Show_Document_underTenantPropertyState();
}

class _Show_Document_underTenantPropertyState extends State<Show_Document_underTenantProperty> {

  Future<List<TenantPdfModel>> fetchData(O_num,T_num,subid) async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Verification_document_by_BothNumber_Subid?own_num=${O_num}&tenant_num=${T_num}&Subid=${subid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((e) => TenantPdfModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
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
        actions:  [
          GestureDetector(
            onTap: () async {

            },
            child: const Icon(
              PhosphorIcons.trash,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),

      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            FutureBuilder<List<TenantPdfModel>>(
              future: fetchData(widget.Owner_Num,widget.Tenant_num,widget.B_Subid),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // If the list is empty, show an empty image
                  return Center(
                    child: Column(
                      children: [
                        //  Lottie.asset("assets/images/no data.json",width: 450),
                        Center(child: Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                      ],
                    ),
                  );
                }
                else{
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/Done_Verification/${snapshot.data![index].documentPDF}'),
                            ),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                            child: Container(
                              padding: EdgeInsets.only(right: 15,left: 10,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                border: Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                  Icon(PhosphorIcons.file_pdf,color: Colors.redAccent,),
                                  SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 200,
                                          child: Text('${snapshot.data![index].documentname}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(PhosphorIcons.paperclip,color: Colors.white,)
                                  // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                ],
                              ),
                            )
                        ),
                      );
                    },
                  );
                }
              },
            ),



          ],
        ),
      ),

    );
  }
}
