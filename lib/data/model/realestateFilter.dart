class RealStateFilters {
  int? tPid;
  String? imagesh;
  String? tital;
  String? locationh;
  String? priceh;
  String? bhk;
  String? shortdis;
  String? furnished;
  String? details;

  String? Buy_Rent;
  String? balcony;
  String? Parking;
  String? Lift;
  String? Security_guard;
  String? Goverment_meter;
  String? CCTV;
  String? Powerbackup;

  RealStateFilters(
      {this.tPid,
        this.imagesh,
        this.tital,
        this.locationh,
        this.priceh,
        this.bhk,
        this.shortdis,
        this.furnished,
        this.details,
        this.Buy_Rent,
        this.balcony,
        this.Parking,
        this.Lift,
        this.Security_guard,
        this.Goverment_meter,
        this.CCTV,
        this.Powerbackup});

  RealStateFilters.fromJson(Map<String, dynamic> json) {
    tPid = json['PVR_id'];
    imagesh = json['Realstate_image'];
    tital = json['Typeofproperty'];
    locationh = json['Place_'];
    priceh = json['Price'];
    bhk = json['Bhk_Squarefit'];
    shortdis = json['Building_information'];
    furnished = json['Furnished'];
    details = json['Details'];
    Buy_Rent = json['Buy_Rent'];
    balcony = json['balcony'];
    Parking = json['Parking'];
    Lift = json['Lift'];
    Security_guard = json['Security_guard'];
    Goverment_meter = json['Goverment_meter'];
    CCTV = json['CCTV'];
    Powerbackup = json['Powerbackup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TPid'] = this.tPid;
    data['Imagesh'] = this.imagesh;
    data['Tital'] = this.tital;
    data['locationh'] = this.locationh;
    data['priceh'] = this.priceh;
    data['bhk'] = this.bhk;
    data['shortdis'] = this.shortdis;
    data['furnished'] = this.furnished;
    data['details'] = this.details;

    data['Buy_Rent'] = this.Buy_Rent;
    data['balcony'] = this.balcony;
    data['Parking'] = this.Parking;
    data['Lift'] = this.Lift;
    data['Security_guard'] = this.Security_guard;
    data['Goverment_meter'] = this.Goverment_meter;
    data['CCTV'] = this.CCTV;
    data['Powerbackup'] = this.Powerbackup;
    return data;
  }
}