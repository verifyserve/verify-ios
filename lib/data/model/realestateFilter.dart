class RealStateFilters {
  int? tPid;
  String? imagesh;
  String? tital;
  String? locationh;
  String? priceh;
  String? rname;
  String? rtype;
  String? filterlocation;
  String? bhk;
  String? shortdis;
  String? furnished;
  String? speci;
  String? details;

  RealStateFilters(
      {this.tPid,
        this.imagesh,
        this.tital,
        this.locationh,
        this.priceh,
        this.rname,
        this.rtype,
        this.filterlocation,
        this.bhk,
        this.shortdis,
        this.furnished,
        this.speci,
        this.details});

  RealStateFilters.fromJson(Map<String, dynamic> json) {
    tPid = json['TPid'];
    imagesh = json['Imagesh'];
    tital = json['Tital'];
    locationh = json['locationh'];
    priceh = json['priceh'];
    rname = json['Rname'];
    rtype = json['Rtype'];
    filterlocation = json['filterlocation'];
    bhk = json['bhk'];
    shortdis = json['shortdis'];
    furnished = json['furnished'];
    speci = json['speci'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TPid'] = this.tPid;
    data['Imagesh'] = this.imagesh;
    data['Tital'] = this.tital;
    data['locationh'] = this.locationh;
    data['priceh'] = this.priceh;
    data['Rname'] = this.rname;
    data['Rtype'] = this.rtype;
    data['filterlocation'] = this.filterlocation;
    data['bhk'] = this.bhk;
    data['shortdis'] = this.shortdis;
    data['furnished'] = this.furnished;
    data['speci'] = this.speci;
    data['details'] = this.details;
    return data;
  }
}