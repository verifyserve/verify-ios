import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class FetchImagePage extends StatefulWidget {
  String image;
  FetchImagePage({super.key, required this.image});

  @override
  _FetchImagePageState createState() => _FetchImagePageState();
}

class _FetchImagePageState extends State<FetchImagePage> {


  @override
  void initState() {
    super.initState();
    //fetchImage();
  }

  // Function to fetch image from API
  /*Future<void> fetchImage() async {
    final response = await http.get(Uri.parse('https://yourapi.com/getImage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        imageUrl = data['image_url']; // Update with the key used by your API
      });
    } else {
      throw Exception('Failed to load image');
    }
  }*/

  @override
  Widget build(BuildContext contt) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 55),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
        ),
      ),
      body: Center(
        child: "${widget.image}" == null
            ? CircularProgressIndicator()
            : Image.network(widget.image), // Display the image from the URL
      ),
    );
  }
}
