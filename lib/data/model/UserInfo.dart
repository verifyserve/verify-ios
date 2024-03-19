/// status : "true"
/// data : [{"Vid":6,"Vname":"Kalakand","Vemail":"kalakand@gmail.com","Vmobile":"1234567890","Vpassword":"12345","Vechicle_no":"KT","Locationhai":"New york","Token_no":"fWg6FcNQTtepN1ogzHCzUd:APA91bEMUuIDlfRqBETMpdZo7mHweHCuPeIkX0Vt-ZeUczVmhpFwOqGoGxLNnTFdCSXMG9fuzRa2fFu9MwVcnRXBdYHGKiZfUSbRQaViDYXf_Pz5Lw09lTQxp9dmlueaaYaW8Pjq48Zj"}]

class Userinfo {
  Userinfo({
    String? status,
    List<Data>? data,}){
    _status = status;
    _data = data;
  }

  Userinfo.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  List<Data>? _data;
  Userinfo copyWith({  String? status,
    List<Data>? data,
  }) => Userinfo(  status: status ?? _status,
    data: data ?? _data,
  );
  String? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Vid : 6
/// Vname : "Kalakand"
/// Vemail : "kalakand@gmail.com"
/// Vmobile : "1234567890"
/// Vpassword : "12345"
/// Vechicle_no : "KT"
/// Locationhai : "New york"
/// Token_no : "fWg6FcNQTtepN1ogzHCzUd:APA91bEMUuIDlfRqBETMpdZo7mHweHCuPeIkX0Vt-ZeUczVmhpFwOqGoGxLNnTFdCSXMG9fuzRa2fFu9MwVcnRXBdYHGKiZfUSbRQaViDYXf_Pz5Lw09lTQxp9dmlueaaYaW8Pjq48Zj"

class Data {
  Data({
    num? vid,
    String? vname,
    String? vemail,
    String? vmobile,
    String? vpassword,
    String? vechicleNo,
    String? locationhai,
    String? tokenNo,}){
    _vid = vid;
    _vname = vname;
    _vemail = vemail;
    _vmobile = vmobile;
    _vpassword = vpassword;
    _vechicleNo = vechicleNo;
    _locationhai = locationhai;
    _tokenNo = tokenNo;
  }

  Data.fromJson(dynamic json) {
    _vid = json['Vid'];
    _vname = json['Vname'];
    _vemail = json['Vemail'];
    _vmobile = json['Vmobile'];
    _vpassword = json['Vpassword'];
    _vechicleNo = json['Vechicle_no'];
    _locationhai = json['Locationhai'];
    _tokenNo = json['Token_no'];
  }
  num? _vid;
  String? _vname;
  String? _vemail;
  String? _vmobile;
  String? _vpassword;
  String? _vechicleNo;
  String? _locationhai;
  String? _tokenNo;
  Data copyWith({  num? vid,
    String? vname,
    String? vemail,
    String? vmobile,
    String? vpassword,
    String? vechicleNo,
    String? locationhai,
    String? tokenNo,
  }) => Data(  vid: vid ?? _vid,
    vname: vname ?? _vname,
    vemail: vemail ?? _vemail,
    vmobile: vmobile ?? _vmobile,
    vpassword: vpassword ?? _vpassword,
    vechicleNo: vechicleNo ?? _vechicleNo,
    locationhai: locationhai ?? _locationhai,
    tokenNo: tokenNo ?? _tokenNo,
  );
  num? get vid => _vid;
  String? get vname => _vname;
  String? get vemail => _vemail;
  String? get vmobile => _vmobile;
  String? get vpassword => _vpassword;
  String? get vechicleNo => _vechicleNo;
  String? get locationhai => _locationhai;
  String? get tokenNo => _tokenNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Vid'] = _vid;
    map['Vname'] = _vname;
    map['Vemail'] = _vemail;
    map['Vmobile'] = _vmobile;
    map['Vpassword'] = _vpassword;
    map['Vechicle_no'] = _vechicleNo;
    map['Locationhai'] = _locationhai;
    map['Token_no'] = _tokenNo;
    return map;
  }
}