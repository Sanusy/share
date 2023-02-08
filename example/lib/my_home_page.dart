import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String versionCode = 'Not determined';
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Version code: $versionCode'),
            MaterialButton(
              onPressed: () {
                Share().getPlatformVersion().then((value) {
                  setState(() {
                    versionCode = value ?? 'Null returned';
                  });
                });
              },
              child: const Text('Get version'),
            ),
            MaterialButton(
              onPressed: () {
                Share()
                    .shareString('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
              },
              child: const Text('Share'),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                ImagePicker()
                    .pickImage(source: ImageSource.gallery)
                    .then((pickedImage) {
                  setState(() {
                    image = pickedImage;
                  });
                });
              },
              child: const Text('Get image'),
            ),
            MaterialButton(
              onPressed: image == null
                  ? null
                  : () {
                      Share().shareImage(image!.path);
                    },
              child: const Text('Share file'),
            ),
          ],
        ),
      ),
    );
  }
}
