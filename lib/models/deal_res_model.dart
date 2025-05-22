class DealResModel {
  int? id;
  String? restaurant;
  String? categoryName;
  String? parentCategory;
  String? amount;
  String? dealImage;
  String? bannerImage;
  String? quantity;
  String? description;
  String? dealTitle;
  String? discount;
  int? status;
  String? createdAt;

  DealResModel(
      {this.id,
      this.restaurant,
      this.categoryName,
      this.parentCategory,
      this.amount,
      this.dealImage,
      this.bannerImage,
      this.quantity,
      this.description,
      this.dealTitle,
      this.discount,
      this.status,
      this.createdAt});

  DealResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurant = json['restaurant'];
    categoryName = json['category_name'];
    parentCategory = json['parent_category'];
    amount = json['amount'];
    dealImage = json['deal_image'];
    bannerImage = json['banner_image'];
    quantity = json['quantity'];
    description = json['description'];
    dealTitle = json['deal_title'];
    discount = json['discount'];
    status = json['status'];
    createdAt = json['created_at'];
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
    data['deal_title'] = this.dealTitle;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
