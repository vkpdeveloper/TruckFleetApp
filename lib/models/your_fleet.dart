class MyFleet {
  String date;
  String sId;
  String pickupLocation;
  String dropLocation;
  String truckNumber;
  int fleetRate;
  String fleetCapacity;
  String fleetType;
  String uid;
  int iV;

  MyFleet(
      {this.date,
        this.sId,
        this.pickupLocation,
        this.dropLocation,
        this.truckNumber,
        this.fleetRate,
        this.fleetCapacity,
        this.fleetType,
        this.uid,
        this.iV});

  MyFleet.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sId = json['_id'];
    pickupLocation = json['pickup_location'];
    dropLocation = json['drop_location'];
    truckNumber = json['truck_number'];
    fleetRate = json['fleet_rate'];
    fleetCapacity = json['fleet_capacity'];
    fleetType = json['fleet_type'];
    uid = json['uid'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['_id'] = this.sId;
    data['pickup_location'] = this.pickupLocation;
    data['drop_location'] = this.dropLocation;
    data['truck_number'] = this.truckNumber;
    data['fleet_rate'] = this.fleetRate;
    data['fleet_capacity'] = this.fleetCapacity;
    data['fleet_type'] = this.fleetType;
    data['uid'] = this.uid;
    data['__v'] = this.iV;
    return data;
  }
}
