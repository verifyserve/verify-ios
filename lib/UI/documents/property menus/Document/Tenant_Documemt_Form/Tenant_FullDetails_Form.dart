import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/constant.dart';
import 'dart:io';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../ApplyDocument_byOwner.dart';


class Catid_Tenant {
  final int id;
  final String Name_;
  final String Number;
  final String Father_name;
  final String Occupation;
  final String Date_of_birth;
  final String Permanent_address;
  final String District;
  final String Pin_code;
  final String Police_station;
  final String Place;

  Catid_Tenant(
      {required this.id,required this.Name_,required this.Number,required this.Father_name,required this.Occupation,
        required this.Date_of_birth, required this.Permanent_address,required this.District,required this.Pin_code,
        required this.Police_station,required this.Place});

  factory Catid_Tenant.FromJson(Map<String, dynamic>json){
    return Catid_Tenant(id: json['id'],
        Name_: json['Name_'],
        Number: json['Number'],
        Father_name: json['Father_name'],
        Occupation: json['Occupation'],
        Date_of_birth: json['Date_of_birth'],
        Permanent_address: json['Permanent_address'],
        District: json['District'],
        Pin_code: json['Pin_code'],
        Police_station: json['Police_station'],
        Place: json['Place']);
  }
}

class Catid {
  final int id;
  final String Name_;
  final String Number;
  final String Father_name;
  final String Occupation;
  final String Date_of_birth;
  final String Permanent_address;
  final String District;
  final String Pin_code;
  final String Police_station;
  final String Place;

  Catid(
      {required this.id,required this.Name_,required this.Number,required this.Father_name,required this.Occupation,
        required this.Date_of_birth, required this.Permanent_address,required this.District,required this.Pin_code,
        required this.Police_station,required this.Place});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['id'],
        Name_: json['Name_'],
        Number: json['Number'],
        Father_name: json['Father_name'],
        Occupation: json['Occupation'],
        Date_of_birth: json['Date_of_birth'],
        Permanent_address: json['Permanent_address'],
        District: json['District'],
        Pin_code: json['Pin_code'],
        Police_station: json['Police_station'],
        Place: json['Place']);
  }
}

class Owner_FullDeytails_Form extends StatefulWidget {
  Owner_FullDeytails_Form({super.key});

  @override
  State<Owner_FullDeytails_Form> createState() => _Owner_FullDeytails_FormState();
}

class _Owner_FullDeytails_FormState extends State<Owner_FullDeytails_Form> {


  String _OwnerNumber = '';
  String _OwnerName = '';
  String _TenantNumber = '';
  String _TenantName = '';
  String Subid = '';

  @override
  void initState() {
    _loaduserdata();
    super.initState();

  }

  Future<List<Catid>> fetchData() async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_document_by_number_?number=${_OwnerNumber.toString()}");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid_Tenant>> fetchData_Tenant() async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_document_by_number_?number=${_TenantNumber.toString()}");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid_Tenant.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> Insurt_Document(ownername,ownernumber,tanantname,tanantnumber,floor_number_tanant,flat_number_tanant,rent_amount_tanat,owner_fathername,tanant_fathername,owner_occupation,tanant_occupation,owner_dateofbirth,tanant_dateofbirth,owner_permanant_address,tanant_permanant_address,owner_district,tanant_district,owner_permanant_address_police_station,tanant_permanant_address_police_station,owner_permanant_address_pincode,tanant_permanant_address_pincode,owner_place,tanant_place,tananted_address,tananted_address_district,tananted_address_police_station,tananted_address_pincode,tananted_place,current_date_,owner_document_id,tanant_document_id,document_type,looking,amount) async{
    final responce = await http.get(Uri.parse
      ('https://verifyserve.social/WebService4.asmx/add_police_verification_and_rent_document_?ownername=$ownername&ownernumber=$ownernumber&tanantname=$tanantname&tanantnumber=$tanantnumber&floor_number_tanant=$floor_number_tanant&flat_number_tanant=$flat_number_tanant&rent_amount_tanat=$rent_amount_tanat&owner_fathername=$owner_fathername&tanant_fathername=$tanant_fathername&owner_occupation=$owner_occupation&tanant_occupation=$tanant_occupation&owner_dateofbirth=$owner_dateofbirth&tanant_dateofbirth=$tanant_dateofbirth&owner_permanant_address=$owner_permanant_address&tanant_permanant_address=$tanant_permanant_address&owner_district=$owner_district&tanant_district=$tanant_district&owner_permanant_address_police_station=$owner_permanant_address_police_station&tanant_permanant_address_police_station=$tanant_permanant_address_police_station&owner_permanant_address_pincode=$owner_permanant_address_pincode&tanant_permanant_address_pincode=$tanant_permanant_address_pincode&owner_place=$owner_place&tanant_place=$tanant_place&tananted_address=$tananted_address&tananted_address_district=$tananted_address_district&tananted_address_police_station=$tananted_address_police_station&tananted_address_pincode=$tananted_address_pincode&tananted_place=$tananted_place&current_date_=$current_date_&owner_document_id=$owner_document_id&tanant_document_id=$tanant_document_id&document_type=$document_type&building_subid=$Subid&looking_type=$looking&amount=$amount'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);
      Fluttertoast.showToast(
          msg: "Request Upload successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }



  DateTime now = DateTime.now();

  // Format the date as you like
  late String formattedDate;

  bool _isLoading = false;

  File? _AddharCard_FrontImage;
  File? _AddharCard_BackImage;
  File? _PasportSize_Photo;
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

  Future<void> _pick_AddharCard_FrontImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _AddharCard_FrontImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pick_AddharCard_BlackImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _AddharCard_BackImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pick_PasportSize_Photo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _PasportSize_Photo = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    if (_AddharCard_FrontImage == null || _AddharCard_BackImage == null || _PasportSize_Photo == null) {
      print('Image and name are required');
      Fluttertoast.showToast(
          msg: "Image and name are required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    formattedDate = "${now.day}-${now.month}-${now.year}";

    setState(() {
      _isLoading = true;
    });


    try {
      final mimeTypeData = lookupMimeType(_AddharCard_FrontImage!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData1 = lookupMimeType(_AddharCard_BackImage!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData2 = lookupMimeType(_PasportSize_Photo!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse('https://verifyserve.social/PHP_Files/Main_Document/Add_Document_api/insert.php'), // Replace with your API endpoint
      );

      final file = await http.MultipartFile.fromPath(
        'addhar_front',
        _AddharCard_FrontImage!.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      );
      final file1 = await http.MultipartFile.fromPath(
        'addhar_back',
        _AddharCard_BackImage!.path,
        contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]),
      );
      final file2 = await http.MultipartFile.fromPath(
        'passprot_size',
        _PasportSize_Photo!.path,
        contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]),
      );



      // Text Feild
      imageUploadRequest.fields['Name_'] = _name.text;
      imageUploadRequest.fields['Number'] = _number.text;
      imageUploadRequest.fields['Father_name'] = _Father_name.text;
      imageUploadRequest.fields['Occupation'] = _Occupation.text;
      imageUploadRequest.fields['Date_of_birth'] = _Dateofbirth.text;
      imageUploadRequest.fields['Permanent_address'] = _Permanant_Address.text;
      imageUploadRequest.fields['District'] = _District.text;
      imageUploadRequest.fields['Pin_code'] = _PinCode.text;
      imageUploadRequest.fields['Police_station'] = _Police_Station.text;
      imageUploadRequest.fields['Place'] = _place.text;
      imageUploadRequest.fields['Currunt_date'] = formattedDate.toString();

      imageUploadRequest.files.add(file);
      imageUploadRequest.files.add(file1);
      imageUploadRequest.files.add(file2);

      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Data uploaded successfully');
        fetchData();
        final result_Owner = await fetchData();
        //Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", "Owner id", " ", tempArray.toString(), "Processing");
        /*if (tempArray.toString() == "[Police Verification, Rent Agreement]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 598");

        if (tempArray.toString() == "[Rent Agreement]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 299");

        if (tempArray.toString() == "[Police Verification]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 299");
*/
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ApplyDocument_Owner(),), (route) => route.isFirst);
        setState(() {
          _isLoading = false;
        });
      } else {

        setState(() {
          _isLoading = true;
        });
        /*print('Data upload failed with status: ${response.statusCode}');

        Fluttertoast.showToast(
            msg: "Press Button Again...",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );*/

        _uploadData_two();

      }
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  Future<void> _uploadData_two() async {
    if (_AddharCard_FrontImage == null || _AddharCard_BackImage == null || _PasportSize_Photo == null) {
      print('Image and name are required');
      Fluttertoast.showToast(
          msg: "Image and name are required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    formattedDate = "${now.day}-${now.month}-${now.year}";

    setState(() {
      _isLoading = true;
    });


    try {
      final mimeTypeData = lookupMimeType(_AddharCard_FrontImage!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData1 = lookupMimeType(_AddharCard_BackImage!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData2 = lookupMimeType(_PasportSize_Photo!.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse('https://verifyserve.social/PHP_Files/Main_Document/Add_Document_api/insert.php'), // Replace with your API endpoint
      );

      final file = await http.MultipartFile.fromPath(
        'addhar_front',
        _AddharCard_FrontImage!.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      );
      final file1 = await http.MultipartFile.fromPath(
        'addhar_back',
        _AddharCard_BackImage!.path,
        contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]),
      );
      final file2 = await http.MultipartFile.fromPath(
        'passprot_size',
        _PasportSize_Photo!.path,
        contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]),
      );



      // Text Feild
      imageUploadRequest.fields['Name_'] = _name.text;
      imageUploadRequest.fields['Number'] = _number.text;
      imageUploadRequest.fields['Father_name'] = _Father_name.text;
      imageUploadRequest.fields['Occupation'] = _Occupation.text;
      imageUploadRequest.fields['Date_of_birth'] = _Dateofbirth.text;
      imageUploadRequest.fields['Permanent_address'] = _Permanant_Address.text;
      imageUploadRequest.fields['District'] = _District.text;
      imageUploadRequest.fields['Pin_code'] = _PinCode.text;
      imageUploadRequest.fields['Police_station'] = _Police_Station.text;
      imageUploadRequest.fields['Place'] = _place.text;
      imageUploadRequest.fields['Currunt_date'] = formattedDate.toString();

      imageUploadRequest.files.add(file);
      imageUploadRequest.files.add(file1);
      imageUploadRequest.files.add(file2);

      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Data uploaded successfully');
        fetchData();
        final result_Owner = await fetchData();
        //Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", "Owner id", " ", tempArray.toString(), "Processing");
        if (tempArray.toString() == "[Police Verification, Rent Agreement]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 598");

        if (tempArray.toString() == "[Rent Agreement]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 299");

        if (tempArray.toString() == "[Police Verification]")
          Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, " ", tempArray.toString(), "Pending Tenant Details", "Rs 299");

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ApplyDocument_Owner(),), (route) => route.isFirst);
        setState(() {
          _isLoading = false;
        });
      } else {

        setState(() {
          _isLoading = true;
        });
        /*print('Data upload failed with status: ${response.statusCode}');

        Fluttertoast.showToast(
            msg: "Press Button Again...",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );*/

        _uploadData();

      }
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  List<String> name = ['Police Verification','Rent Agreement'];

  List<String> tempArray = [];



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
        child: Column(
          children: [

            Center(
              child: Text("Property owner",style: TextStyle(fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          blurStyle: BlurStyle.outer
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Iconsax.sort_copy,size: 15,),
                      //SizedBox(width: 10,),
                      Text(""+_OwnerName/*+abc.data![len].Building_Name.toUpperCase()*/,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 20,
                ),

                GestureDetector(
                  onTap: (){

                    showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Call Property Owner'),
                        content: Text('Do you really want to Call Owner?'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              FlutterPhoneDirectCaller.callNumber('${_OwnerNumber}');
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      ),
                    ) ?? false;
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            blurStyle: BlurStyle.outer
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Iconsax.sort_copy,size: 15,),
                        //SizedBox(width: 10,),
                        Text(""+_OwnerNumber/*+abc.data![len].Building_Name.toUpperCase()*/,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: _pick_AddharCard_FrontImage,
                          child: Text('Pick AddharCard Front Image',style: TextStyle(color: Colors.white),),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          child: _AddharCard_FrontImage != null
                              ? Image.file(_AddharCard_FrontImage!)
                              : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: _pick_AddharCard_BlackImage,
                          child: Text('Pick AddharCard Back Image',style: TextStyle(color: Colors.white),),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          child: _AddharCard_BackImage != null
                              ? Image.file(_AddharCard_BackImage!)
                              : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: _pick_PasportSize_Photo,
                          child: Text('Pick Pasport Size Photo',style: TextStyle(color: Colors.white),),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          child: _PasportSize_Photo != null
                              ? Image.file(_PasportSize_Photo!)
                              : Center(child: Text('No image selected.',style: TextStyle(color: Colors.white),)),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 155,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _name,
                              decoration: InputDecoration(
                                  hintText: "Your Name",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: Text('Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 155,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _number,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Your Number",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 0,
                  ),

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Father Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 155,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _Father_name,
                              decoration: InputDecoration(
                                  hintText: "Father Name",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: Text('Owner Place',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 155,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _place,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Owner Place",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 0,
                  ),

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Owner Occupation',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _Occupation,
                              decoration: InputDecoration(
                                  hintText: "Owner Occupation",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: Text('Owner DOB',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _Dateofbirth,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                  hintText: "Owner DOP",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 0,
                  ),

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Permanent Address',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _Permanant_Address,
                              decoration: InputDecoration(
                                  hintText: "Permanent Address",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        width: 5,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: Text('Address Pin Code',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _PinCode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Address Pin Code",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 0,
                  ),

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Address District',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _District,
                              decoration: InputDecoration(
                                  hintText: "Address District",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: Text('Police Station',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

                          SizedBox(height: 5,),

                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // boxShadow: K.boxShadow,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _Police_Station,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Address Police St",
                                  hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                  border: InputBorder.none),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),

                    ],
                  ),



                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: name.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        if(tempArray.contains(name[index].toString())){
                          tempArray.remove(name[index].toString());
                        }else{
                          tempArray.add(name[index].toString());
                        }
                      });

                      print(tempArray.toString());

                    },
                    child: Card(
                      child: ListTile(
                        title: Text(name[index].toString()),
                        trailing: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: tempArray.contains(name[index].toString()) ? Colors.red : Colors.green,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(tempArray.contains(name[index].toString()) ? 'Remove' : 'Add'),
                          ),
                        ),
                      ),
                    ),
                  );
                }),

            SizedBox(height: 20),

            Column(
              children: [
                if (tempArray.toString() == "[Police Verification, Rent Agreement]") Text("Rs 598".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5
                  ),
                ),
                if (tempArray.toString() == "[Rent Agreement]") Text("Rs 299".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5
                  ),
                ),
                if (tempArray.toString() == "[Police Verification]") Text("Rs 299".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5
                  ),
                ),

              ],
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Show_realestete(),), (route) => route.isFirst);

                final responce = await http.get(Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_count_document?number=${_TenantNumber.toString()}"));

                print(responce.body);

                if (responce.body == '[{"logg":1}]') {

                  _uploadData();
                  fetchData();
                  final result_Owner = await fetchData();

                  fetchData_Tenant();
                  final result_Tenant = await fetchData_Tenant();

                  if (tempArray.toString() == "[Police Verification, Rent Agreement]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, result_Tenant.first.id, tempArray.toString(), "Payment Pending", "Rs 598");

                  if (tempArray.toString() == "[Rent Agreement]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, result_Tenant.first.id, tempArray.toString(), "Payment Pending", "Rs 299");

                  if (tempArray.toString() == "[Police Verification]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", result_Owner.first.id, result_Tenant.first.id, tempArray.toString(), "Payment Pending", "Rs 299");

                  //Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", "Owner id", result_Tenant.first.id, tempArray.toString(), "Processing");


                  // Successful login
                } else {
                  // Failed login
                  _uploadData();
                  fetchData_Tenant();
                  final result_Tenant = await fetchData_Tenant();
                  //Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", "Owner id", " ", tempArray.toString(), "Processing");
                  if (tempArray.toString() == "[Police Verification, Rent Agreement]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", " ", result_Tenant.first.id, tempArray.toString(), "Pending Owner Details", "Rs 598");

                  if (tempArray.toString() == "[Rent Agreement]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", " ", result_Tenant.first.id, tempArray.toString(), "Pending Owner Details", "Rs 299");

                  if (tempArray.toString() == "[Police Verification]")
                    Insurt_Document(_OwnerName, _OwnerNumber, _TenantName, _TenantNumber, "floor_number_tanant", "flat_number_tanant", "rent_amount_tanat", "owner_fathername", "tanant_fathername", "owner_occupation", "tanant_occupation", "owner_dateofbirth", "tanant_dateofbirth", "owner_permanant_address", "tanant_permanant_address", "owner_district", "tanant_district", "owner_permanant_address_police_station", "tanant_permanant_address_police_station", "owner_permanant_address_pincode", "tanant_permanant_address_pincode", "owner_place", "tanant_place", "tananted_address", "tananted_address_district", "tananted_address_police_station", "tananted_address_pincode", "tananted_place", "current_date_", " ", result_Tenant.first.id, tempArray.toString(), "Pending Owner Details", "Rs 299");

                }

              },
              child: Center(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Colors.red.withOpacity(0.8)),
                  child: const Center(
                    child: Text(
                      "Apply for Document",
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

          ],
        ),
      ),

    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _OwnerNumber = prefs.getString('_Owner_No_Document') ?? '';
      _OwnerName = prefs.getString('_Owner_Name_Document') ?? '';
      _TenantNumber = prefs.getString('_Tenant_No_Document') ?? '';
      _TenantName = prefs.getString('_Tenant_Name_Document') ?? '';
      Subid = prefs.getString('_buildingid') ?? '';
    });


  }

}
