import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/auth/register.dart';
import 'package:verify/UI/home/home_bar.dart';
import 'package:verify/UI/home/home_screen.dart';
import 'package:verify/bloc/authBloc.dart';
import 'package:verify/data/repository/AuthRepository.dart';
import 'package:verify/utils/constant.dart';
import 'package:verify/utils/message_handler.dart';

import 'forget.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc bloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String deviceTokenUpdatedToken = "";

  @override
  void initState() {
    getDeviceTokenToSendNotification();
    bloc = AuthBloc(context.read<AuthRepository>());
    super.initState();
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.loginStreamController.stream.listen((event) {
      if (event == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeBar.route, (route) => false);
      }
      if (event == "Register") {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> getDeviceTokenToSendNotification() async {
    await Future.delayed(Duration(seconds: 2));
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenUpdatedToken = token.toString();
    print("Updated Token Value = $deviceTokenUpdatedToken");
    print("Successfully got updated token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Image.asset(
                  AppImages.verify,
                  height: 170,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              const Text(
                'Sign In!',
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
              //Hey, Enter your details to get sign in to your account
              Text(
                'Hey, Login or Signup to get enter in Verify App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Number',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[300],
                          fontFamily: 'Poppins'),
                    )),
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
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: bloc.mobileController,
                  onFieldSubmitted: (value) {
                    bloc.mobileController.text = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Number";
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                      hintText: "Mobile No",
                      prefixIcon: Icon(
                        Iconsax.mobile_copy,
                        color: Colors.blueGrey,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[300],
                        fontFamily: 'Poppins'),
                  )),
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
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        obscureText: visible,
                        controller: bloc.passController,
                        onFieldSubmitted: (value) {
                          bloc.passController.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",

                            prefixIcon: const Icon(
                              Iconsax.security_user_copy,
                              color: Colors.blueGrey,
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
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(right: 30),
                  child: InkWell(
                    onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => ForgetPage()));
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.4,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[200]),
                    ),
                  )
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                  valueListenable: bloc.loginLoader,
                  builder: (context, bool loading, _) {
                    return GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          bloc.login();

                          final dio = Dio();
                          var data = await dio.get('https://verifyserve.social/WebService2.asmx/Update_Token',
                              queryParameters: {
                                "Tokenno": "${deviceTokenUpdatedToken}",
                                "mobile": "${bloc.mobileController.text}",
                              });
                          var res = jsonDecode(data.data);
                          print(res.runtimeType);
                          print('Updated Successfully');
                          print('Updated token = ${deviceTokenUpdatedToken}');
                          print('Controller = ${bloc.mobileController}');
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeBar()));
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 0.7.sw,
                          // margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.red.withOpacity(0.8)),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        fontSize: 18),
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
                    "Don't Have An Account?",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400]),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Provider.value(
                                    value: bloc, child: const Register())));
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            // decoration: TextDecoration.underline,
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