import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:flutter_learning_app/main.dart';
import 'package:flutter_learning_app/providers/login.dart';
import 'package:flutter_learning_app/providers/user_provider.dart';
import 'package:flutter_learning_app/upload.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './models/user.dart' as userModel;

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerifyScreen({Key key, this.verificationId, this.phoneNumber})
      : super(key: key);
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    generateOtp(widget.phoneNumber);
  }

  Future<void> generateOtp(String contact) async {
    // print(contact);
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      // print(verId);
      verificationId = verId;
      print(verificationId);
      print("OTP Send SUccessfully");
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: contact,
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException exception) {
            // Navigator.pop(context, exception.message);
            print(exception.message);
          });
    } on PlatformException catch (e) {
      print(e);
      handleError(e);
    }
  }

  Future<bool> verifyOtp() async {
    if (smsOTP == null || smsOTP == '') {
      showAlertDialog(context, 'please enter 6 digit otp');
      return false;
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
      return true;
      // Call the screen
    } catch (e) {
      print(e);
      handleError(e as PlatformException);
      return false;
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
    _scaffoldKey.currentState.showBottomSheet((context) => SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    "Enter the OTP sent to your number",
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
                          child: TextField(
                            controller: _controller,
                            maxLength: 6,
                            onChanged: (value) {
                              smsOTP = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Enter One time password"),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Didn’t receive the OTP? Resend OTP")
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
                    !_isLoading
                        ? MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            onPressed: () async {
                              if (smsOTP.length == 6) {
                                setState(() {
                                  _isLoading = true;
                                });
                                bool isDone = await verifyOtp();
                                if (isDone) {
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .phone = widget.phoneNumber;
                                  userModel.User user =
                                      await HttpController.checkUserProfile(
                                          widget.phoneNumber);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (user != null) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user = user;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UploadDocument()));
                                  }
                                }
                              } else {
                                showAlertDialog(context, "Wrong OTP");
                              }
                            },
                            child: Text("Verify Now"),
                            textColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Theme.of(context).primaryColor,
                          )
                        : CircularProgressIndicator()
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
