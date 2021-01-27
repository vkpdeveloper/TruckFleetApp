import 'package:flutter_learning_app/models/load.dart';

class BookedLoad {
  String date;
  bool confirmed;
  String sId;
  int bidAmount;
  String amountType;
  bool negotiable;
  bool availability;
  Load fid;
  String uid;
  int iV;

  BookedLoad(
      {this.date,
      this.confirmed,
      this.sId,
      this.bidAmount,
      this.amountType,
      this.negotiable,
      this.availability,
      this.fid,
      this.uid,
      this.iV});

  BookedLoad.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    confirmed = json['confirmed'];
    sId = json['_id'];
    bidAmount = json['bid_amount'];
    amountType = json['amount_type'];
    negotiable = json['negotiable'];
    availability = json['availability'];
    fid = json['fid'] != null ? new Load.fromJson(json['fid']) : null;
    uid = json['uid'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['confirmed'] = this.confirmed;
    data['_id'] = this.sId;
    data['bid_amount'] = this.bidAmount;
    data['amount_type'] = this.amountType;
    data['negotiable'] = this.negotiable;
    data['availability'] = this.availability;
    if (this.fid != null) {
      data['fid'] = this.fid.toJson();
    }
    data['uid'] = this.uid;
    data['__v'] = this.iV;
    return data;
  }
}
