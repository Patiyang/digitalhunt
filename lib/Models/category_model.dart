class CategoryModel {
  final String categoryImage;
  final String categoryTitle;
  final String? categoryDescription;
  final String? district;

  CategoryModel({required this.categoryImage, required this.categoryTitle, this.categoryDescription = '', this.district = ''});
}
