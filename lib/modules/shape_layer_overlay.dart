import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/modules/colors_picker.dart';

class ShapeLayerOverlay extends StatefulWidget {
  final int index;
  final ShapeLayerData layer;
  final Function onUpdate;
  const ShapeLayerOverlay({
    super.key,
    required this.layer,
    required this.index,
    required this.onUpdate,
  });

  @override
  State<ShapeLayerOverlay> createState() => _ShapeLayerOverlayState();
}

class _ShapeLayerOverlayState extends State<ShapeLayerOverlay> {
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //rotation
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      i18n('Rotation'),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          thumbColor: Colors.white,
                          value: widget.layer.rotation.clamp(0, 6.3),
                          min: 0.0,
                          max: 6.3,
                          onChangeEnd: (v) {
                            setState(() {
                              widget.layer.rotation = v.toDouble();
                              widget.onUpdate();
                            });
                          },
                          onChanged: (v) {
                            setState(() {
                              widget.layer.rotation = v.toDouble();
                              widget.onUpdate();
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.layer.rotation = 0;
                            widget.onUpdate();
                          });
                        },
                        child: Text(
                          i18n('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      i18n('Size'),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          thumbColor: Colors.white,
                          value: widget.layer.size.clamp(0, 100),
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
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.layer.size = 64;
                            widget.onUpdate();
                          });
                        },
                        child: Text(
                          i18n('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),

                  //filled switch
                  SwitchListTile(
                    title: const Text("Filled"),
                    // value: shapeType.filled,
                    value: widget.layer.filled,
                    onChanged: (value) {
                      setState(() {
                        widget.layer.filled = value;
                        widget.onUpdate();
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      i18n('Color'),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: BarColorPicker(
                          width: 300,
                          thumbColor: Colors.white,
                          initialColor: widget.layer.color,
                          cornerRadius: 10,
                          pickMode: PickMode.color,
                          colorListener: (int value) {
                            setState(() {
                              widget.layer.color = Color(value).withOpacity(widget.layer.color.opacity);
                              widget.onUpdate();
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.layer.color = Colors.black;
                            widget.onUpdate();
                          });
                        },
                        child: Text(
                          i18n('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      i18n('Opacity'),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          min: 0,
                          max: 1,
                          divisions: 100,
                          value: widget.layer.color.opacity,
                          thumbColor: Colors.white,
                          onChanged: (double value) {
                            setState(() {
                              // widget.layer.color.opacity = value;
                              widget.layer.color = widget.layer.color.withOpacity(value);
                              widget.onUpdate();
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            // widget.layer.backgroundOpacity = 0;
                            widget.layer.color = widget.layer.color.withOpacity(1);
                            widget.onUpdate();
                          });
                        },
                        child: Text(
                          i18n('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      removedLayers.add(layers.removeAt(widget.index));

                      Navigator.pop(context);
                      widget.onUpdate();
                      // back(context);
                      // setState(() {});
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
      ),
    );
  }
}
