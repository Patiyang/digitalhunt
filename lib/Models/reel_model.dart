class ReelModel {
  static const ID = 'id';
  static const TITLE = 'title';
  static const URL = 'url';
  static const DESCRIPTION = 'description';

  final int id;
  final String title;
  final String url;
  final String image;
  final String description;

  ReelModel({required this.id, required this.title, required this.url,required this.image, required this.description});
}
