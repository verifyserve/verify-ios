import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/constant.dart';

class PdfViewScreen extends StatelessWidget {
  final String pdfPath;
  const PdfViewScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
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
        body: Container(
          child: SfPdfViewer.network(pdfPath,
            canShowPaginationDialog: true,
            pageSpacing: 2.0,
            onDocumentLoadFailed: (details) {
              Fluttertoast.showToast(
                  msg: "No Document Found!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              print('Failed');
            },
            enableDoubleTapZooming: true,
          ),
        )
    );
  }
}