import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constant.dart';

class Edit_docs extends StatefulWidget {
  @override
  _Edit_docsState createState() => _Edit_docsState();
}

class _Edit_docsState extends State<Edit_docs> {

  bool _isLoading = false;

  /*void _handleButtonClick() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or any async task
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }*/
  File? _imageFile;
  File? _imagefront;
  File? _imageBack;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _Father_name = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _Occupation = TextEditingController();
  final TextEditingController _Dateofbirth = TextEditingController();
  final TextEditingController _Permanant_Address = TextEditingController();
  final TextEditingController _PinCode = TextEditingController();
  final TextEditingController _District = TextEditingController();
  final TextEditingController _Police_Station = TextEditingController();

  String long = '';
  String lat = '';
  String full_address = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  DateTime now = DateTime.now();

  // Format the date as you like
  late String formattedDate;

  Future<void> _getCurrentLocation() async {
    // Check for location permissions
    if (await _checkLocationPermission()) {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        long = '${position.latitude}';
        lat = '${position.longitude}';
      });
    } else {
      // If permissions are not granted, request them
      await _requestLocationPermission();
    }
  }

  Future<bool> _checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Permission granted, try getting the location again
      await _getCurrentLocation();
    } else {
      // Permission denied, handle accordingly
      print('Location permission denied');
    }
  }

  String? Place_,buyrent,resident_commercial,typeofproperty,bhk,furnished,District,policesttion,pincode,parking,balcony,kitchen,bathroom;



  get _RestorationId => null;

  // actuall image upload

  Future<File?> pickAndCompressImage() async {

  }

  Future<void> uploadImageWithTitle(File imageFile, File imageFrontA, File imageBackA) async {
    String uploadUrl = 'https://verifyserve.social/PHP_Files/updatefullDoc/personal_document/personal.php'; // Replace with your API endpoint

    FormData formData = FormData.fromMap({
      "id": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "passprot_size": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "addhar_front": await MultipartFile.fromFile(imageFrontA.path, filename: imageFrontA.path.split('/').last),
      "addhar_back": await MultipartFile.fromFile(imageBackA.path, filename: imageBackA.path.split('/').last),
      "Occupation": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Date_of_birth": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Permanent_address": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "District": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Pin_code": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Police_station": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Place": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Currunt_date": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Police_station": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "addhar_front": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Property_Number": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
      "Address_": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });

    Dio dio = Dio();

    try {
      Response response = await dio.post(uploadUrl, data: formData);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Upload successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful')),
        );
        setState(() {
          _isLoading = false;
        });
        print('Upload successful: ${response.data}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.statusCode}')),
        );
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print('Error occurred: $e');
    }
  }

  Future<void> _handleUpload() async {
    if (_imageFile == null) {
      Fluttertoast.showToast(
          msg: "Image are required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return;
    }

    //await uploadImageWithTitle(_imageFile!, _propertyNumber.text, _address.text);
  }





  List<String> name = ['Lift','Security CareTaker','GOVT Meter','CCTV','Gas Meter'];

  List<String> tempArray = [];

  String? _selectedItem;
  final List<String> _items = ['SultanPur','ChhattarPur','Aya Nagar(Arjangarh)','Ghitorni','Manglapuri','Rajpur Khurd','Maidan Garhi','JonaPur','Dera Mandi','Gadaipur','Fatehpur Beri','Mehrauli','Sat Bari','Neb Sarai','Saket'];

  String? _selectedItem1;
  final List<String> _items1 = ['Buy','Rent'];

  String? _floor1;
  final List<String> _items_floor1 = ['G-Floor','1st Floor','2nd Floor','3rd Floor','4th Floor','5th Floor','6th Floor','UG Floor','LG FLoor'];

  String? _selectedItem2;
  final List<String> _items2 = ['Residence','Commercial'];

  String? _typeofproperty;
  final List<String> __typeofproperty1 = ['Flat','Office','Shop','Farms','Godown','Plots'];

  String? _bhk;
  final List<String> _bhk1 = ['1 BHK','2 BHK','3 BHK', '4 BHK','1 RK','Commercial'];

  String? _Balcony;
  final List<String> _balcony_items = ['Front Side Balcony','Back Side Balcony','Window','No'];

  String? _Parking;
  final List<String> _Parking_items = ['Car & Bike','Only bike','No'];

  String? _Kitchen;
  final List<String> _kitchen_items = ['Western Style','Indian Style','No'];

  String? _Bathroom;
  final List<String> _bathroom_items = ['Western Style','Indian Style','No'];


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
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage()));
            },
            child: const Icon(
              PhosphorIcons.image,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        File? pickedImage = await pickAndCompressImage();
                        if (pickedImage != null) {
                          setState(() {
                            _imageFile = pickedImage;
                          });
                        }
                      },
                      child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                    ),

                    SizedBox(
                      width: 80,
                    ),

                    Container(
                      width: 100,
                      height: 100,
                      child: _imageFile != null
                          ? Image.file(_imageFile!)
                          : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),

              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        File? pickedImage = await pickAndCompressImage();
                        if (pickedImage != null) {
                          setState(() {
                            _imagefront = pickedImage;
                          });
                        }
                      },
                      child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                    ),

                    SizedBox(
                      width: 80,
                    ),

                    Container(
                      width: 100,
                      height: 100,
                      child: _imagefront != null
                          ? Image.file(_imagefront!)
                          : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),

              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        File? pickedImage = await pickAndCompressImage();
                        if (pickedImage != null) {
                          setState(() {
                            _imageBack = pickedImage;
                          });
                        }
                      },
                      child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                    ),

                    SizedBox(
                      width: 80,
                    ),

                    Container(
                      width: 100,
                      height: 100,
                      child: _imageBack != null
                          ? Image.file(_imageBack!)
                          : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),





              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _handleUpload();
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.red.withOpacity(0.8)),
                        child: _isLoading
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : const Center(
                          child: Text(
                            " + Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),



                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  /*void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _number = prefs.getString('number') ?? '';
    });
  }*/

}
