import 'package:flutter/material.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:flutter_learning_app/models/booked_load.dart';
import 'widgets/booked_load_holder.dart';

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: HttpController.getBookedHistory(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BookedLoad>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text("No history found"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  BookedLoad load = snapshot.data[index];
                  return BookedLoadHolder(
                    capacity:
                        "${load.fid.loadWeight} (Ton) ${load.fid.truckRequire}",
                    expectedRate: "Rs ${load.bidAmount}",
                    from: load.fid.pickupLocation,
                    to: load.fid.dropLocation,
                    postedAt: load.date.split('T')[0],
                    type: load.fid.loadType,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
