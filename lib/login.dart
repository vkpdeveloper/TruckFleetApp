import 'package:flutter/material.dart';
import 'package:flutter_learning_app/verify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  //Method for generate otp from firebase

  //Method for verify otp entered by user
  Future<void> verifyOtp() async {
    if (smsOTP == null || smsOTP == '') {
      showAlertDialog(context, 'please enter 6 digit otp');
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User currentUser = _auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      setState(() {
        _isLoading = true;
      });
      // Call the screen
    } catch (e) {
      // print(e);
      handleError(e as PlatformException);
    }
  }

  //Method for handle the errors
  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message);
        break;
    }
  }

  //Basic alert dialogue for alert errors and confirmations
  void showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    "Hey, What is your mobile number?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width - 20,
                        child: IntlPhoneField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                      )
                    ],
                  )
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
                Text(
                  "By signing up I am accepting Terms of use and Privacy Policy",
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 40,
                      minWidth: MediaQuery.of(context).size.width / 2,
                      onPressed: () async {
                        if (_controller.text.length == 10) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyScreen(
                                        phoneNumber: "+91${_controller.text}",
                                        verificationId: verificationId,
                                      )));
                        } else {
                          showAlertDialog(context, "Invalid phone number");
                        }
                      },
                      child: Text("Login/SignUp"),
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
