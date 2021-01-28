import 'package:flutter/material.dart';

class MyFleetHolder extends StatefulWidget {
  final String from;
  final String to;
  final String postedAt;
  final String type;
  final String capacity;
  final String expectedRate;
  final String id;
  final bool isConfirmed;

  const MyFleetHolder(
      {Key key,
        this.from,
        this.to,
        this.postedAt,
        this.type,
        this.capacity,
        this.expectedRate,
        this.isConfirmed,
        this.id})
      : super(key: key);

  @override
  _MyFleetHolderState createState() => _MyFleetHolderState();
}

class _MyFleetHolderState extends State<MyFleetHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 14, color: Colors.white.withOpacity(0.1))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  "assets/62894-package-icon.png",
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.from} - ${widget.to}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Text(
                      "${widget.postedAt}",
                      style: TextStyle(color: Color(0xffC4C4C4)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.type}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.capacity}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.4)),
                      child: Text(
                        "Expected Rate",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.expectedRate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).accentColor,
                onPressed: () {},
                child: widget.isConfirmed == null
                    ? Text("Not yet confirmed")
                    : Text(widget.isConfirmed
                    ? "Load cancelled"
                    : Text("Confirmed")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
