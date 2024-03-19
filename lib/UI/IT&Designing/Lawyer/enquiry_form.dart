import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../utils/constant.dart';

class EnquiryForm extends StatefulWidget {
  const EnquiryForm({super.key});

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {

  final TextEditingController name = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController purpose = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'Enquiry Form!',
                    //   style: TextStyle(
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w500,
                    //       color: Colors.white,
                    //       fontFamily: 'Poppins',
                    //       letterSpacing: 0.3),
                    // ),
                    Image(image: AssetImage('assets/images/enquiry support.png'),width: 250),
                    const SizedBox(
                      height: 0,
                    ),
                    Text(
                      'Send your Enquiry to contact lawyer.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins'),
                  )),
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
                child: TextField(
                  controller: name,
                  onSubmitted: (value) {
                    name.text = value;
                  },
                  decoration: const InputDecoration(
                      hintText: "Your Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Contact',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins'),
                  )),
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
                child: TextField(
                  controller: mobile,
                  onSubmitted: (value) {
                    mobile.text = value;
                  },
                  // maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                      hintText: "Contact Number",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Purpose',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins'),
                  )),
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
                child: TextField(
                  controller: purpose,
                  onSubmitted: (value) {
                    purpose.text = value;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter Your Purpose",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: (){

                },
                child: Center(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                        color: Colors.red.withOpacity(0.8)
                    ),
                    child: const Center(
                      child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}