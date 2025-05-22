class OfferModel {
  String? id;
  String? restaurant;
  String? categoryName;
  String? parentCategory;
  String? dealTitle;
  String? discount;
  String? amount;
  String? description;
  String? image;
  String? quantity;
  String? status;
  String? createdAt;

  OfferModel(
      {this.id,
      this.restaurant,
      this.categoryName,
      this.parentCategory,
      this.dealTitle,
      this.discount,
      this.amount,
      this.description,
      this.image,
      this.quantity,
      this.status,
      this.createdAt});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurant = json['restaurant'];
    categoryName = json['category_name'];
    parentCategory = json['parent_category'];
    dealTitle = json['deal_title'];
    discount = json['discount'];
    amount = json['amount'];
    description = json['description'];
    image = json['image'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant'] = this.restaurant;
    data['category_name'] = this.categoryName;
    data['parent_category'] = this.parentCategory;
    data['deal_title'] = this.dealTitle;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
