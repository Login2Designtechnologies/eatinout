class RestaurantShortDetailModel {
  String? id;
  String? title;
  String? costTwo;
  String? sdesc;
  String? landmark;
  String? monthru;
  String? frisun;
  String? rate;
  String? restDistance;
  String? img;

  RestaurantShortDetailModel(
      {this.id,
      this.title,
      this.costTwo,
      this.sdesc,
      this.landmark,
      this.monthru,
      this.frisun,
      this.rate,
      this.restDistance,
      this.img});

  RestaurantShortDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    costTwo = json['cost_two'];
    sdesc = json['sdesc'];
    landmark = json['landmark'];
    monthru = json['monthru'];
    frisun = json['frisun'];
    rate = json['rate'];
    restDistance = json['rest_distance'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cost_two'] = this.costTwo;
    data['sdesc'] = this.sdesc;
    data['landmark'] = this.landmark;
    data['monthru'] = this.monthru;
    data['frisun'] = this.frisun;
    data['rate'] = this.rate;
    data['rest_distance'] = this.restDistance;
    data['img'] = this.img;
    return data;
  }
}
