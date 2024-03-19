import 'package:flutter/material.dart';
import 'package:verify/UI/auth/login.dart';
import 'package:verify/UI/auth/register.dart';
import 'package:verify/UI/home/home_bar.dart';
import 'package:verify/UI/splash/splash.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    Splash.route: (context) => const Splash(),
    HomeBar.route: (context) => const HomeBar(),
    LoginPage.route: (context) => const LoginPage(),
   // Register.route: (context) => const Register(),
  };
}