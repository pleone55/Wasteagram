import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/posts.dart';
import '../models/image.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({ Key? key }) : super(key: key);

  static const routeName = '/newPost';

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final post = Posts();
  late LocationData locationData;
  
  @override
  Widget build(BuildContext context) {
    final ImageClass img = ModalRoute.of(context)?.settings.arguments as ImageClass;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: Semantics(
                child: SizedBox(
                  height: 380,
                  child: img.image == null ? const Text('No image') : Image.file(img.image),
                ),
                image: true,
                label: 'Image from camera'
              ),
            ),
            Semantics(
              child: inputField(),
              textField: true,
              enabled: true,
            )
          ],
        ),
      ),
      bottomNavigationBar: Semantics(
        child: uploadData(context, formKey, img),
        button: true,
        enabled: true,
        onTapHint: 'Upload new post',
      ),
    );
  }

  Widget inputField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(hintText: 'Enter number of waste'),
        style: const TextStyle(fontSize: 28),
        onSaved: (value) {
          post.quantity = int.parse(value!);
        },
        validator: (value) {
          if(value!.isEmpty) {
            return 'Enter the number of waste';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget uploadData(context, formKey, img) {
    return SizedBox(
      height: 75,
      child: ElevatedButton(
        onPressed: () async {
          if(formKey.currentState.validate()) {
            formKey.currentState.save();
            post.date = DateTime.now();
            locationData = await retrieveLocation();
            post.imageUrl = img.url;
            post.latitude = locationData.latitude!;
            post.longitude = locationData.longitude!;
            FirebaseFirestore.instance.collection('posts').add(post.toMap());
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.cloud_upload_outlined, size: 75),
      ),
    );
  }

  Future<LocationData> retrieveLocation() async {
    var locationService = Location();
    return await locationService.getLocation();
  }
}