import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  final String data;
  const demo({Key? key, required this.data}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(''),
      ),
    );
  }
}
