class Load {
  String date;
  String sId;
  String pickupLocation;
  String dropLocation;
  String loadWeight;
  int loadRate;
  String loadType;
  String uid;
  String truckRequire;
  int iV;

  Load(
      {this.date,
      this.sId,
      this.truckRequire,
      this.pickupLocation,
      this.dropLocation,
      this.loadWeight,
      this.loadRate,
      this.loadType,
      this.uid,
      this.iV});

  Load.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sId = json['_id'];
    pickupLocation = json['pickup_location'];
    dropLocation = json['drop_location'];
    loadWeight = json['load_weight'];
    loadRate = json['load_rate'];
    loadType = json['load_type'];
    uid = json['uid'];
    truckRequire = json['truck_require'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['_id'] = this.sId;
    data['pickup_location'] = this.pickupLocation;
    data['drop_location'] = this.dropLocation;
    data['load_weight'] = this.loadWeight;
    data['load_rate'] = this.loadRate;
    data['load_type'] = this.loadType;
    data['uid'] = this.uid;
    data['__v'] = this.iV;
    return data;
  }
}
