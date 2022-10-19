import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostImage extends StatelessWidget {
  final imageUrl;

  const PostImage({ Key? key, required this.imageUrl }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: imageUrl),
        )
      ],
    );
  }
}