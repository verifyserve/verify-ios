class loginUser {
  int? vvid;
  String? vname;
  String? vemail;
  String? vmobile;
  String? vpassword;
  String? vechicleNo;
  String? locationhai;
  String? Token;

  loginUser(
      {this.vvid,
        this.vname,
        this.vemail,
        this.vmobile,
        this.vpassword,
        this.vechicleNo,
        this.locationhai,
        this.Token});

  loginUser.fromJson(Map<String, dynamic> json) {
    vvid = json['Vid'];
    vname = json['Vname'];
    vemail = json['Vemail'];
    vmobile = json['Vmobile'];
    vpassword = json['Vpassword'];
    vechicleNo = json['Vechicle_no'];
    locationhai = json['Locationhai'];
    Token = json['Token_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Vid'] = this.vvid;
    data['Vname'] = this.vname;
    data['Vemail'] = this.vemail;
    data['Vmobile'] = this.vmobile;
    data['Vpassword'] = this.vpassword;
    data['Vechicle_no'] = this.vechicleNo;
    data['Locationhai'] = this.locationhai;
    data['Token_no'] = this.Token;
    return data;
  }
}