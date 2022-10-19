import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/post_detail_screen.dart';
import '../models/posts.dart';

class PostList extends StatelessWidget {
  const PostList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData &&
          snapshot.data!.docs.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return Semantics(
                  child: ListTile(
                    title: Text(_formatDate(post['date'])),
                    trailing: Text(post['quantity'].toString()),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PostDetailScreen(post: Posts.firebase(post)))
                      );
                    },
                  ),
                  onTapHint: 'View details of waste post that was created on ${_formatDate(post['date'])}',
                  label: '${post['quantity']} were wasted',
                  button: true,
                  enabled: true,
                  onTap: () {},
                ); 
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
              );
          }
      },
    );
  }

  String _formatDate(timestamp) {
    if(timestamp != DateTime) {
      DateTime time = DateTime.parse(timestamp.toDate().toString());
      return DateFormat('EEEEEE, MMMM, dd yyyy').format(time);
    } else {
      return DateFormat('MM/dd/yyyy - kk:mm').format(timestamp);
    }
  }
}