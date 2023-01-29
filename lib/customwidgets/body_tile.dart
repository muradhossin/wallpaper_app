import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/photo_view_page.dart';

class BodyTile extends StatelessWidget {
  final String imgUrl;
  const BodyTile({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, PhotoViewPage.routeName, arguments: imgUrl);
      },
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
      ),
    );
  }
}
