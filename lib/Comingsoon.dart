import 'package:flutter/material.dart';

class coming extends StatefulWidget {
  const coming({super.key});

  @override
  State<coming> createState() => _comingState();
}

class _comingState extends State<coming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,


      body: Center(child: Text("Coming Soon",style: TextStyle(color: Colors.white),),),

    );
  }
}
