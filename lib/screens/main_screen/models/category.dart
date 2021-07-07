
class CategoryModel {
  bool? status;
  CategoriesDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? CategoriesDataModel.fromJson(json['data'])
        : null;
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<CategoryData>? data;


  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }

  }
}

class CategoryData {
  int? id;
  String? name;
  String? image;

  CategoryData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
  }
}
