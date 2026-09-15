import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_html/shims/dart_ui_real.dart';

class CustomCacheImage extends StatefulWidget {
  final String? imageUrl;
  final String? videoUrl;
  final String? avatarUrl;
  final String? contentType;
  final double radius;
  final bool? circularShape;
  // final String? mediaType;
  const CustomCacheImage({
    Key? key,
    required this.imageUrl,
    required this.radius,
    this.circularShape,
    this.contentType,
    // this.mediaType,
    this.avatarUrl,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<CustomCacheImage> createState() => _CustomCacheImageState();
}

class _CustomCacheImageState extends State<CustomCacheImage> {
  late Future<Uint8List?> _thumbnailFuture;
  final Map<String, Uint8List> thumbnailCache = {};
  @override
  void initState() {
    super.initState();
    _thumbnailFuture = Config().getVideoThumbnail(widget.videoUrl!);
  }

  @override
  void didUpdateWidget(covariant CustomCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoUrl != widget.videoUrl) {
      _thumbnailFuture =Config().getCachedThumbnail(widget.videoUrl!,thumbnailCache);
    }
  }

  @override
  Widget build(BuildContext context) {
    String contentType = widget.videoUrl!.isNotEmpty ? 'video' : 'article';

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(widget.radius),
        topRight: Radius.circular(widget.radius),
        bottomLeft: Radius.circular(widget.circularShape == false && widget.videoUrl!.isEmpty ? 0 : widget.radius),
        bottomRight: Radius.circular(widget.circularShape == false && widget.videoUrl!.isEmpty ? 0 : widget.radius),
      ),
      child: contentType == 'video' && widget.videoUrl!.contains('youtube')
          ? CachedNetworkImage(
              imageUrl: Config().getYoutubeThumbnail(widget.videoUrl!),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              placeholder: (context, url) => Container(color: Colors.grey[300]),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: contentType == 'article'
                    ? CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.avatarUrl!,
                        errorWidget: (context, url, error) => Center(child: Text('image not found'.tr(), style: TextStyle())),
                      )
                    : Icon(Icons.error),
              ),
            )
          // Image.network(getYoutubeThumbnail(widget.videoUrl!), fit: BoxFit.cover, height: MediaQuery.of(context).size.height)
          : contentType == 'video' && !widget.videoUrl!.contains('youtube')
          ? FutureBuilder<Uint8List?>(
              future: _thumbnailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Loading());
                }

                if (!snapshot.hasData) {
                  return Container(
                    color: Colors.grey[300],
                    child: contentType == 'article'
                        ? CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: widget.avatarUrl!,
                            errorWidget: (context, url, error) => Center(child: Text('image not found'.tr(), style: TextStyle())),
                          )
                        : Icon(Icons.error),
                  );
                }

                return Image.memory(snapshot.data!, fit: BoxFit.cover);
              },
            )
          // CachedNetworkImage(
          //     imageUrl: Config().get,
          //     fit: BoxFit.cover,
          //     height: MediaQuery.of(context).size.height,
          //     placeholder: (context, url) => Container(color: Colors.grey[300]),
          //     errorWidget: (context, url, error) => Container(
          //       color: Colors.grey[300],
          //       child: contentType == 'article'
          //           ? CachedNetworkImage(
          //               fit: BoxFit.contain,
          //               imageUrl: widget.avatarUrl!,
          //               errorWidget: (context, url, error) => Center(child: Text('image not found'.tr(), style: TextStyle())),
          //             )
          //           : Icon(Icons.error),
          //     ),
          //   )
          : CachedNetworkImage(
              imageUrl: widget.imageUrl!,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              placeholder: (context, url) => Container(color: Colors.grey[300]),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).primaryColorDark.withAlpha(50),
                child: widget.contentType == 'article'
                    ? CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.avatarUrl!,
                        errorWidget: (context, url, error) => Center(child: Text('image not found'.tr(), style: TextStyle())),
                      )
                    : Icon(Icons.error),
              ),
            ),
    );
  }

  // String getYoutubeThumbnail(String videoUrl) {
  //   final Uri? uri = Uri.tryParse(videoUrl);
  //   if (uri == null) {
  //     return '';
  //   }

  //   return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  // }
}
