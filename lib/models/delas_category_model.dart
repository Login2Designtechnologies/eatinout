class DealsCategoryModel {
  String? id;
  String? categoryName;
  String? parentCategory;
  String? dealTitle;
  String? status;
  String? createdAt;

  DealsCategoryModel(
      {this.id,
      this.categoryName,
      this.parentCategory,
      this.dealTitle,
      this.status,
      this.createdAt});

  DealsCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    parentCategory = json['parent_category'];
    dealTitle = json['deal_title'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['parent_category'] = this.parentCategory;
    data['deal_title'] = this.dealTitle;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
