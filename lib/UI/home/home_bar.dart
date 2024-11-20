import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:verify/UI/home/home_screen.dart';
import 'package:verify/UI/profile/profile.dart';
import 'package:verify/UI/widgets/comingSoon.dart';

class HomeBar extends StatefulWidget {
  static const route = "/HomeBar";
  const HomeBar({Key? key}) : super(key: key);

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {

  List<Widget> pages = [
    const HomeScreen(),
    //const ComingSoon(isLeading: false),
    const ProfilePage()
  ];
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: ValueListenableBuilder(
    //       valueListenable: currentIndex,
    //       builder: (context, int index, _) {
    //         return pages[index];
    //       }
    //   ),
    //   bottomNavigationBar: ValueListenableBuilder(
    //       valueListenable: currentIndex,
    //       builder: (context, int index, _) {
    //         return BottomNavigationBar(
    //           currentIndex: index,
    //           showUnselectedLabels: true,
    //           // type: BottomNavigationBarType.shifting,
    //           selectedItemColor: Colors.red,
    //           unselectedItemColor: Colors.white,
    //           backgroundColor: Colors.black,
    //           onTap: (v) {
    //             setState(() {
    //               currentIndex.value = v;
    //             });
    //           },
    //           items: const [
    //             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",backgroundColor: Colors.black),
    //             BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News",backgroundColor: Colors.black),
    //             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile",backgroundColor: Colors.black),
    //           ],
    //         );
    //       }
    //   ),
    // );
    return WillPopScope(
        onWillPop: () async{
          if (currentIndex != currentIndex) {
            // If not on the home screen, go back to home screen
            setState(() {
              currentIndex == 0;
            });
            return false; // Do not exit the app
          }else {
            // If on the home screen, prompt to exit the app
            return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you want to exit the app?'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ?? false;
          }
        },
        child: Scaffold(
          body: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, int index, _) {
                  return pages[index];
              }
          ),
          bottomNavigationBar: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, int index, _) {
                return Container(
                  //padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: BottomNavigationBar(
                      currentIndex: index,
                      elevation: 8.0, // Add elevation for a shadow-like effect
                      showUnselectedLabels: true,
                      showSelectedLabels: true,
                      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.red,
                      unselectedItemColor: Colors.white,
                      backgroundColor: Colors.black,
                      onTap: (v) {
                        setState(() {
                          currentIndex.value = v;
                        });
                      },
                      items: const [
                        BottomNavigationBarItem(icon: Icon(Iconsax.home_copy), label: "Home",backgroundColor: Colors.black),
                        //BottomNavigationBarItem(icon: Icon(PhosphorIcons.newspaper), label: "News",backgroundColor: Colors.black),
                        BottomNavigationBarItem(icon: Icon(Iconsax.user_copy), label: "Profile",backgroundColor: Colors.black),
                      ],
                    ),
                  ),
                );
              }
          ),
        )
        );
  }
}