import 'package:flutter/material.dart';
import '../models/posts.dart';
import '../widgets/post_detail_body.dart';

class PostDetailScreen extends StatelessWidget {
  final Posts post;

  const PostDetailScreen({ Key? key, required this.post }) : super(key: key);

  static const routeName = '/postDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
        centerTitle: true,
      ),
      body: PostDetailBody(post: post),
    );
  }
}