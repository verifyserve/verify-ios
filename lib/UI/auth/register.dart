import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/auth/login.dart';
import 'package:verify/bloc/authBloc.dart';
import 'package:verify/utils/constant.dart';

import '../widgets/top_snackbar/top_snack_bar.dart';

class Register extends StatefulWidget {
  static const route = "/Register";
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late AuthBloc bloc;
  bool isTextFieldVisible = false;
  //String deviceTokenToSendPushNotification = "";

  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    super.initState();
  //  getDeviceTokenToSendNotification();
    bloc.passController.text = "";
    bloc.mobileController.text = "";
  }

  // Future<void> getDeviceTokenToSendNotification() async {
  //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  //   final token = await _fcm.getToken();
  //   deviceTokenToSendPushNotification = token.toString();
  //   print("Token Value = $deviceTokenToSendPushNotification");
  //   bloc.tokenController.text = deviceTokenToSendPushNotification;
  //   print("Successfully got token into Textfield");
  // }

  // bool isValidPassword(String password) {
  //   // Password must contain at least 8 characters, including uppercase, lowercase, and special characters
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regExp = RegExp(pattern);
  //   return regExp.hasMatch(password);
  // }

  //^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$

  /*bool _validatePassword(String password) {
    RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password);
  }*/

  bool _validateEmail(String email) {
    RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid = false;

  bool _isEmailValid = false;

  final _formKey = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
    //Generating Token When App Starts
   // getDeviceTokenToSendNotification();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Image.asset(
                  AppImages.verify,
                  height: 150,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up!',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.3),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Describe yourself clearly so that there are no mistakes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  )),
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
                  controller: bloc.nameController,
                  onSubmitted: (value) {
                    bloc.nameController.text = value;
                  },
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),
                  decoration: InputDecoration(
                      hintText: "Your Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  )),
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
                  controller: bloc.registerEmailController,
                  onSubmitted: (value) {
                    bloc.registerEmailController.text = value;
                  },
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),
                  onChanged: (email) {
                    setState(() {
                      _isEmailValid = _validateEmail(email);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 2.0),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: Column(
                  children: [
                    Text(
                      _isEmailValid ? 'Email is valid' : 'Email is invalid',
                      style: TextStyle(fontSize: 13,
                        color: _isEmailValid ? Colors.green : Colors.red,
                      ),),
                  ],
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Contact',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  )),
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
                  controller: bloc.numberController,
                  onSubmitted: (value) {
                    bloc.numberController.text = value;
                  },
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),
                  // maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                      hintText: "Contact Number",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  )),
              const SizedBox(
                height: 5,
              ),
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
                color: Colors.grey[500],
                fontFamily: 'Poppins',letterSpacing: 0.5 ),textAlign: TextAlign.start),
          ),
              const SizedBox(
                height: 5,
              ),
              ValueListenableBuilder(
                  valueListenable: bloc.passShow,
                  builder: (context, bool visible, _) {
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: K.boxShadow,
                      ),
                      child: TextField(
                        controller: bloc.registerPassController,

                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a password';
                        //   }
                        //   if (!isValidPassword(value)) {
                        //     return 'Must contain uppercase, lowercase, & special characters';
                        //   }
                        //   return null;
                        // },
                        onSubmitted: (value) {
                          bloc.registerPassController.text = value;
                        },
                        // onSaved: (value) {
                        //   bloc.registerPassController.text = value!;
                        // },
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                        inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        ],
                        /*onChanged: (password) {
                          setState(() {
                            _isPasswordValid = _validatePassword(password);
                          });
                        },*/

                        obscureText: visible,
                        decoration: InputDecoration(
                            hintText: "At least 8 characters",
                            prefixIcon: Icon(
                              Iconsax.security_user_copy,
                              color: Colors.black54,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                bloc.passShow.value = !bloc.passShow.value;
                              },
                              child: visible
                                  ? const Icon(
                                      PhosphorIcons.eye_closed,
                                      color: Colors.black54,
                                      size: 20,
                                    )
                                  : const Icon(
                                      PhosphorIcons.eye,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey[900],
                              fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),
                            border: InputBorder.none),
                      ),
                    );
                  }),
              SizedBox(height: 2.0),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: Text(
                  _isPasswordValid ? 'Password is valid' : '',
                  style: TextStyle(fontSize: 13,
                    color: _isPasswordValid ? Colors.green : Colors.red,
                  ),),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
              //   child: FlutterPwValidator(
              //       controller: bloc.registerPassController,
              //       minLength: 6,
              //       uppercaseCharCount: 2,
              //       lowercaseCharCount: 2,
              //       numericCharCount: 3,
              //       specialCharCount: 1,
              //       width: MediaQuery.of(context).size.width,
              //       height: 200,
              //       onSuccess: (){
              //         print("MATCHED");
              //         ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              //             content: new Text("Correct")));
              //       },
              //       onFail: (){
              //         // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              //         //     content: new Text("Wrong")));
              //       }
              //   ),
              // ),
              Visibility(
                visible: false,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    // boxShadow: K.boxShadow,
                  ),
                  child: TextField(
                    controller: bloc.vehicleController,
                    onSubmitted: (value) {
                      bloc.vehicleController.text = value;
                    },
                    decoration: const InputDecoration(
                        hintText: "Vehicle No.",
                        prefixIcon: Icon(
                          PhosphorIcons.car,
                          color: Colors.black54,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[300],
                        fontFamily: 'Poppins'),
                  )),
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
                  controller: bloc.locationController,
                  onSubmitted: (value) {
                    bloc.locationController.text = value;
                  },
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),
                  decoration: InputDecoration(
                      hintText: "Location",
                      prefixIcon: Icon(
                        Iconsax.location_copy,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isTextFieldVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'Token',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                              fontFamily: 'Poppins'),
                        )),
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
                        controller: bloc.tokenController,
                        readOnly: false,
                        onSubmitted: (value) {
                          bloc.tokenController.text = value;
                        },
                        decoration: const InputDecoration(
                            hintText: "",
                            prefixIcon: Icon(
                              Icons.token_outlined,
                              color: Colors.black54,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ValueListenableBuilder(
                  valueListenable: bloc.registerLoader,
                  builder: (context, bool loading, _) {
                    return GestureDetector(
                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   bloc.register();
                        //   if (kDebugMode) {
                        //     print('Registration successful');
                        //   }
                        // }
                        //bloc.register();

                        /*if(_isEmailValid && _isPasswordValid){
                          bloc.register();*/
                        if(_isEmailValid
                        ){
                          bloc.register();
                        }else{
                          showTopSnackBar(
                              context,
                            CustomSnackBar.info(
                              message:
                              "Enter Valid Data!",
                            ),);
                        }
                      },
                     // onTap:  _isPasswordValid ? bloc.register : null,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 0.7.sw,
                          // margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Colors.red.withOpacity(0.8)),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        fontSize: 16),
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),

              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have An Account?",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red.withOpacity(0.8),
                            decorationThickness: 1.5,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.red.withOpacity(0.8)),
                      )),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
