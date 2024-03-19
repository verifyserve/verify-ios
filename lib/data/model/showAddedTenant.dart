class ShowTenant {
  int? DPS_id;
  String? propertyImage;
  String? daddres;
  String? dfloor;
  String? dstate;
  String? tenantImage;
  String? dTanentname;
  String? ddate;
  String? drent;
  String? dSubid;
  String? dtype;
  String? aboutTanent;
  String? num;
  String? email;
  String? hometownlocation;

  ShowTenant(
      {this.DPS_id,
        this.propertyImage,
        this.daddres,
        this.dfloor,
        this.dstate,
        this.tenantImage,
        this.dTanentname,
        this.ddate,
        this.drent,
        this.dSubid,
        this.dtype,
        this.aboutTanent,
        this.num,
        this.email,
        this.hometownlocation});

  ShowTenant.fromJson(Map<String, dynamic> json) {
    //dTPid = json['DPS_id'];
    DPS_id = json['DPS_id'];
    propertyImage = json['PropertyImage'];
    daddres = json['PropertyAddress'];
    dfloor = json['Society'];
    dstate = json['City'];
    tenantImage = json['TenantImage'];
    dTanentname = json['Place'];
    ddate = json['Place'];
    drent = json['Drent'];
    dSubid = json['Place'];
    dtype = json['Property_type'];
    aboutTanent = json['AboutTanent'];
    email = json['email'];
    hometownlocation = json['Place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DTPid'] = this.DPS_id;
    data['PropertyImage'] = this.propertyImage;
    data['Daddres'] = this.daddres;
    data['Dfloor'] = this.dfloor;
    data['Dstate'] = this.dstate;
    data['TenantImage'] = this.tenantImage;
    data['DTanentname'] = this.dTanentname;
    data['Ddate'] = this.ddate;
    data['Drent'] = this.drent;
    data['DSubid'] = this.dSubid;
    data['Dtype'] = this.dtype;
    data['AboutTanent'] = this.aboutTanent;
    data['Num'] = this.num;
    data['email'] = this.email;
    data['hometownlocation'] = this.hometownlocation;
    return data;
  }
}