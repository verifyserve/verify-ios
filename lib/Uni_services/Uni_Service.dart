import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:verify/Uni_services/Context_Utility.dart';

import '../UI/realEstate/Real_Estate_New.dart';

class Uni_Services{

  static String _code = '';
  static String get code => _code;
  static bool get hasCode => _code.isNotEmpty;

  static void reset() => _code = '';

  static init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    }on PlatformException catch (e){
      log(1);
    }
    
    uriLinkStream.listen((Uri? uri) async {
      uniHandler(uri);
    }, onError: (error){
      log(error);
    });
    
  }

  static uniHandler(Uri? uri){
    if(uri == null || uri.queryParameters.isEmpty) return;

    Map<String, String> param = uri.queryParameters;

    String receivedCode = param['code'] ?? '';

    if(receivedCode == "Green"){

      Navigator.push(ContextUtility.context!, MaterialPageRoute(builder: (_) => SliverListExample()));

    }

  }

}