class commercialPGDetail {
  int? id;
  String? img;
  String? title;
  String? location;
  String? price;
  String? rname;
  String? rtype;
  String? lookingtype;
  String? filterlocation;
  String? bhk;
  String? shortdis;
  String? furnished;
  String? specification;
  String? details;
  String? foodAvailablity;
  String? gender;
  String? foodType;
  String? acNonAc;

  commercialPGDetail(
      {this.id,
        this.img,
        this.title,
        this.location,
        this.price,
        this.rname,
        this.rtype,
        this.lookingtype,
        this.filterlocation,
        this.bhk,
        this.shortdis,
        this.furnished,
        this.specification,
        this.details,
        this.foodAvailablity,
        this.gender,
        this.foodType,
        this.acNonAc,
      });

  commercialPGDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    title = json['title'];
    location = json['location'];
    price = json['price'];
    rname = json['Rname'];
    rtype = json['Rtype'];
    lookingtype = json['lookingtype'];
    filterlocation = json['filterlocation'];
    bhk = json['bhk'];
    shortdis = json['shortdis'];
    furnished = json['furnished'];
    specification = json['specification'];
    details = json['details'];
    foodAvailablity = json['food_availablity'];
    gender = json['gender'];
    foodType = json['food_type'];
    acNonAc = json['ac_non_ac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['title'] = this.title;
    data['location'] = this.location;
    data['price'] = this.price;
    data['Rname'] = this.rname;
    data['Rtype'] = this.rtype;
    data['lookingtype'] = this.lookingtype;
    data['filterlocation'] = this.filterlocation;
    data['bhk'] = this.bhk;
    data['shortdis'] = this.shortdis;
    data['furnished'] = this.furnished;
    data['specification'] = this.specification;
    data['details'] = this.details;
    data['food_availablity'] = this.foodAvailablity;
    data['gender'] = this.gender;
    data['food_type'] = this.foodType;
    data['ac_non_ac'] = this.acNonAc;
    return data;
  }
}