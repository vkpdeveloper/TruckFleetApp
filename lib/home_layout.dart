import 'package:flutter/material.dart';

import 'controllers/http_controller.dart';
import 'models/load.dart';
import 'widgets/load.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  TextEditingController _pickUpLocation = TextEditingController();
  TextEditingController _dropLocation = TextEditingController();
  List<Load> _allLoads;

  @override
  void initState() {
    super.initState();
    HttpController.getAllLoads().then((List<Load> data) {
      _allLoads = data;
      setState(() {});
    });
    _pickUpLocation.addListener(onPickUpChanged);
    _dropLocation.addListener(onPickUpChanged);
  }

  onPickUpChanged() {
    String dropLocation = _dropLocation.text;
    String pickUpLocation = _pickUpLocation.text;
    if (pickUpLocation.length != 0) {
      _allLoads = _allLoads
          .where((e) => e.pickupLocation
              .toLowerCase()
              .contains(pickUpLocation.toLowerCase()))
          .toList();
      if (dropLocation.length != 0) {
        _allLoads = _allLoads
            .where((e) =>
                e.pickupLocation
                    .toLowerCase()
                    .contains(pickUpLocation.toLowerCase()) &&
                e.dropLocation
                    .toLowerCase()
                    .contains(dropLocation.toLowerCase()))
            .toList();
      }
      setState(() {});
    } else if (dropLocation.length != 0) {
      _allLoads = _allLoads
          .where((e) =>
              e.dropLocation.toLowerCase().contains(dropLocation.toLowerCase()))
          .toList();
    } else {
      HttpController.getAllLoads().then((List<Load> data) {
        _allLoads = data;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _pickUpLocation,
                  decoration: InputDecoration(
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
                      hintText: "Enter loading point"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _dropLocation,
                  decoration: InputDecoration(
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
                      hintText: "Enter loading point"),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      child: Text(
                        "Find loads",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      color: Theme.of(context).accentColor,
                    )
                  ],
                )
              ],
            ),
          ),
          _allLoads == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _allLoads.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: true,
                  itemBuilder: (context, index) {
                    Load load = _allLoads[index];
                    return LoadHolder(
                      id: load.sId,
                      capacity: "${load.loadWeight}(Ton) ${load.truckRequire}",
                      from: load.pickupLocation,
                      to: load.dropLocation,
                      expectedRate: "Rs. ${load.loadRate}",
                      postedAt: load.date.split("T")[0],
                      type: load.loadType,
                    );
                  },
                )
        ],
      ),
    );
  }
}
