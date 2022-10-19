import 'package:flutter/material.dart';
import './screens/new_post_screen.dart';
import './screens/post_list_screen.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  static final routes = {
    NewPostScreen.routeName: (context) => const NewPostScreen(),
    PostListScreen.routeName: (context) => const PostListScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      routes: routes
    );
  }
}