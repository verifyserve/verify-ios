import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:verify/UI/documents/Document/pdfscreen.dart';
import '../../../data/model/pdfModel.dart';
import 'package:http/http.dart' as http;

class DocumentTab extends StatefulWidget {
  const DocumentTab({super.key});

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

class _DocumentTabState extends State<DocumentTab> {

  MainPdfModel? pdfModel;

  Future<List<MainPdfModel>> fetchpdf() async {
    final url = Uri.parse('https://verifyserve.social/WebService2.asmx/PDF');
    final response = await http.get(url);
    if (response.statusCode == 200) {
     // await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      return result.map((e) => MainPdfModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          FutureBuilder<List<MainPdfModel>>(
            future: fetchpdf(),
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
                     // Lottie.asset("assets/images/no data.json",width: 450),
                      Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                    ],
                  ),
                );
              }
              else{
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/upload/${snapshot.data![index].viimg}'),
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
                                          width: 150,
                                          child: Text('${snapshot.data![index].viimg}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
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
                  ),
                );
              }
            },
          )
        ],
      )
    );
  }
}