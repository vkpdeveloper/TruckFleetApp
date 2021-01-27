class User {
  String sId;
  String email;
  String name;
  int mobile;
  String companyName;
  String location;
  int iV;

  User(
      {this.sId,
      this.email,
      this.name,
      this.mobile,
      this.companyName,
      this.location,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    location = json['location'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['company_name'] = this.companyName;
    data['location'] = this.location;
    data['__v'] = this.iV;
    return data;
  }
}
