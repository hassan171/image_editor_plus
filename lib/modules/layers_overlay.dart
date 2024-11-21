import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/data/shape_item.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/modules/emoji_layer_overlay.dart';
import 'package:image_editor_plus/modules/image_layer_overlay.dart';
import 'package:image_editor_plus/modules/shape_layer_overlay.dart';
import 'package:image_editor_plus/modules/text_layer_overlay.dart';
import 'package:reorderables/reorderables.dart';

class ManageLayersOverlay extends StatefulWidget {
  final List<Layer> layers;
  final Function onUpdate;

  const ManageLayersOverlay({
    super.key,
    required this.layers,
    required this.onUpdate,
  });

  @override
  createState() => _ManageLayersOverlayState();
}

class _ManageLayersOverlayState extends State<ManageLayersOverlay> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: ReorderableColumn(
        onReorder: (oldIndex, newIndex) {
          var oi = layers.length - 1 - oldIndex, ni = layers.length - 1 - newIndex;

          // skip main layer
          if (oi == 0 || ni == 0) {
            return;
          }

          layers.insert(ni, layers.removeAt(oi));
          widget.onUpdate();
          setState(() {});
        },
        draggedItemBuilder: (context, index) {
          var layer = layers[layers.length - 1 - index];

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        if (layer is TextLayerData) {
                          return const Text('T');
                        }

                        if (layer is EmojiLayerData) {
                          return Text(layer.text);
                        }

                        if (layer is ShapeLayerData) {
                          return layer.shape.build(
                            color: layer.color,
                            filled: true,
                            size: layer.shape == ShapeType.circle ? 10 : 20,
                          );
                        }

                        if (layer is ShapeLayerData) {
                          return Text(layer.shape.name);
                        }

                        if (layer is ImageLayerData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              layer.image.bytes,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          );
                        }

                        if (layer is BackgroundLayerData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              layer.image.bytes,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          );
                        }

                        return const Text('');
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (layer is TextLayerData)
                      Text(
                        layer.text,
                      )
                    else
                      Text(
                        layer.runtimeType.toString(),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
        children: [
          for (var layer in layers.reversed)
            GestureDetector(
              key: Key('${layers.indexOf(layer)}:${layer.runtimeType}'),
              onTap: () {
                if (layer is BackgroundLayerData) return;

                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    if (layer is EmojiLayerData) {
                      return EmojiLayerOverlay(
                        index: layers.indexOf(layer),
                        layer: layer,
                        onUpdate: () {
                          widget.onUpdate();
                          setState(() {});
                        },
                      );
                    }

                    if (layer is ImageLayerData) {
                      return ImageLayerOverlay(
                        index: layers.indexOf(layer),
                        layerData: layer,
                        onUpdate: () {
                          widget.onUpdate();
                          setState(() {});
                        },
                      );
                    }

                    if (layer is TextLayerData) {
                      return TextLayerOverlay(
                        index: layers.indexOf(layer),
                        layer: layer,
                        onUpdate: () {
                          widget.onUpdate();
                          setState(() {});
                        },
                      );
                    }

                    if (layer is ShapeLayerData) {
                      return ShapeLayerOverlay(
                        index: layers.indexOf(layer),
                        layer: layer,
                        onUpdate: () {
                          widget.onUpdate();
                          setState(() {});
                        },
                      );
                    }

                    return Container();
                  },
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: Center(
                        child: Builder(
                          builder: (context) {
                            if (layer is TextLayerData) {
                              return const Text('T');
                            }

                            if (layer is EmojiLayerData) {
                              return Text(layer.text);
                            }

                            if (layer is ShapeLayerData) {
                              return layer.shape.build(
                                color: layer.color,
                                filled: true,
                                size: layer.shape == ShapeType.circle ? 10 : 20,
                              );
                            }

                            if (layer is ImageLayerData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  layer.image.bytes,
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                              );
                            }

                            if (layer is BackgroundLayerData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  layer.image.bytes,
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                              );
                            }

                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (layer is TextLayerData)
                          Text(
                            layer.text,
                          )
                        else
                          Text(
                            layer.runtimeType.toString(),
                          ),
                      ],
                    ),
                    const Spacer(),

                    if (layer is! BackgroundLayerData)
                      //delete button
                      IconButton(
                        onPressed: () {
                          layers.remove(layer);
                          widget.onUpdate();
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete, size: 22, color: Colors.red),
                      ),

                    //lock button
                    IconButton(
                      onPressed: () {
                        layer.locked = !layer.locked;
                        widget.onUpdate();
                        setState(() {});
                      },
                      icon: Icon(
                        layer.locked ? Icons.lock : Icons.lock_open,
                        size: 22,
                        color: layer.locked ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
