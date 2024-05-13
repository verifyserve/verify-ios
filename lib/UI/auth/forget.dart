import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/constant.dart';
import '../widgets/top_snackbar/top_snack_bar.dart';
import 'login.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
  }

  class _ForgetPageState extends State<ForgetPage> {

    late TextEditingController _email = TextEditingController();
    final TextEditingController _newpass = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<void> fetchdata(email,pass) async{
      final responce = await http.get(Uri.parse("https://verifyserve.social/WebService1.asmx/Forget?email=$email&pass=$pass"));
      //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

      if(responce.statusCode == 200){
        print(responce.body);

        //SharedPreferences prefs = await SharedPreferences.getInstance();

      } else {
        print('Failed Registration');
      }

    }

    // Ensure string has two uppercase letters.
    // Ensure string has one special case letter.
    // Ensure string has two digits.
    // Ensure string has three lowercase letters.`

    bool _validatePassword(String password) {
      RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      return passwordRegex.hasMatch(password);
    }

    bool _isNewPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 150,
                  child: Image.asset(AppImages.verify,height: 250,width: 250,),
                ),
              ),
              const Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.3),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter the email address associated with your account!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[300],
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    )),
              ),
              SizedBox(height: 5,),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextFormField(
                  controller: _email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Registered Email Address";
                      }
                    },
                  decoration: InputDecoration(
                      hintText: "Enter Registered Email",
                      contentPadding: EdgeInsets.all(12),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.grey[900],
                      ),
                      hintStyle: TextStyle(color: Colors.grey[700],fontFamily: 'Poppins', fontWeight: FontWeight.w500,fontSize: 18),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'New Password',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    )),
              ),
              const SizedBox(height: 5,),

              // Ensure string has two uppercase letters.
              // Ensure string has one special case letter.
              // Ensure string has two digits.
              // Ensure string has three lowercase letters.

              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.red.withOpacity(0.8)),
                ),
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text('Password must contain at least 8 characters, 1 uppercase, 2 lowercase, 2 digits & special character.', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                    fontFamily: 'Poppins',letterSpacing: 0.5 ),textAlign: TextAlign.start),
              ),

              const SizedBox(
                height: 5,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _newpass,
                  onChanged: (new_password) {
                    setState(() {
                      _isNewPasswordValid = _validatePassword(new_password);
                    });
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: InputDecoration(
                      hintText: "At least 8 characters",
                      prefixIcon: Icon(
                        Iconsax.security_user_copy,
                        color: Colors.blueGrey,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[900],fontFamily: 'Poppins', fontWeight: FontWeight.w500,fontSize: 18),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 3.0),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 20),
                  child: Text(
                    _isNewPasswordValid ? 'New password is valid' : '',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: _isNewPasswordValid ? Colors.green : Colors.red,),),
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate() && _isNewPasswordValid) {
                    fetchdata(_email.text, _newpass.text);
                    Navigator.pop(context);
                  }else{
                    showTopSnackBar(
                      context,
                      CustomSnackBar.info(
                        message:
                        "Enter Valid Data!",
                      ),);
                  }
                },
                child: Center(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                        color: Colors.red.withOpacity(0.8)
                    ),
                    child: Center(
                      child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>LoginPage()));
                    },
                    child: Text(
                      'Back to login',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange.shade900,
                          decorationThickness: 1.5,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.red.withOpacity(0.8)),
                    )),
              ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
