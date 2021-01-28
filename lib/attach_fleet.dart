import 'package:flutter/material.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'providers/user_provider.dart';

class AttachFleet extends StatefulWidget {
  @override
  _AttachFleetState createState() => _AttachFleetState();
}

class _AttachFleetState extends State<AttachFleet> {
  TextEditingController _pickUpLocation = TextEditingController();
  TextEditingController _dropLocation = TextEditingController();
  TextEditingController _truckNumber = TextEditingController();
  TextEditingController _expectedRate = TextEditingController();
  TextEditingController _capacityRate = TextEditingController();
  TextEditingController _fleetType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.user;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        "Hello! " + user.companyName,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                  children: [
                    TextField(
                      controller: _pickUpLocation,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ],
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Enter Pick location"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _dropLocation,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ],
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Enter drop location"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _truckNumber,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Icon(Icons.airport_shuttle_sharp),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Enter Truck Number"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _expectedRate,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Icon(Icons.account_balance_wallet),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Fleet Expected Rate(In Rs.)"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _capacityRate,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Icon(Icons.dashboard),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Fleet Capacity(In Ton)"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _fleetType,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2),
                          prefixIcon: Icon(Icons.local_shipping),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: Colors.white,
                          hintText: "Fleet Type(E.g-LCV Open)"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          height: 40,
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () async {
                            bool isDone = await HttpController.attachFleet(
                                pickUpLocation: _pickUpLocation.text,
                                dropLocation: _dropLocation.text,
                                fleetCapacity: _capacityRate.text,
                                fleetRate: _expectedRate.text,
                                fleetType: _fleetType.text,
                                truckNumber: _truckNumber.text);
                            if (isDone) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text("Fleet attachment successful")));
                              _pickUpLocation.clear();
                              _dropLocation.clear();
                              _capacityRate.clear();
                              _expectedRate.clear();
                              _fleetType.clear();
                              _truckNumber.clear();
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fleet attachment failed")));
                            }
                          },
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
        ),
      ),
    );
  }
}
