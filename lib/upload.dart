import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learning_app/edit_profile.dart';
import 'package:flutter_learning_app/providers/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadDocument extends StatefulWidget {
  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Shreem Fleet",
                          style: GoogleFonts.sofia(fontSize: 25))
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Text(
                      "Trusted By 1,00,000+ Transporters",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/truck.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Upload Document",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    onPressed: () async {
                      PickedFile aadhaarFile = await _imagePicker.getImage(
                          source: ImageSource.gallery);
                      if (aadhaarFile != null) {
                        Provider.of<LoginProvider>(context, listen: false)
                            .setAadhaar(File(aadhaarFile.path));
                      }
                    },
                    child: Text(
                      provider.aadhaar != null
                          ? "Aadhaar image selected"
                          : "Upload Aadhar Card",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    textColor: Theme.of(context).primaryColor,
                    color: Color(0xffD5D6DB),
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    onPressed: () async {
                      PickedFile panFile = await _imagePicker.getImage(
                          source: ImageSource.gallery);
                      if (panFile != null) {
                        Provider.of<LoginProvider>(context, listen: false)
                            .setPan(File(panFile.path));
                      }
                    },
                    child: Text(
                      provider.aadhaar != null
                          ? "Pan card selected"
                          : "Upload Pan Card",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    textColor: Theme.of(context).primaryColor,
                    color: Color(0xffD5D6DB),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text("Didn’t receive the OTP? Resend OTP")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 40,
                      minWidth: MediaQuery.of(context).size.width / 2,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile())),
                      child: Text("Submit"),
                      textColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
