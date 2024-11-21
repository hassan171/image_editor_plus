import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/data/shape_item.dart';

class ImageEditorShapes extends StatefulWidget {
  const ImageEditorShapes({super.key});

  @override
  State<ImageEditorShapes> createState() => _ImageEditorShapesState();
}

class _ImageEditorShapesState extends State<ImageEditorShapes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            ...ShapeType.values.map(
              (e) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(
                      context,
                      ShapeLayerData(
                        shape: e,
                        color: Colors.black,
                        filled: true,
                      ),
                    );
                  },
                  title: Text(
                    e.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
