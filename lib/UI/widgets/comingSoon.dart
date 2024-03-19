import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verify/UI/home/home_screen.dart';
import 'package:verify/utils/constant.dart';

class ComingSoon extends StatelessWidget {
  final bool isLeading;
  const ComingSoon({super.key, required this.isLeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
        leading: isLeading
            ? InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                 // Navigator.pop(context);
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
              )
            : const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.comingSoon,height: 200,width: 0.7.sw,),
            const SizedBox(height: 40,),
            const Text(
              "Coming Soon!",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 30),
            ),
            const SizedBox(height: 10,),
             Text(
              // "Stay tuned for our upcoming feature - it's coming soon to enhance your experience!",
               "Dear user, exciting things are in store for you! An upcoming feature is in its final stages of preparation, and we can't wait to roll it out to you very soon.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.7),fontWeight: FontWeight.w400,fontSize: 15),
            ),
            const SizedBox(height: 20,),
            isLeading? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 45,
                // width: 0.47.sw,
                margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.red),
                child:const Center(
                  child: Text(
                    "Back to Previous Page",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        // letterSpacing: 0.8,
                        fontSize: 16),
                  ),
                ),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
