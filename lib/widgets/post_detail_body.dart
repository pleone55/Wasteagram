import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/posts.dart';
import 'post_image.dart';

class PostDetailBody extends StatelessWidget {
  final Posts post;
  const PostDetailBody({ Key? key, required this.post }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return paddingWidget(context);
  }

  Widget paddingWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _paddingText(context)
          ],
        ),
      ),
    );
  }

  Widget _paddingText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Semantics(
              child: Text(
                DateFormat('EEE, MMM, dd yyyy').format(post.date), 
                style: const TextStyle(fontSize: 24, height: 2)
              ),
              label: 'Date of post creation',
            ),
          _boxedImage(context),
          Semantics(
            child: Text('Quantity: ${post.quantity.toString()}',
              style: const TextStyle(fontSize: 24, height: 5)
            ),
            label: 'Quantity of waste',
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Semantics(
                child: Text('Location: ${post.latitude.toString()}, ${post.longitude.toString()}',
                  style: const TextStyle(fontSize: 18)
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxedImage(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Semantics(
        child: Center(
          child: PostImage(imageUrl: post.imageUrl),
        ),
        image: true,
        label: 'Image of waste',
      ),
    );
  }
}