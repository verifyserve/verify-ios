import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {

  final id;
  const NewScreen({super.key,this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id)),
    );
  }
}
