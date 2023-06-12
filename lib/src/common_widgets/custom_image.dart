import 'package:flutter/material.dart';

/// Custom image widget that loads an image as a static asset.
class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: Use [CachedNetworkImage] if the url points to a remote resource
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(imageUrl,fit: BoxFit.fitWidth,height: 140,),
      ));
  }
}
