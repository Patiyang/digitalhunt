class PostModel {
  static final ID = 'id';
  static final TTILE = 'title';
  static final VIDEO_URL = 'video_url';
  static final IMAGE_URL = 'image_url';
  static final DESCRIPTION = 'description';
  static final CREATED_AT = 'created_at';

  final int id;
  final String title;
  final String video_url;
  final String image_url;
  final String created_at;

  PostModel({required this.id, required this.title, required this.video_url, required this.image_url, required this.created_at});
}
