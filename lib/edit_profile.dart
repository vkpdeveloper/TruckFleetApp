import 'package:flutter/material.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:flutter_learning_app/main.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'providers/login.dart';
import 'providers/user_provider.dart';

class EditProfile extends StatefulWidget {
  final bool loggedIn;

  const EditProfile({Key key, this.loggedIn = false}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _location = TextEditingController();
  bool _isLoading = false;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _phone.text = Provider.of<LoginProvider>(context, listen: false).phone;
    _userProvider = Provider.of<UserProvider>(context);
    User user = _userProvider.user;
    if (widget.loggedIn) {
      _name.text = user.name;
      _email.text = user.email;
      _company.text = user.companyName;
      _location.text = user.location;
      _phone.text = user.mobile.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Image.asset(
                  "assets/truck-header-banner 1.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    bottom: -20,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 45,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Enter name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        controller: _company,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.business),
                            hintText: "Enter company name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Enter email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        controller: _phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Enter phone",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        controller: _location,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_pin),
                            hintText: "Enter your location",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !_isLoading
                            ? MaterialButton(
                                height: 40,
                                minWidth: MediaQuery.of(context).size.width / 2,
                                onPressed: () async {
                                  provider.setInfo(_email.text, _name.text,
                                      _company.text, _location.text);
                                  bool isDone =
                                      await HttpController.postProfile(
                                          provider);
                                  if (isDone) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                },
                                child: Text("Save Profile"),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
