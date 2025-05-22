class RestaurantModel {
  String? id;
  String? restaurant;
  String? categoryName;
  String? parentCategory;
  String? amount;
  String? dealImage;
  String? bannerImage;
  String? quantity;
  String? description;
  String? menu;
  String? dealTitle;
  String? discount;
  String? status;
  String? createdAt;
  String? title;
  String? img;
  String? rate;
  String? costTwo;
  String? lcode;
  String? mobile;
  String? sdesc;
  String? cuisinelist;
  String? facilitylist;
  String? address;
  String? pincode;
  String? landmark;
  String? latitude;
  String? longtitude;
  String? radius;
  String? monthru;
  String? mdesc;
  String? frisun;
  String? terms;
  String? sundesc;
  String? pdish;
  String? regDate;
  String? openTime;
  String? closeTime;
  String? tShow;
  String? email;
  String? password;
  String? showDark;

  RestaurantModel(
      {this.id,
      this.restaurant,
      this.categoryName,
      this.parentCategory,
      this.amount,
      this.dealImage,
      this.bannerImage,
      this.quantity,
      this.description,
      this.menu,
      this.dealTitle,
      this.discount,
      this.status,
      this.createdAt,
      this.title,
      this.img,
      this.rate,
      this.costTwo,
      this.lcode,
      this.mobile,
      this.sdesc,
      this.cuisinelist,
      this.facilitylist,
      this.address,
      this.pincode,
      this.landmark,
      this.latitude,
      this.longtitude,
      this.radius,
      this.monthru,
      this.mdesc,
      this.frisun,
      this.terms,
      this.sundesc,
      this.pdish,
      this.regDate,
      this.openTime,
      this.closeTime,
      this.tShow,
      this.email,
      this.password,
      this.showDark});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurant = json['restaurant'];
    categoryName = json['category_name'];
    parentCategory = json['parent_category'];
    amount = json['amount'];
    dealImage = json['deal_image'];
    bannerImage = json['banner_image'];
    quantity = json['quantity'];
    description = json['description'];
    menu = json['menu'];
    dealTitle = json['deal_title'];
    discount = json['discount'];
    status = json['status'];
    createdAt = json['created_at'];
    title = json['title'];
    img = json['img'];
    rate = json['rate'];
    costTwo = json['cost_two'];
    lcode = json['lcode'];
    mobile = json['mobile'];
    sdesc = json['sdesc'];
    cuisinelist = json['cuisinelist'];
    facilitylist = json['facilitylist'];
    address = json['address'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    radius = json['radius'];
    monthru = json['monthru'];
    mdesc = json['mdesc'];
    frisun = json['frisun'];
    terms = json['terms'];
    sundesc = json['sundesc'];
    pdish = json['pdish'];
    regDate = json['reg_date'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    tShow = json['t_show'];
    email = json['email'];
    password = json['password'];
    showDark = json['show_dark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant'] = this.restaurant;
    data['category_name'] = this.categoryName;
    data['parent_category'] = this.parentCategory;
    data['amount'] = this.amount;
    data['deal_image'] = this.dealImage;
    data['banner_image'] = this.bannerImage;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['menu'] = this.menu;
    data['deal_title'] = this.dealTitle;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['title'] = this.title;
    data['img'] = this.img;
    data['rate'] = this.rate;
    data['cost_two'] = this.costTwo;
    data['lcode'] = this.lcode;
    data['mobile'] = this.mobile;
    data['sdesc'] = this.sdesc;
    data['cuisinelist'] = this.cuisinelist;
    data['facilitylist'] = this.facilitylist;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['radius'] = this.radius;
    data['monthru'] = this.monthru;
    data['mdesc'] = this.mdesc;
    data['frisun'] = this.frisun;
    data['terms'] = this.terms;
    data['sundesc'] = this.sundesc;
    data['pdish'] = this.pdish;
    data['reg_date'] = this.regDate;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['t_show'] = this.tShow;
    data['email'] = this.email;
    data['password'] = this.password;
    data['show_dark'] = this.showDark;
    return data;
  }
}
