class MenuModel {
  String? title;
  String? category;
  String? img;

  MenuModel({this.title, this.category, this.img});

  MenuModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    data['img'] = this.img;
    return data;
  }
}
