class SecoundHandCars {
  int? id;
  String? svimg;
  String? mname;
  String? locat;
  String? price;
  String? brand;
  String? smalldescript;
  String? bigdescript;
  String? descript;

  SecoundHandCars(
      {this.id,
        this.svimg,
        this.mname,
        this.locat,
        this.price,
        this.brand,
        this.smalldescript,
        this.bigdescript,
      this.descript});

  SecoundHandCars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    svimg = json['svimg'];
    mname = json['mname'];
    locat = json['locat'];
    price = json['price'];
    brand = json['brand'];
    smalldescript = json['Smalldescript'];
    bigdescript = json['Bigdescript'];
    descript = json['descript'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['svimg'] = this.svimg;
    data['mname'] = this.mname;
    data['locat'] = this.locat;
    data['price'] = this.price;
    data['brand'] = this.brand;
    data['Smalldescript'] = this.smalldescript;
    data['Bigdescript'] = this.bigdescript;
    data['descript'] = this.descript;
    return data;
  }
}