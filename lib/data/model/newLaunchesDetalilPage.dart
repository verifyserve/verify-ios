class LaunchesDetailsPage {
  int? id;
  String? title;
  String? moterCC;
  String? fuleType;
  String? model;
  String? price;
  String? img;
  String? average;
  String? carType;
  String? discription;

  LaunchesDetailsPage(
      {this.id,
        this.title,
        this.moterCC,
        this.fuleType,
        this.model,
        this.price,
        this.img,
        this.average,
        this.carType,
        this.discription});

  LaunchesDetailsPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    moterCC = json['Moter_CC'];
    fuleType = json['FuleType'];
    model = json['model'];
    price = json['price'];
    img = json['img'];
    average = json['average'];
    carType = json['Car_Type'];
    discription = json['Discription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Moter_CC'] = this.moterCC;
    data['FuleType'] = this.fuleType;
    data['model'] = this.model;
    data['price'] = this.price;
    data['img'] = this.img;
    data['average'] = this.average;
    data['Car_Type'] = this.carType;
    data['Discription'] = this.discription;
    return data;
  }
}