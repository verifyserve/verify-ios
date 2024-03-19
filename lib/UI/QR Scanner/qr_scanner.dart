import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

import '../../data/model/UserInfo.dart';
import '../../utils/constant.dart';
import 'package:http/http.dart' as http;

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  String scannedCode = "";

  Userinfo? userinfo;

  bool isLoading = false;

  late bool isColumnVisible;

  var data;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<Userinfo> getProductsApi(String scannedCode)async{
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/sp_Parking_Alert?Vehicle=$scannedCode'));
    data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(response.body.toString());
      return Userinfo.fromJson(data);
    }else{
      print(Exception());
      return Userinfo.fromJson(data);
    }
  }

  Future<void> fetchowner() async {

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate a 3-second delay.


    try {

      final ownerDetails = await getProductsApi(scannedCode);

      print(ownerDetails);

      setState(() {
        userinfo = ownerDetails;
        isLoading = false;
        isColumnVisible = true;
      });

    } catch (e) {
      print('Error: $e');
      setState(() {
        Fluttertoast.showToast(
            msg: "No User Found!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        isLoading = false;
        isColumnVisible = false;
      });
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Text('Scan QR Code to send alert!',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',)),
          SizedBox(height: 10,),
          Expanded(
              flex: 3,
              child: QRView(
                key: qrkey,
                overlay: QrScannerOverlayShape(
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 10,
                    borderColor: Colors.green
                ),
                onQRViewCreated: _onQrViewCreated,
              )
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
               // Text('Scanned Code: $scannedCode',style: TextStyle(fontSize: 18)),

                ElevatedButton(
                  onPressed: () {
                    fetchowner();
                  },
                  child: Text('Get Details'),
                ),

                if (isLoading)
                  Center(heightFactor: 5,child: CircularProgressIndicator())
                else if (userinfo != null)
                  Visibility(
                    visible: isColumnVisible,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: InputDecorator(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReusableRow(title: 'Owner Name', colon: ':',value: '${userinfo!.data!.first.vname}'),
                              SizedBox(height: 15,),
                              ReusableRow(title: 'Vehicle No.', colon: ':',value: '${userinfo!.data!.first.vechicleNo}'),
                              SizedBox(height: 30),
                              ElevatedButton.icon(
                                onPressed: (){
                                  sendCallNotification();
                                },
                                icon: Icon(PhosphorIcons.phone_call_fill,color: Colors.greenAccent,size: 30),
                                label: Text('Send Alert',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,letterSpacing: 0.5),),
                              )],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> sendCallNotification() async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAtelDzuE:APA91bF6bv75VmfoOxUuyaV6tmdGfjDjoGe4TKbkN6W1zFGhbACuV_ZCZNfQ8HL9YuNx16oACmnHzVysonEKvAtwSfFuUrxfRo2P4tkXaMkaj97A-3WwNDy33x9Pww3VdvaFho-gk9kV',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Hey, someone is looking for you',
              'title': 'Vehicle Alert!',
              'sound': 'default',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': userinfo!.data!.first.tokenNo,
          },
        ),
      );
      Fluttertoast.showToast(
          msg: "Alert sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      response;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Alert not sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      e;
    }
  }
  void _onQrViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Vibration.vibrate();
      controller?.pauseCamera();
      //controller?.stopCamera();
      setState(() {
        scannedCode = scanData.code!;
      });
    });
  }
}
class ReusableRow extends StatelessWidget {

  String title,value,colon;

  ReusableRow({super.key,required this.title,required this.value,required this.colon});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',)),

        SizedBox(width: 5,),

        Text(colon,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',),),

        SizedBox(width: 5,),

        Text(value,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade500,fontFamily: 'Poppins', letterSpacing: 0.8)),
      ],
    );
  }
}