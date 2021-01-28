import 'package:flutter/material.dart';

import 'widgets/fleet.dart';

class MyFleets extends StatefulWidget {
  final bool loggedIn;
  const MyFleets({Key key, this.loggedIn = false}) : super(key: key);

  @override
  _MyFleetsState createState() => _MyFleetsState();
}

class _MyFleetsState extends State<MyFleets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Your Fleets",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => FleetHolder(
                capacity: "3.50 Tonne(s) Container",
                from: "Jhanshi",
                to: "Lucknow",
                expectedRate: "12000",
                postedAt: "11 JAN 10:35",
                type: "Bottles",
              )),
    );
  }
}
