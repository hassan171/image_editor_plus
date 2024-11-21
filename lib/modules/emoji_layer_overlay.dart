import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class EmojiLayerOverlay extends StatefulWidget {
  final int index;
  final EmojiLayerData layer;
  final Function onUpdate;

  const EmojiLayerOverlay({
    super.key,
    required this.layer,
    required this.index,
    required this.onUpdate,
  });

  @override
  createState() => _EmojiLayerOverlayState();
}

class _EmojiLayerOverlayState extends State<EmojiLayerOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(i18n('Size Adjust').toUpperCase()),
          ),
          Slider(
              value: widget.layer.size,
              min: 0.0,
              max: 100.0,
              onChangeEnd: (v) {
                setState(() {
                  widget.layer.size = v.toDouble();
                  widget.onUpdate();
                });
              },
              onChanged: (v) {
                setState(() {
                  widget.layer.size = v.toDouble();
                  widget.onUpdate();
                });
              }),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    removedLayers.add(layers.removeAt(widget.index));
                    Navigator.pop(context);
                    widget.onUpdate();
                  },
                  child: Text(
                    i18n('Remove'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
