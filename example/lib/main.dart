import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ImageEditorExample(),
    ),
  );
}

class ImageEditorExample extends StatefulWidget {
  const ImageEditorExample({
    super.key,
  });

  @override
  createState() => _ImageEditorExampleState();
}

class _ImageEditorExampleState extends State<ImageEditorExample> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    // loadAsset("image.jpg");
  }

  void loadAsset(String name) async {
    var data = await rootBundle.load('assets/$name');
    setState(() => imageData = data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImageEditor Example"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(),
          if (imageData != null)
            Image.memory(
              imageData!,
              height: 300,
              width: 300,
            ),

          //select image
          ElevatedButton(
            child: const Text("Select image"),
            onPressed: () async {
              final result = await ImagePicker().pickImage(source: ImageSource.gallery);

              if (result != null) {
                imageData = await result.readAsBytes();
                setState(() {});
              }
            },
          ),

          const SizedBox(height: 16),
          if (imageData != null) ...[
            ElevatedButton(
              child: const Text("image editor"),
              onPressed: () async {
                var editedImage = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageEditor(
                      image: imageData,
                      cropOption: const CropOption(
                        reversible: false,
                      ),
                    ),
                  ),
                );

                // replace with edited image
                if (editedImage != null) {
                  imageData = editedImage;
                  setState(() {});
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
