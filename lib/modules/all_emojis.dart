import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/data.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class Emojis extends StatefulWidget {
  const Emojis({super.key});

  @override
  createState() => _EmojisState();
}

class _EmojisState extends State<Emojis> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  i18n('Select Emoji'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 315,
              padding: const EdgeInsets.all(0.0),
              child: GridView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0.0,
                  maxCrossAxisExtent: 60.0,
                ),
                children: emojis.map((String emoji) {
                  return GridTile(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                        EmojiLayerData(
                          text: emoji,
                          size: 64.0,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 35),
                      ),
                    ),
                  ));
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
