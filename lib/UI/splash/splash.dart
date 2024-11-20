import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/auth/login.dart';
import 'package:verify/UI/home/home_bar.dart';
import 'package:verify/utils/constant.dart';

class Splash extends StatefulWidget {
  static const route = "/";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    init();

  }

  init()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? login = pref.getString("id");
    if(login !=null){
      if(login.isNotEmpty){
        Navigator.of(context).pushReplacementNamed(HomeBar.route);
      }else{
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    }else{
      Navigator.of(context).pushReplacementNamed(LoginPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: 0.70.sw, fit: BoxFit.fitWidth,),
             ],
        ),
      ),
    );
  }
}
