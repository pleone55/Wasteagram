import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import '../widgets/post_list.dart';
import '../models/image.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({ Key? key }) : super(key: key);

  static const routeName = '/';

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late File image;
  late String url;

  final imagePicker = ImagePicker();

  Future getFirebaseImage() async {
    final imagePicked = await imagePicker.pickImage(source: ImageSource.camera);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(Path.basename(imagePicked!.path) + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(imagePicked.path));
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL(); })
    .catchError((onError) => print(onError));
    setState(() {
      image = File(imagePicked.path);
    });
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
        centerTitle: true,
      ),
      floatingActionButton: Semantics(
        child: cameraFab(),
        button: true,
        enabled: true,
        onTapHint: 'Select an image from gallery to post',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const PostList(),
    );
  }

  Widget cameraFab() {
    return FloatingActionButton(
      onPressed: () async {
        await getFirebaseImage();
        Navigator.pushNamed(context, '/newPost', arguments: ImageClass(image: image, url: url));
      },
      child: const Icon(Icons.camera_enhance_outlined)
    );
  }

  void navigateNewPost(context) {
    Navigator.pushNamed(context, '/newPost');
  }
}