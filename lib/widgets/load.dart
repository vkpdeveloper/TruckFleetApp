import 'package:flutter/material.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';

class LoadHolder extends StatefulWidget {
  final String from;
  final String to;
  final String postedAt;
  final String type;
  final String capacity;
  final String expectedRate;
  final String id;

  const LoadHolder(
      {Key key,
      this.from,
      this.to,
      this.postedAt,
      this.type,
      this.capacity,
      this.expectedRate,
      this.id})
      : super(key: key);

  @override
  _LoadHolderState createState() => _LoadHolderState();
}

class _LoadHolderState extends State<LoadHolder> {
  bool _isRateNegotiable = false;
  bool _isImmediatelyAvailable = false;

  TextEditingController _rateController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 172,
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
                  height: 35,
                  width: 35,
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
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    Text(
                      "${widget.postedAt}",
                      style: TextStyle(color: Color(0xffC4C4C4), fontSize: 11.0),
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
                          size: 18,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.type}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
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
                          size: 18,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.capacity}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
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
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.expectedRate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 13.0
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).accentColor,
                      height: 30,
                      onPressed: () => showBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) => StatefulBuilder(
                                builder: (context, _setState) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_pin,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${widget.from} - ${widget.to}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0),
                                                      ),
                                                      Text(
                                                        "${widget.capacity}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffC4C4C4)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  child: Icon(Icons.close),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: _rateController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Please enter your rate(In Rs.)"),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              CheckboxListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                value: _isRateNegotiable,
                                                onChanged: (val) => _setState(
                                                    () => _isRateNegotiable =
                                                        val),
                                                title: Text("Rate Negotiable"),
                                              ),
                                              CheckboxListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                value: _isImmediatelyAvailable,
                                                onChanged: (val) => _setState(
                                                    () =>
                                                        _isImmediatelyAvailable =
                                                            val),
                                                title: Text(
                                                    "Immediately Available"),
                                              ),
                                              SizedBox(height: 15),
                                              TextField(
                                                controller: _commentController,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Enter your comments here..! (Optional)",
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffD9E7EE)),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  MaterialButton(
                                                    height: 40,
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    onPressed: () async {
                                                      bool isDone =
                                                          await HttpController.bookLoad(
                                                              bidAmount:
                                                                  _rateController
                                                                      .text,
                                                              amountType: "Rs",
                                                              availability:
                                                                  _isImmediatelyAvailable,
                                                              negotiable:
                                                                  _isRateNegotiable,
                                                              fid: widget.id);
                                                      if (isDone) {
                                                        Navigator.pop(context);
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Load request is successful"),
                                                        ));
                                                      } else {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Failed to send request"),
                                                        ));
                                                      }
                                                    },
                                                    child: Text("Send Request"),
                                                    textColor: Theme.of(context)
                                                        .accentColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    color: Theme.of(context)
                                                        .primaryColor,
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
                              )),
                      child: Text("Book Now"),
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
